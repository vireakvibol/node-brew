class Node < Formula
  desc "Platform for building fast and scalable server applications"
  homepage "https://nodejs.org/"
  version "24.13.0"

  on_arm do
    url "https://nodejs.org/dist/v24.13.0/node-v24.13.0-darwin-arm64.tar.gz"
    sha256 "d595961e563fcae057d4a0fb992f175a54d97fcc4a14dc2d474d92ddeea3b9f8"
  end

  on_intel do
    url "https://nodejs.org/dist/v24.13.0/node-v24.13.0-darwin-x64.tar.gz"
    sha256 "6f03c1b48ddbe1b129a6f8038be08e0899f05f17185b4d3e4350180ab669a7f3"
  end

  def install
    # The tarball contains a directory like node-vX.Y.Z-darwin-ARCH
    # We need to install the contents of this directory.
    # The `libexec` directory is a good place for the extracted contents.
    # The `--strip-components=1` is crucial to remove the top-level directory.
    libexec.install Dir["*"]

    # Symlink the executables into Homebrew's bin directory
    bin.install_symlink Dir["#{libexec}/bin/*"]

    # If there are other directories like `share/man` or `include/node` that need to be symlinked
    # you would add similar lines here. For Node.js, `bin` is usually sufficient for basic usage.
  end

  test do
    (testpath/"test.js").write "console.log('hello');"
    assert_equal "hello", shell_output("#{bin}/node test.js").strip
  end
end
