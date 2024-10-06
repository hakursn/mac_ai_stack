# MacOS AI Stack

This repository contains scripts for setting up a Python-based AI development environment on macOS. The scripts automate the removal of existing AI libraries, installation of necessary tools, and configuration of a Python virtual environment.

## Features

- **Automated Installation**: The scripts automatically install essential libraries and dependencies for AI development, including TensorFlow, PyTorch, and Hugging Face Transformers.
- **Clean Environment**: They remove any existing installations to prevent conflicts and ensure a clean setup.

## Script

### `setup_ai_env_mac.sh`

This script is tailored for macOS. It performs the following actions:

- Removes existing AI libraries and dependencies.
- Installs essential build tools and libraries.
- Sets up a Python virtual environment.
- Installs popular AI libraries and frameworks, including TensorFlow, PyTorch, and others.

## Prerequisites

- A working installation of macOS.
- Homebrew must be installed (the script can install it if not present).

## Usage

1. Clone this repository:

   ```bash
   git clone https://github.com/hakursn/mac_ai_stack.git
   cd mac_ai_stack

2. Make the script executable:
    ```bash
    chmod +x setup_ai_env_mac.sh

3. Run the script:
    ```bash
    ./setup_ai_env_mac.sh

4. Follow the on-screen prompts to complete the installation.

## Notes
- The script may prompt for user confirmation before removing existing installations.

- To activate the Python virtual environment created by the script, use the command:
    ```bash
    source ~/ai_env/bin/activate
- If you encounter any issues, please check the permissions for the scripts and ensure that you have an active internet connection.