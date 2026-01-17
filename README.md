# Custom Homebrew Formula for Node.js

This repository provides a custom [Homebrew](https://brew.sh/) formula to install a specific version of Node.js from its pre-compiled binary.

## Supported Configuration

This formula is specifically configured for the following environment:

- **Operating System:** macOS (Intel & Apple Silicon)
- **Node.js Version:** 24.13.0

## How to Install

1.  **Tap the Repository:**
    ```sh
    brew tap vireakvibol/node-brew
    ```

2.  **Install Node.js:**
    ```sh
    brew install node
    ```

## Continuous Integration with GitHub Actions

This repository uses GitHub Actions to automatically test the formula. The workflow, defined in `.github/workflows/main.yml`, ensures that the formula correctly installs the Node.js binary on a macOS environment.
