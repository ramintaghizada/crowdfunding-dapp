# 🧪 Crowdfunding dApp | Learning & Testing Environment

[![Solidity](https://img.shields.io/badge/Solidity-0.8.19-363636)](https://soliditylang.org/)
[![Hardhat](https://img.shields.io/badge/Hardhat-2.22.0-FFB81C)](https://hardhat.org/)
[![Tests](https://img.shields.io/badge/Tests-100%25-brightgreen)]()
[![Purpose](https://img.shields.io/badge/Purpose-Educational-blue)]()

> **⚠️ NOT FOR PRODUCTION USE**  
> This project is designed for **learning, testing, and experimentation purposes only**. Do not use with real funds.

## 📌 Purpose

This repository serves as a **testing ground** for learning:
- Solidity smart contract development
- Hardhat testing framework
- Ethereum deployment workflows
- DeFi pattern implementation

All contracts are deployed on **testnets only** using **test ETH** with no real value.

## 🎯 Learning Objectives

| Topic | What You'll Learn |
|-------|-------------------|
| Solidity Basics | Data types, functions, modifiers, events |
| Smart Contract Security | Reentrancy protection, access control, checks-effects-interactions |
| Hardhat | Compilation, testing, deployment, console interaction |
| Ethereum | Gas optimization, transaction lifecycle, block explorer |
| Testing | Unit tests, integration tests, coverage reporting |

## ✨ Features for Testing

- 🏗️ **Campaign Creation** - Test creating fundraising campaigns
- 💸 **Test Donations** - Simulate ETH donations with testnet funds
- 🎯 **Goal Tracking** - Verify automatic campaign completion
- 🔓 **Withdrawal Logic** - Test fund release mechanisms
- 📊 **Event Emission** - Verify blockchain events fire correctly
- 🔒 **Security Patterns** - Test reentrancy protection

## 🛠️ Tech Stack (Testing-Focused)

| Component | Technology | Purpose |
|-----------|------------|---------|
| Smart Contracts | Solidity 0.8.19 | Core logic to test |
| Development | Hardhat | Local blockchain & testing |
| Testing | Mocha + Chai | Unit & integration tests |
| Network | Hardhat Network (local) | Fast, free testing |
| Testnet | Sepolia | Public test environment |

## 📋 Requirements for Testing

- Node.js (v18+)
- npm or yarn
- MetaMask (optional, for testnet)
- **No real ETH needed** - Use testnet faucets or local network

## 🚀 Quick Start for Testing

```bash
# Clone and install
git clone https://github.com/YOUR_USERNAME/crowdfunding-dapp.git
cd crowdfunding-dapp
npm install

# Compile contracts
npx hardhat compile

# Run all tests
npx hardhat test

# Start local blockchain (free, fast testing)
npx hardhat node

# Deploy to local network (new terminal)
npx hardhat run scripts/deploy.js --network localhost