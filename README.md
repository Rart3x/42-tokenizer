# 🚀 K42Token - General Overview

## 📖 Project Overview

K42Token is a secure and flexible ERC20 token built on OpenZeppelin standards, designed to support a variety of use cases while ensuring safety and maintainability.

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

## 🧾 Multisig Minting Logic

- ✅ Minting requires multiple confirmations (`requiredConfirmations`) by designated owners.
- 🧑‍🤝‍🧑 Owners are added via `addOwner(address)` and validated using the `isOwner` mapping.
- ✍️ A mint request is initiated with `createMintRequest(address to, uint256 amount)` by any owner.
- 🆗 Other owners must then call `confirmMintRequest(uint256 requestId)` to approve.
- ✅ Once the request reaches the required confirmations, tokens are minted automatically.
- 🔒 All mint operations are blocked when the contract is paused.

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
