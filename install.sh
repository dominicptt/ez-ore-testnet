#!/bin/bash

# Update package lists and upgrade all packages
sudo apt update -y
sudo apt upgrade -y

# Install build-essential, curl, and git
sudo apt install -y build-essential curl git

# Install Rust using rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Install Solana CLI
sh -c "$(curl -sSfL https://release.solana.com/v1.18.20/install)"

# Export PATH for Solana and Rust
export PATH="$HOME/.local/share/solana/install/active_release/bin:$HOME/.cargo/bin:$PATH"

# Add PATH export to .bashrc for future sessions
echo 'export PATH="$HOME/.local/share/solana/install/active_release/bin:$HOME/.cargo/bin/$PATH"' >> ~/.bashrc

# Source the .bashrc to update the current shell environment
source ~/.bashrc

# Clone a specific branch of the Git repository
git clone -b extended_stats --single-branch https://github.com/pmcochrane/ore-cli.git ~/ore2/ore-cli

# Navigate to the cloned repository directory
cd ~/ore2/ore-cli

# Run the build_and_mine.sh script
./build_and_mine.sh

# Create necessary directories
mkdir -p ~/ore2/ore-cli/wallets

# Key setup script
function generate_new_key() {
    echo "Generating a new Solana keypair..."
    solana-keygen new --outfile ~/ore2/ore-cli/wallets/wallet_devnet_test1.json
    echo "New keypair generated and saved to ~/ore2/ore-cli/wallets/wallet_devnet_test1.json"
    
    # Extract the public key
    public_key=$(solana-keygen pubkey ~/ore2/ore-cli/wallets/wallet_devnet_test1.json)
    
    # Request an airdrop
    echo "Requesting an airdrop of 1 SOL to $public_key..."
    solana airdrop 1 "$public_key" --url https://api.devnet.solana.com
    echo "Airdrop completed."
}

function input_existing_key() {
    echo "Enter your existing keypair JSON text:"
    read -r keypair_json
    mkdir -p ~/.config/solana
    echo "$keypair_json" > ~/ore2/ore-cli/wallets/wallet_devnet_test1.json
    echo "Existing keypair saved to ~/ore2/ore-cli/wallets/wallet_devnet_test1.json"
}

# Choose key setup option
echo "Choose an option:"
echo "1. Generate a new Solana keypair"
echo "2. Input an existing keypair"
echo "3. Skip key setup"

read -p "Enter 1, 2, or 3: " choice

case $choice in
    1)
        generate_new_key
        ;;
    2)
        input_existing_key
        ;;
    3)
        echo "Skipping key setup."
        ;;
    *)
        echo "Invalid choice. Please enter 1, 2, or 3."
        exit 1
        ;;
esac
