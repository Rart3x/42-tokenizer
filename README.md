# 🚀 K42Token - General Overview

## 📖 Project Overview

K42Token is a customizable ERC20 token built with OpenZeppelin standards. It aims to provide a secure, flexible, and standard-compliant token for various use cases.

### ✨ Features

- 🎁 **Minting**: The owner can mint new tokens up to a fixed maximum cap.
- 🔥 **Burning**: Token holders can burn their tokens to reduce total supply.
- ⏸️ **Pausing**: The owner can pause all token transfers and minting.
- 🔄 **Transfers**: Token holders can transfer tokens freely when the contract is not paused.

### 🛠️ Technical Details

- 🎯 **Cap**: Maximum supply capped at 4.2 billion K42 tokens.
- 🎉 **Initial Mint**: 1% of total supply minted to the deployer at contract creation.
- 📚 Built using OpenZeppelin's `ERC20`, `ERC20Capped`, `ERC20Burnable`, `Ownable`, and `Pausable` contracts.
- 🛡️ Transfers and minting are disabled when the contract is paused for security.
