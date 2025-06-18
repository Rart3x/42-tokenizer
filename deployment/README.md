# ⚙️ K42Token - Deployment Guide

## 🛠️ Prerequisites

- 💻 Node.js and npm installed on your machine.
- 🔑 A wallet private key with BNB funds for the Binance Smart Chain network (Testnet or Mainnet).
- 🌐 RPC URL of the Binance Smart Chain node you want to connect to.

---

## 🚩 Deployment - Case 1: Project already cloned with package.json

```bash
# 📦 Install dependencies
npm install

# 🏗️ Compile the contracts
npx hardhat compile

# 🚀 Deploy to BSC Testnet
npx hardhat run scripts/deploy.js --network bsctest
