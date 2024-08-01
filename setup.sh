#!/bin/bash

# Navigate to the cloned repository directory
cd ~/ore2/ore-cli

# Copy ore_env.priv.sh.sample to ore_env.priv.sh
cp ~/ore2/ore-cli/ore_env.priv.sh.sample ~/ore2/ore-cli/ore_env.priv.sh

# Request input from the user for the necessary fields
read -p "Enter your Coingecko API key: " COINGECKO_APIKEY
read -p "Enter the RPC URL for Miner 1: " RPC1
read -p "Enter the number of threads for Miner 1 (default 3): " THREADS1
THREADS1=${THREADS1:-3}  # Default to 3 if no input is provided
read -p "Enter the desired difficulty level for Miner 1 (default 8): " DESIRED_DIFFICULTY_LEVEL1
DESIRED_DIFFICULTY_LEVEL1=${DESIFFICULTY_LEVEL1:-8}  # Default to 8 if no input is provided

# Write the user input into ore_env.priv.sh
cat <<EOL > ~/ore2/ore-cli/ore_env.priv.sh
# This is just a sample file to show what is expected
# to be in ore_env.priv.sh
# Copy or rename this and fill in according to your miners
# At least 1 miner must be configured for the scripts to operate.

# Your personal coingecko API key to allow looking up ORE & SOL prices to estimate profitablility
COINGECKO_APIKEY=$COINGECKO_APIKEY
# Cost in dollars for using 1000W of energy every hour (from electric bill)
ELECTRICITY_COST_PER_KILOWATT_HOUR=0.40

# Miner 1 Config
#======================================================================================================
# path to where the wallet keyfile is located
KEY1=~/ore2/ore-cli/wallets/wallet_devnet_test1.json
# RPC URL to use for the mine
RPC1=$RPC1
# Threads for this miner
THREADS1=$THREADS1
# Assign you overpayment amount of LAMPORTS (SOL) to assist transactions landing successfully
PRIORITY_FEE1=0
# The energy that this miner uses on average. Read from a watt meter and used to calculate how much electric costs are required to mine
MINER_WATTAGE_IDLE1=15
MINER_WATTAGE_BUSY1=80
# The amount of time per minute that you want to allow for non-mining activities
BUFFER_TIME1=1
# The difficulty level you would expect this miner to achieve
DESIRED_DIFFICULTY_LEVEL1=$DESIRED_DIFFICULTY_LEVEL1

# Miner 2 config
#======================================================================================================
RPC2=https://url.to.rpc.here
KEY2=~/.config/solana/wallet_devnet2.json
PRIORITY_FEE2=40
THREADS2=2
MINER_WATTAGE_IDLE2=15
MINER_WATTAGE_BUSY2=80
BUFFER_TIME2=2
DESIRED_DIFFICULTY_LEVEL2=13

# Miner 3 config
#======================================================================================================
RPC3=https://url.to.rpc.here
KEY3=~/.config/solana/wallet_devnet3.json
PRIORITY_FEE3=4000
THREADS3=4
MINER_WATTAGE_IDLE3=15
MINER_WATTAGE_BUSY3=80
BUFFER_TIME3=2
DESIRED_DIFFICULTY_LEVEL3=13
EOL

echo "Configuration complete and saved to ~/ore2/ore-cli/ore_env.priv.sh"
