# Whale Alert Trap for Drosera Network

Advanced smart contract trap that monitors large transfers (>$10K) and detects whale activity in DeFi.

## Features
- 🐋 Real-time whale transfer monitoring
- 💰 $10,000+ threshold detection
- 🔍 Advanced WhaleAlert data structures
- ⚡ Discord-compatible response system
- 🚀 Built for Drosera Network

## Contracts
- **WhaleAlertTrap**: `0xa81b7f5d3da9b70b79abb7274f8e73ba9e6a3140`
- **ResponseContract**: `0x25E2CeF36020A736CF8a4D2cAdD2EBE3940F4608`

## Deployment
```bash
forge create src/SergeantTrap.sol:SergeantTrap --rpc-url https://ethereum-hoodi-rpc.publicnode.com --private-key $PRIVATE_KEY
