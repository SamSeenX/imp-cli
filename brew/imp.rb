class Imp < Formula
  include Language::Python::Virtualenv

  desc "IMP - Image Optimizer CLI Tool"
  homepage "https://github.com/SamSeenX/imp-cli"
  url "https://github.com/SamSeenX/imp-cli/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "d048cb1eba4f6e63b8e65520c417947268a2c7501f006596520306ca7534f138"
  license "MIT"

  depends_on "python@3.11"
  depends_on "jpeg"
  depends_on "libtiff"
  depends_on "little-cms2"
  depends_on "webp"
  depends_on "zlib"

  resource "pillow" do
    url "https://files.pythonhosted.org/packages/f3/af/c097e544e7bd278333db77933e535098c259609c4eb3b85381109602fb5b/pillow-11.1.0.tar.gz"
    sha256 "368da70808b36d73b4b390a8ffac11069f8a5c85f29eff1f1b01bcf3ef5b2a20"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/fb/d2/8920e102050a0de7bfabeb4c4614a49248cf8d5d7a8d01885fbb24dc767a/rich-14.2.0.tar.gz"
    sha256 "73ff50c7c0c1c77c8243079283f4edb376f0f6442433aecb8ce7e6d0b92d1fe4"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/5b/f5/4ec618ed16cc4f8fb3b701563655a69816155e79e24a17b651541804721d/markdown_it_py-4.0.0.tar.gz"
    sha256 "cb0a2b4aa34f932c007117b194e945bd74e0ec24133ceb5bac59009cda1cb9f3"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3efefba235e65cdeb9c84d24a8293ba1d90/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/b0/77/a5b8c569bf593b0140bde72ea885a803b82086995367bf2037de0159d924/pygments-2.19.2.tar.gz"
    sha256 "636cb2477cec7f8952536970bc533bc43743542f70392ae026374600add5b887"
  end

  def install
    virtualenv_install_with_resources
    
    # Link the script
    bin.install_symlink libexec/"bin/imp"
  end

  def caveats
    <<~EOS
      ----------------------------------------------------------------------
      🎉 IMP - Image Optimizer Installed Successfully! 🎉
      ----------------------------------------------------------------------
      
      🚀 To run IMP, just type:
      
        imp <image_or_folder>

      📖 For help:
      
        imp --help

      🔗 Website: https://imp-cli.samseen.dev
      ----------------------------------------------------------------------
    EOS
  end

  test do
    system "#{bin}/imp", "--help"
  end
end
