# Custom Homebrew Formula for Node.js

This project is an example of how to create and maintain a custom [Homebrew](https://brew.sh/) formula for Node.js. It includes a formula file for a specific version of Node.js and a GitHub Actions workflow to automatically test it on macOS.

This is particularly useful for developers who need to package custom versions of software or test formula changes before submitting them to the official Homebrew repositories.

## The Homebrew Formula: `node.rb`

The core of this project is the `node.rb` file. This is a Ruby script that defines how Homebrew should download, compile, and install Node.js.

Here is a breakdown of the key components of the formula:

| Part         | Description                                                                                             |
|--------------|---------------------------------------------------------------------------------------------------------|
| `desc`       | A short description of the software.                                                                    |
| `homepage`   | The official website for the software.                                                                  |
| `url`        | The direct URL to the source code tarball (`.tar.gz`).                                                  |
| `sha256`     | The SHA-256 checksum of the downloaded tarball. Homebrew uses this to verify the integrity of the file.   |
| `depends_on` | Lists any other Homebrew formulas that are required to build this software.                             |
| `install`    | A block of Ruby code that runs the shell commands needed to build and install the software.             |
| `test`       | A block that defines a simple, automated test to run after installation to verify it works correctly.   |

### How the Installation Works

The `install` block contains the main logic:

1.  `system "./configure", "--prefix=#{prefix}"`: This command runs the `configure` script included with the Node.js source code. The `--prefix` flag is crucial, as it tells the script to prepare the software for installation inside the special, isolated directory that Homebrew manages for this formula.
2.  `system "make", "install"`: This runs the standard `make install` command, which compiles the source code and copies the finished files into the installation directory specified by the prefix.

### Local Testing

To test the formula on a local macOS machine, you would run the following commands:

-   `brew install --build-from-source ./node.rb`: This command forces Homebrew to download the source from the specified `url` and build it locally, rather than trying to find a pre-compiled version (a "bottle").
-   `brew test ./node.rb`: This runs the code inside the `test do` block of your formula to confirm that the software is installed and executable.

## Continuous Integration with GitHub Actions

The `.github/workflows/main.yml` file sets up a continuous integration (CI) pipeline that automatically tests the formula. This is essential for verifying the formula on a clean macOS environment, especially when developing on a different OS like Windows.

### How It Works

-   **Trigger**: The workflow is configured to run on every `push` and `pull_request` to the repository.
-   **Environment**: It runs on a `macos-latest` virtual machine provided by GitHub, ensuring the test environment is consistent and matches the target platform.

### The Steps

1.  **Set up Homebrew (`Homebrew/actions/setup-homebrew@master`)**: This is an official action from Homebrew that installs and configures all the necessary Homebrew tools on the virtual machine.
2.  **Check out repository (`actions/checkout@v4`)**: This action downloads a copy of your repository's code into the virtual machine so the workflow can access the `node.rb` file.
3.  **Run brew test-bot (`brew test-bot --only-formulae`)**: This is the most important step. `brew test-bot` is the same command the official Homebrew project uses to test its formulas. It performs a comprehensive check, including:
    -   Validating the formula's syntax.
    -   Installing any dependencies.
    -   Building and installing the formula.
    -   Running the formula's `test` block.
    
If any of these steps fail, the GitHub Actions workflow will report an error, letting you know that your formula needs to be fixed.
