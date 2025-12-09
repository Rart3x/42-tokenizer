# 🧪 K42Token -- Unit Test Documentation

This document provides a clear explanation of the unit tests written for
the **K42Token** smart contract, focusing on the multisig minting system
and ownership logic.

------------------------------------------------------------------------

# ▶️ How to Run the Tests

Make sure all dependencies are installed:

``` bash
npm install
```

Run the entire test suite using Hardhat:

``` bash
npx hardhat test
```

Hardhat will automatically: - Compile the contracts\
- Start the testing environment\
- Execute all tests inside the `/test` folder

------------------------------------------------------------------------

# 📂 Test File

    test/K42Token.js

This file contains **five unit tests** that verify all essential
behaviors of the multisig system.

------------------------------------------------------------------------

# 🧪 Test Breakdown

## 1️⃣ Constructor assigns the initial owner

**What it checks:** - The deployer of the contract is automatically
assigned as the first multisig owner.

**Why it matters:** - Ensures the multisig system starts with exactly
one valid owner.

------------------------------------------------------------------------

## 2️⃣ An owner can create a mint request

**What it checks:** - An owner can call
`createMintRequest(address to, uint256 amount)` - The request is
properly stored in `mintRequests` - `executed` is initially `false`

**Why it matters:** - Validates that the multisig minting system
correctly registers mint proposals.

------------------------------------------------------------------------

## 3️⃣ A second owner can be added

**What it checks:** - Calling `addOwner(address)` successfully adds a
new multisig owner. - `isOwner(address)` returns `true` for the new
owner.

**Why it matters:** - Ensures multisig governance can expand beyond the
deployer.

------------------------------------------------------------------------

## 4️⃣ A mint request can be confirmed and executed

**What it checks:** 1. The required number of confirmations is set to 2\
2. An owner creates a mint request\
3. A second owner confirms the request\
4. The contract automatically executes the mint\
5. The user's balance increases as expected\
6. The request is marked as executed

**Why it matters:** - This test simulates the **complete multisig
workflow**, ensuring the system works from start to finish.

------------------------------------------------------------------------

## 5️⃣ An owner cannot confirm the same request twice

**What it checks:** - An owner cannot reconfirm a request if: - They
already confirmed it\
- The request is already executed

**Expected behavior:** The confirmation attempt must revert with:

    "Already executed"

**Why it matters:** - Prevents double confirmations\
- Protects multisig integrity

--------------------------------------------------------------------------------------------------------------------
