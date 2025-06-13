// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract KToken is ERC20, ERC20Burnable, ERC20Capped, Ownable, Pausable {
    
    // Constructor sets the token name, symbol, and max supply (cap)
    constructor(uint256 cap) ERC20("K42Token", "K42") ERC20Capped(cap * 10 ** decimals()) Ownable(msg.sender) {
        _mint(msg.sender, 42000000 * 10 ** decimals());
    }

    // Mint new tokens to a given address; only the owner can call this
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    // Pause all token transfers; only the owner can call this
    function pause() external onlyOwner {
        _pause();
    }

    // Unpause token transfers; only the owner can call this
    function unpause() external onlyOwner {
        _unpause();
    }

    // Override required due to multiple inheritance for internal update logic
    function _update(address from, address to, uint256 value) internal override(ERC20, ERC20Capped) {
        super._update(from, to, value);
    }
}
