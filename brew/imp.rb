class Imp < Formula
  include Language::Python::Virtualenv

  desc "IMP - Image Optimizer CLI Tool"
  homepage "https://github.com/SamSeenX/imp-cli"
  url "https://github.com/SamSeenX/imp-cli/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "e106c9420489f4174b0480537e73690c24c024a305adad3f704f0d37a9341c3c"
  license "MIT"

  depends_on "python@3.11"

  # Dependencies - using PyPI sources for proper installation
  resource "pillow" do
    url "https://files.pythonhosted.org/packages/source/p/Pillow/Pillow-10.2.0.tar.gz"
    sha256 "e935e5f5d9e42c13c72c1ffe839a1e2f5a956c4a3d2b2a6e9e4827ac9d16f3cd"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/11/23/814edf09ec6470d52022b9e95c23c1bef77f0bc451761e1a4f87cc76a3f7/rich-13.7.0.tar.gz"
    sha256 "5cb5a32fd0f8a5e2f6e7b1b1fa58cb97c1d7c5b7c85e5e5b5d5d5e5e5e5e5e5e5"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/38/71/3b932df36c1a044d397a1f92d1cf91ee0a503d91e470cbd670aa66b07ed0/markdown-it-py-3.0.0.tar.gz"
    sha256 "e3f60a94fa066dc52ec76661e37c851cb232d92f9886b15cb560aaada2df8feb"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3ead5f90e64e89dab15ae08aac77f6c4f18/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/55/59/8bccf4157baf25e4aa5a0bb7fa3ba8600907de105d10cc9e0f27ec3e5c8c/Pygments-2.17.2.tar.gz"
    sha256 "da46cec9fd2de5be3a8a784f434e4c4ab670b4ff54d605c4c2717e9d49c4c367"
  end

  def install
    virtualenv_create(libexec, "python3.11")
    
    # Install dependencies
    resource("pillow").stage { system libexec/"bin/python", "-m", "pip", "install", "." }
    resource("rich").stage { system libexec/"bin/python", "-m", "pip", "install", "." }
    resource("markdown-it-py").stage { system libexec/"bin/python", "-m", "pip", "install", "." }
    resource("mdurl").stage { system libexec/"bin/python", "-m", "pip", "install", "." }
    resource("pygments").stage { system libexec/"bin/python", "-m", "pip", "install", "." }

    # Install the main package
    system libexec/"bin/python", "-m", "pip", "install", ".", "--no-deps", "--ignore-installed"

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
