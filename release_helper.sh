#!/bin/bash

# IMP CLI Release Helper
# This script automates version bumping, tagging, and Homebrew tap updates
# Based on DiskMan's release_helper.sh

set -e  # Exit on error

echo "🚀 Starting IMP CLI Release Process..."
echo ""

# 1. Get current version from setup.py
current_version=$(grep -m1 'version=' setup.py | sed 's/.*"\([^"]*\)".*/\1/')
echo "Current version: $current_version"

# 2. Ask for new version
read -p "Enter new version (or press Enter to keep $current_version): " new_version

if [ -n "$new_version" ] && [ "$new_version" != "$current_version" ]; then
    echo ""
    echo "Updating version to $new_version..."
    
    # Update setup.py
    sed -i '' 's/version="'$current_version'"/version="'$new_version'"/' setup.py
    
    # Verify the update worked
    updated_version=$(grep -m1 'version=' setup.py | sed 's/.*"\([^"]*\)".*/\1/')
    if [ "$updated_version" != "$new_version" ]; then
        echo "❌ ERROR: Failed to update setup.py"
        exit 1
    fi
    echo "  ✓ Updated setup.py"
    
    # Commit changes
    git add setup.py
    git commit -m "Bump version to $new_version"
    echo "  ✓ Committed changes"
    
    current_version=$new_version
fi

echo ""

# 3. Create Git Tag
echo "Creating git tag v$current_version..."
if git rev-parse "v$current_version" >/dev/null 2>&1; then
    echo "  Tag already exists. Force updating..."
    git tag -f "v$current_version"
else
    git tag "v$current_version"
fi

# 4. Push to GitHub
echo "Pushing to GitHub..."
git push origin main
git push -f origin "v$current_version"
echo "  ✓ Pushed to GitHub"

# 5. Calculate SHA256
echo ""
echo "--------------------------------------------------------"
echo "⏳ Waiting for GitHub to register the tag..."
sleep 3

tarball_url="https://github.com/SamSeenX/imp-cli/archive/refs/tags/v$current_version.tar.gz"
echo "Downloading: $tarball_url"
sha256=$(curl -sL "$tarball_url" | shasum -a 256 | awk '{print $1}')

echo ""
echo "✅ Release v$current_version published!"
echo "🔗 URL: $tarball_url"
echo "🔑 SHA256: $sha256"
echo "--------------------------------------------------------"

# 6. Update Homebrew Tap
TAP_DIR="../homebrew-apps"

if [ -d "$TAP_DIR" ]; then
    echo ""
    echo "🔄 Updating Homebrew Tap..."
    
    # Pull latest
    (cd "$TAP_DIR" && git pull)
    
    # Ensure Formula directory exists
    mkdir -p "$TAP_DIR/Formula"
    
    # Copy formula template
    cp brew/imp.rb "$TAP_DIR/Formula/imp.rb"
    
    # Update URL and SHA256 using escaped patterns
    sed -i '' "s|url \".*\"|url \"$tarball_url\"|g" "$TAP_DIR/Formula/imp.rb"
    sed -i '' "s|sha256 \".*\"|sha256 \"$sha256\"|g" "$TAP_DIR/Formula/imp.rb"
    
    echo "  ✓ Updated Formula/imp.rb"
    
    # Commit and push
    (cd "$TAP_DIR" && git add Formula/imp.rb && git commit -m "Update imp to v$current_version" && git push)
    
    echo ""
    echo "✅ Homebrew Tap updated successfully!"
    echo "👉 Users can now run: brew install SamSeenX/apps/imp"
else
    echo ""
    echo "⚠️  Could not find $TAP_DIR. Skipping Homebrew update."
    echo ""
    echo "🚨 MANUAL UPDATE REQUIRED 🚨"
    echo "1. Update 'url' to: $tarball_url"
    echo "2. Update 'sha256' to: $sha256"
    echo ""
    echo "Copy SHA to clipboard: echo '$sha256' | pbcopy"
fi

echo "--------------------------------------------------------"
echo "🎉 Release complete!"
echo "--------------------------------------------------------"
