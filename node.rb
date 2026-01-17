class Node < Formula
  desc "Platform for building fast and scalable server applications"
  homepage "https://nodejs.org/"

  # To create a bottle, we MUST build from the source code tarball.
  # The GitHub Action will compile this once and create the bottle from it.
  url "https://nodejs.org/dist/v24.0.0/node-v24.0.0.tar.gz"
  # This is a placeholder SHA256. You must update it when v24 is officially released.
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  # Add back the build dependency, as we are compiling from source again.
  depends_on "python@3.12" => :build

  # This block will be automatically filled by the GitHub Action
  # with the bottle's URL and checksum.
  bottle do
  end

  def install
    # Use the standard build process.
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.js").write "console.log('hello');"
    assert_equal "hello", shell_output("#{bin}/node test.js").strip
  end
end