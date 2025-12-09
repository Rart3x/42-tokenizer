# ⚙️ K42Token - Deployment Guide

## 🛠️ Prerequisites

- 💻 Node.js and npm installed on your machine.
- 🔑 A wallet private key with BNB funds for the Binance Smart Chain network (Testnet or Mainnet).
- 🌐 RPC URL of the Binance Smart Chain node you want to connect to.

---

## 🚩 Deployment - Case 1: Project already cloned with package.json

### Create a `.env` file in the deployment root folder with the following content (replace with your own values):  
```env
PRIVATE_KEY="your_private_key_here"
BSC_RPC_URL="https://data-seed-prebsc-1-s1.binance.org:8545/"
```

### 📦 Install dependencies
```bash
npm install
```

### 🏗️ Compile the contracts
```bash
npx hardhat compile
```

### 🚀 Deploy to BSC Testnet
```bash
npx hardhat run scripts/deploy.js --network bsctest
```

## 🚩 Deployment - Case 2: Starting from scratch (no project files)

### 1️⃣ Create a new folder and enter it
```bash
mkdir deployment
cd deployment
```

### 2️⃣ Initialize a new npm project
```bash
npm init -y
```

### 3️⃣ Install Hardhat and Hardhat Toolbox
```bash
npm install --save-dev hardhat @nomicfoundation/hardhat-toolbox
```

### 4️⃣ Create a Hardhat project (choose default options)
```bash
npx hardhat
```

### 5️⃣ Install OpenZeppelin contracts
```bash
npm install @openzeppelin/contracts
```

### 6️⃣ Create your contracts folder and add the K42Token.sol contract file

### 7️⃣ Create a 'scripts' folder and add your deploy.js script
```javascript
async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const K42Token = await ethers.getContractFactory("K42Token");
  const token = await K42Token.deploy();

  await token.deployed();

  console.log("K42Token deployed to:", token.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
```

### 8️⃣ Configure your hardhat.config.js with your private key and BSC RPC URL
```javascript
require("dotenv").config();

module.exports = {
  solidity: "0.8.20",
  networks: {
    bsctest: {
      url: process.env.BSC_RPC_URL || "",
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
    },
  },
};
```

### 9️⃣ Compile contracts
```bash
npx hardhat compile
```

### 🔟 Deploy the contract to BSC Testnet
```bash
npx hardhat run scripts/deploy.js --network bsctest
```

## ✅ K42Token Multisig & Control Functions

| Function | Description | Who Can Call |
|---------|-------------|--------------|
| `addOwner(address)` | Adds a multisig owner | Owner |
| `removeOwner(address)` *(if present)* | Removes a multisig owner | Owner |
| `createMintRequest(address,uint256)` | Creates a mint request | Owner |
| `confirmMintRequest(uint256)` | Confirms a mint request | Owner |
| `getMintRequest(uint256)` | Returns request details | Anyone |
| `pause()` | Pauses all transfers and minting | Owner |
| `unpause()` | Unpauses all transfers and minting | Owner |
| `_update(...)` | Internal ERC20 update override | Internal |

---
