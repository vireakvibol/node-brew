class Node < Formula
  desc "Platform for building fast and scalable server applications"
  homepage "https://nodejs.org/"
  # The user requested a formula for Node.js 24.
  # When Node.js 24 is released, you can update the URL and SHA256 below.
  # For now, we are using version 22.2.0 as an example.
  url "https://nodejs.org/dist/v22.2.0/node-v22.2.0.tar.gz"
  sha256 "9857386001004313b3aebd8885b5c97753177c681c741e93864b97143f62886f"

  # Node.js requires Python for its build process.
  depends_on "python@3.12" => :build

  def install
    # These commands are the standard way to build and install Node.js from source.
    # The `--prefix` flag ensures it gets installed into the correct Homebrew directory.
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    # This block defines a simple test to verify that the `node` executable is working correctly.
    # It writes a small JavaScript file and then executes it, checking for the expected output.
    (testpath/"test.js").write "console.log('hello');"
    assert_equal "hello", shell_output("#{bin}/node test.js").strip
  end
end
