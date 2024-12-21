// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LearningRewards {
    // Token-related properties
    string public name = "LearningRewardsToken";
    string public symbol = "LRT";
    uint8 public decimals = 18;
    uint256 public totalSupply;
    mapping(address => uint256) public balances;

    // Mapping to track if a user has completed a module
    mapping(address => mapping(uint256 => bool)) public completedModules;

    // Event for when a user completes a module and earns tokens
    event TokensEarned(address indexed user, uint256 moduleId, uint256 tokens);

    // Constructor to initialize the contract with an initial supply
    constructor(uint256 initialSupply) {
        totalSupply = initialSupply * 10 ** uint256(decimals);
        balances[msg.sender] = totalSupply;
    }

    // Function to complete a module and earn tokens
    function completeModule(uint256 moduleId) public {
        require(!completedModules[msg.sender][moduleId], "Module already completed");

        // Mark the module as completed
        completedModules[msg.sender][moduleId] = true;

        // Define reward for completing each module (e.g., 100 tokens per module)
        uint256 reward = 100 * 10 ** uint256(decimals);

        // Add reward to the user's balance
        balances[msg.sender] += reward;

        // Emit an event for the module completion
        emit TokensEarned(msg.sender, moduleId, reward);
    }

    // Function to check the balance of tokens for a user
    function balanceOf(address user) public view returns (uint256) {
        return balances[user];
    }
}
