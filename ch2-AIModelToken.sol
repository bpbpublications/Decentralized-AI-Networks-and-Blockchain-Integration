// Book Title: Decentralized AI Networks and Blockchain Integration
// This code is provided as a companion reference for the publication above.
// Chapter 2: AImodel token
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// If you have OpenZeppelin installed, use the original with correct import in the next line:


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract AIModelToken is ERC20 {
    address public modelOwner;
    event ModelUsagePaid(address indexed user, uint256 amount);
    
    constructor(uint256 initialSupply) ERC20("AIModelToken", "AIM") {
        modelOwner = msg.sender;
        _mint(msg.sender, initialSupply);
    }
    
    // Pay to use AI model
    function payForUsage(uint256 amount) public {
        transfer(modelOwner, amount);  // Using public transfer instead of internal _transfer
        emit ModelUsagePaid(msg.sender, amount);
    }
}
