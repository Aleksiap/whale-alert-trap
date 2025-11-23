# Whale Alert Trap for Drosera 

Advanced smart contract trap that monitors large transfers in both ETH and ERC-20 tokens.

- 🐋 Real-time whale transfer monitoring**
- 💰 $50,000+ threshold for ERC-20 tokens** (updated with explicit decimals)
- ⚡ 2+ ETH threshold for native ETH transfers** 
- 🔍 Advanced WhaleAlert data structures**
- 🛡️ Production safety features** (empty blob guards, try/catch protection)
- 🏗️ Separate contract architecture** (StatusSource + ResponseContract)
- 🚀 Built for Drosera Network**

## Contracts
- SergeantTrap: `0xa81b7f5d3da9b70b79abb7274f8e73ba9e6a3140`
- ResponseContract: `0xC6EFE7E82dda80Bb4A1637296F3F98424Ea9c0Be` (updated)
- StatusSource: `0x7aCf4DDA2BA8cbac1f644A271881975B45c28017` (new)
- DiscordTrap: `0x04416670dF4836D5da579B24B3F642076251393A` (new)

## Monitoring
- ERC-20 Tokens: Transfers > $50,000 USD (updated threshold)
- Native ETH: Transfers > 2 ETH
- Real-time detection via Drosera Network
- Safety Features: Empty blob guards, explicit decimals handling

## Deployment
Configuration in `drosera.toml` for Drosera Network.

## License
MIT License
