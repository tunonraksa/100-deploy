# 100-Deploy

This repository contains the deployment setup for the "One Hundred Percent" challenge from Paradigm CTF 2023.

## Overview

The One Hundred Percent challenge is a smart contract challenge that involves:
- A Split contract (ERC721) that manages split wallets
- SplitWallet contracts that can hold ETH and ERC20 tokens
- A Challenge contract that needs to be solved

## Challenge Goal

The goal is to drain both the Split contract and the SplitWallet of all their ETH (100 ETH total).

## Project Structure

```
├── challenge/
│   ├── project/
│   │   ├── src/           # Smart contracts
│   │   ├── script/        # Deployment scripts
│   │   ├── lib/           # Dependencies
│   │   └── foundry.toml   # Foundry configuration
│   ├── challenge.py       # Challenge launcher
│   ├── docker-compose.yml # Docker setup
│   └── Dockerfile         # Docker configuration
└── challenge.yaml         # Challenge metadata
```

## Smart Contracts

- **Split.sol**: Main contract that manages splits and inherits from ERC721
- **SplitWallet.sol**: Cloneable wallet contract that holds funds
- **Challenge.sol**: Contract that defines the challenge success condition

## Deployment

This project is configured to deploy to Sepolia testnet using Foundry.

### Prerequisites

- Foundry installed
- Sepolia ETH (100+ ETH required for challenge)
- Sepolia RPC URL
- Etherscan API key

### Setup

1. Install dependencies:
   ```bash
   cd challenge/project
   forge install
   ```

2. Set environment variables:
   ```bash
   export SEPOLIA_RPC_URL="your_sepolia_rpc_url"
   export ETHERSCAN_API_KEY="your_etherscan_api_key"
   export PRIVATE_KEY="your_private_key"
   ```

3. Deploy:
   ```bash
   forge script script/Deploy.s.sol --rpc-url $SEPOLIA_RPC_URL --broadcast --verify
   ```

## Challenge Analysis

The challenge involves understanding how the split system works and finding a way to drain the 100 ETH that gets locked in during deployment.

## License

This project is for educational purposes as part of Paradigm CTF 2023.
