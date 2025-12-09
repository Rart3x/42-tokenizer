🚀 K42Token - General Overview
📖 Project Overview

K42Token is a secure and flexible ERC20 token built on OpenZeppelin standards, designed to support various use cases while ensuring safety and maintainability.

The entire smart contract was coded in Solidity, the primary programming language used for Ethereum-compatible blockchains.

### ✨ Features

- 🎁 **Multisig Minting**: Minting requires approval from multiple owners for enhanced security.
- 🔥 **Burning**: Token holders can burn their tokens to voluntarily reduce the total supply.
- ⏸️ **Pausing**: The owner can pause all token transfers and minting in case of emergencies or upgrades.
- 🔄 **Transfers**: Token holders can freely transfer tokens when the contract is not paused.

### 🛠️ Technical Details

- 🎯 **Supply Cap**: The total supply is capped at 4.2 billion K42 tokens.
- 🎉 **Initial Mint**: Upon deployment, 1% of the total supply is minted to the deployer's address.
- 🧾 **Multisig Control**: Only registered multisig owners can initiate and confirm minting requests.
- 📚 Developed using OpenZeppelin’s `ERC20`, `ERC20Capped`, `ERC20Burnable`, `Ownable`, and `Pausable` contracts.
- 🛡️ All transfers and minting functions are disabled when the contract is paused to protect users and assets.

---

## 💡 Design Choices and Rationale

- Using OpenZeppelin’s audited libraries ensures security and compatibility.
- The capped supply prevents inflation and maintains token value.
- Minting control via ownership provides flexibility while preventing unauthorized inflation.
- Burn functionality gives token holders control over supply reduction.
- Pausing enables quick reaction to potential threats or required maintenance.

---

## ✅ Multisig & Control Functions

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

## 📋 Summary

| Feature      | Description                                           |
|--------------|-------------------------------------------------------|
| ERC-20       | Standard fungible token interface                      |
| Capped Supply| Max supply of 4.2 billion tokens                       |
| Minting      | Owner-only minting up to cap                           |
| Burning      | Token holders can burn their tokens                    |
| Pausable     | Owner can pause/unpause transfers and minting         |

---

## 📍 Contract Deployment

| Detail              | Value                                                                 |
|---------------------|-----------------------------------------------------------------------|
| **Deployed Address**| `0x6c509FD32B05D2139F2509e380471A9d55Da721b` *(BSC Testnet)*          |
| **Deployer Address**| `0x127FEEd0b6f60a0451a156C480A8b453368587b6`                          |
| **Initial Minted To**| Deployer Address (1% of total supply)                                 |
