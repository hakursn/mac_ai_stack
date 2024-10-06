#!/bin/bash

# Function to remove existing installations
remove_existing_ai_software() {
    echo "Removing existing AI libraries and dependencies on macOS..."

    # Remove Homebrew packages
    brew uninstall --ignore-dependencies --force python3 tensorflow torch

    # Remove any lingering Python packages
    pip uninstall -y tensorflow torch torchvision torchaudio transformers datasets scikit-learn pandas numpy matplotlib gym jupyterlab jupyter_contrib_nbextensions

    # Remove existing Python environments
    rm -rf ~/"$1"

    # Clean up Homebrew
    brew cleanup

    echo "Existing AI software removed."
}

# Function to install fresh AI libraries
install_ai_software() {
    # Install Homebrew if not installed
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # Update Homebrew
    brew update

    # Install essential build tools and libraries
    echo "Installing essential tools and libraries..."
    brew install cmake git wget python3

    # Set up a Python virtual environment if requested
    if [[ "$1" == "y" ]]; then
        echo "Setting up a Python virtual environment..."
        python3 -m venv ~/"$2"
        source ~/"$2"/bin/activate
    fi

    # Upgrade pip and setuptools
    pip install --upgrade pip setuptools wheel

    # Install TensorFlow with Mac support
    echo "Installing TensorFlow (optimized for macOS)..."
    if [[ $(uname -m) == "arm64" ]]; then
        # M1/M2 Macs with Apple Silicon
        pip install tensorflow-macos tensorflow-metal
    else
        # Intel-based Macs
        pip install tensorflow
    fi

    # Install PyTorch with Metal support (for macOS)
    echo "Installing PyTorch (optimized for macOS)..."
    pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

    # Install Hugging Face Transformers and Datasets libraries
    echo "Installing Hugging Face Transformers and Datasets..."
    pip install transformers datasets

    # Install OpenAI's Gym (for reinforcement learning)
    echo "Installing Gym..."
    pip install gym

    # Install additional libraries: scikit-learn, pandas, numpy, and matplotlib
    echo "Installing additional libraries (scikit-learn, pandas, numpy, matplotlib)..."
    pip install scikit-learn pandas numpy matplotlib

    # Install Jupyter Notebook and extensions
    echo "Installing Jupyter Notebook and extensions..."
    pip install jupyter jupyterlab jupyter_contrib_nbextensions

    # Clean up Homebrew packages
    echo "Cleaning up Homebrew..."
    brew cleanup

    echo "Installation complete! To activate the virtual environment, use: source ~/${2}/bin/activate"
}

# Prompt user for action
read -p "Do you want to remove existing AI software before installation? [y/n]: " user_choice
if [[ "$user_choice" == "y" ]]; then
    remove_existing_ai_software "ai_env"
fi

# Ask if the user wants to create a virtual environment
read -p "Do you want to set up a Python virtual environment? [y/n]: " setup_venv
if [[ "$setup_venv" == "y" ]]; then
    read -p "Enter the name of the virtual environment: " venv_name
else
    venv_name=""
fi

# Proceed with installation
install_ai_software "$setup_venv" "$venv_name"
