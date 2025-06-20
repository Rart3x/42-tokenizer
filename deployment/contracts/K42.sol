// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract K42Token is ERC20, ERC20Burnable, ERC20Capped, Pausable, Ownable
{
    uint256 internal constant tokensCap = 4200000000;
    uint256 internal constant deployTokens = tokensCap / 100;

    address[] public owners;
    mapping(address => bool) public isOwner;
    uint256 public requiredConfirmations;

    struct MintRequest
    {
        address to;
        uint256 amount;
        uint256 confirmations;
        bool executed;
        mapping(address => bool) confirmedBy;
    }

    mapping(uint256 => MintRequest) public mintRequests;
    uint256 public mintRequestCount;

    event MintRequestCreated(uint256 indexed requestId, address indexed to, uint256 amount, address indexed createdBy);
    event MintRequestConfirmed(uint256 indexed requestId, address indexed confirmedBy);
    event MintRequestExecuted(uint256 indexed requestId);
    event OwnerAdded(address indexed newOwner);
    event RequiredConfirmationsChanged(uint256 newRequiredConfirmations);

    // Constructor sets the token name, symbol, cap, and owner
    constructor(address initialOwner) ERC20("K42Token", "K42") ERC20Capped(tokensCap * 10 ** decimals()) Ownable(initialOwner)
    {
        _mint(initialOwner, deployTokens * 10 ** decimals());

        owners.push(initialOwner);
        isOwner[initialOwner] = true;
        requiredConfirmations = 1;
    }

    // ========================
    // 🔐 Multisig Minting Logic
    // ========================

    // Create a new mint request that must be confirmed by multiple owners
    function createMintRequest(address to, uint256 amount) external onlyOwners whenNotPaused
    {
        uint256 requestId = mintRequestCount++;
        MintRequest storage req = mintRequests[requestId];
        
        req.to = to;
        req.amount = amount;
        req.executed = false;
        req.confirmations = 0;
        req.confirmedBy[msg.sender] = true;
        req.confirmations += 1;

        emit MintRequestCreated(requestId, to, amount, msg.sender);
    }

    // Confirm a mint request by another owner
    function confirmMintRequest(uint256 requestId) external onlyOwners whenNotPaused
    {
        MintRequest storage req = mintRequests[requestId];
        require(!req.executed, "Already executed");
        require(!req.confirmedBy[msg.sender], "Already confirmed");

        req.confirmedBy[msg.sender] = true;
        req.confirmations += 1;

        emit MintRequestConfirmed(requestId, msg.sender);

        if (req.confirmations >= requiredConfirmations)
        {
            _mint(req.to, req.amount);
            req.executed = true;
        }
    }

    // ========================
    // 🔧 Admin & Security Logic
    // ========================

    // Add a new multisig owner (only existing owner can add)
    function addOwner(address newOwner) external onlyOwners
    {
        emit OwnerAdded(newOwner);

        require(!isOwner[newOwner], "Already owner");
        owners.push(newOwner);
        isOwner[newOwner] = true;
        requiredConfirmations++;
        _mint(newOwner, (deployTokens / 42) * 10 ** decimals());
    }

    // Set required number of confirmations for minting
    function setRequiredConfirmations(uint256 count) external onlyOwners
    {
        require(count > 0 && count <= owners.length, "Invalid confirmation count");
        requiredConfirmations = count;
        emit RequiredConfirmationsChanged(count);
    }

    // Pause all token transfers; Only the owner can call this
    function pause() external onlyOwners
    {
        _pause();
        emit Paused(msg.sender);
    }

    // Unpause token transfers; Only the owner can call this
    function unpause() external onlyOwners
    {
        _unpause();
        emit Unpaused(msg.sender);
    }

    // Override required due to multiple inheritance for internal update logic
    function _update(address from, address to, uint256 value) internal override(ERC20, ERC20Capped) whenNotPaused {
        super._update(from, to, value);
    }

    modifier onlyOwners()
    {
        require(isOwner[msg.sender], "Not an owner");
        _;
    }
}

