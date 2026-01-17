class Node < Formula
  desc "Platform for building fast and scalable server applications"
  homepage "https://nodejs.org/"

  # This formula is configured to download the pre-compiled binary for macOS on Intel processors.
  # When Node.js 24 is released, update the URL and SHA256 to point to the correct darwin-x64 binary.
  # For now, we are using version 22.2.0 as an example.
  url "https://nodejs.org/dist/v22.2.0/node-v22.2.0-darwin-x64.tar.gz"
  sha256 "023b1856c198751515235a498f309a473f3095393b4a205d86248d2d6c138f61"

  def install
    # The pre-compiled binary tarball contains the 'bin', 'include', 'lib', and 'share' directories.
    # We simply copy all of that into the formula's installation directory (the "prefix").
    # Homebrew automatically handles the rest.
    prefix.install Dir["*"]
  end

  test do
    # This test block remains to verify that the installed `node` executable is working correctly.
    (testpath/"test.js").write "console.log('hello');"
    assert_equal "hello", shell_output("#{bin}/node test.js").strip
  end
end