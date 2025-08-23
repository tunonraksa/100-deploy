# Sepolia Deployment Guide

This guide will walk you through deploying the One Hundred Percent challenge to Sepolia testnet.

## Prerequisites

1. **Foundry installed** - Make sure you have Foundry installed on your system
2. **Sepolia ETH** - You need at least 0.01 ETH + gas fees for testing (approximately 0.02-0.03 ETH total)
3. **Sepolia RPC URL** - From providers like Infura, Alchemy, or QuickNode
4. **Etherscan API key** - For contract verification
5. **Private key** - The private key of the wallet you want to deploy from

## Setup

### 1. Install Dependencies

```bash
cd challenge/project
forge install
```

### 2. Set Environment Variables

Create a `.env` file in the `challenge/project` directory:

```bash
# Required for deployment
SEPOLIA_RPC_URL="https://sepolia.infura.io/v3/YOUR_PROJECT_ID"
ETHERSCAN_API_KEY="YOUR_ETHERSCAN_API_KEY"
PRIVATE_KEY="YOUR_PRIVATE_KEY_WITHOUT_0x_PREFIX"
```

Or export them directly:

```bash
export SEPOLIA_RPC_URL="https://sepolia.infura.io/v3/YOUR_PROJECT_ID"
export ETHERSCAN_API_KEY="YOUR_ETHERSCAN_API_KEY"
export PRIVATE_KEY="YOUR_PRIVATE_KEY_WITHOUT_0x_PREFIX"
```

### 3. Verify Your Balance

Make sure your wallet has sufficient Sepolia ETH:

```bash
forge script script/Deploy.s.sol --rpc-url $SEPOLIA_RPC_URL --dry-run
```

This will show your account balance and estimate gas costs.

## Deployment

### Option 1: Deploy and Verify (Recommended)

```bash
forge script script/Deploy.s.sol \
  --rpc-url $SEPOLIA_RPC_URL \
  --broadcast \
  --verify \
  --etherscan-api-key $ETHERSCAN_API_KEY
```

### Option 2: Deploy Only (No Verification)

```bash
forge script script/Deploy.s.sol \
  --rpc-url $SEPOLIA_RPC_URL \
  --broadcast
```

### Option 3: Simulate Deployment (Dry Run)

```bash
forge script script/Deploy.s.sol \
  --rpc-url $SEPOLIA_RPC_URL \
  --dry-run
```

## What Happens During Deployment

1. **Split Contract** - Deployed first (ERC721 contract)
2. **Split Creation** - A split is created with 50/50 distribution to dead addresses
3. **0.01 ETH Deposit** - 0.01 ETH is deposited into the split wallet (scaled down for testing)
4. **Challenge Contract** - Deployed and linked to the Split contract

## Expected Output

```
Deploying from address: 0x...
Account balance: 0.5 ETH
Deploying Split contract...
Split deployed at: 0x...
Creating split with 0.01 ETH...
Split created with ID: 0
SplitWallet deployed at: 0x...
Depositing 0.01 ETH into split wallet...
0.01 ETH deposited successfully
Deploying Challenge contract...
Challenge deployed at: 0x...

=== DEPLOYMENT SUMMARY ===
Split contract: 0x...
Challenge contract: 0x...
SplitWallet: 0x...
Split ID: 0
0.01 ETH locked in split wallet
Deployer: 0x...
===========================
```

## Post-Deployment

1. **Verify contracts** on Sepolia Etherscan
2. **Check balances** - The Split contract and SplitWallet should have 0 ETH
3. **Start solving** - The challenge is now live on Sepolia!

## Gas Estimation

- **Total deployment**: ~500,000 - 1,000,000 gas
- **Current Sepolia gas prices**: ~1-10 gwei
- **Estimated gas cost**: 0.0005 - 0.01 ETH

## Testing vs Production

- **Current setup**: 0.01 ETH (for testing and development)
- **Production setup**: 100 ETH (original challenge amount)
- **To scale up**: Simply change `0.01 ether` to `100 ether` in `script/Deploy.s.sol`

## Troubleshooting

### Common Issues

1. **Insufficient balance**: Make sure you have 0.01+ ETH
2. **RPC errors**: Check your Sepolia RPC URL
3. **Gas estimation failures**: Try increasing gas limit
4. **Verification failures**: Check your Etherscan API key

### Getting Sepolia ETH

- **Paradigm faucet**: https://faucet.paradigm.xyz/
- **Alchemy faucet**: https://sepoliafaucet.com/
- **Infura faucet**: https://www.infura.io/faucet/sepolia

## Security Notes

⚠️ **IMPORTANT**: 
- Never share your private key
- Use a dedicated wallet for testing
- The 0.01 ETH will be locked in the contract
- Only deploy if you're ready to solve the challenge

## Challenge Goal

After deployment, you need to drain both the Split contract and the SplitWallet of all their ETH (0.01 ETH total) to solve the challenge.

## Scaling Up for Production

When you're ready to deploy with the full 100 ETH challenge:

1. Edit `script/Deploy.s.sol`
2. Change `0.01 ether` to `100 ether`
3. Ensure you have 100+ Sepolia ETH
4. Deploy as normal

## Using the Original CTF Script

We're using the original `Deploy.s.sol` script which:
- ✅ Inherits from `CTFDeployment` for proper framework integration
- ✅ Has been tested and verified with the original challenge
- ✅ Creates the split with ID 0 as expected by the Challenge contract
- ✅ Is ready for both testing (0.01 ETH) and production (100 ETH) deployments
