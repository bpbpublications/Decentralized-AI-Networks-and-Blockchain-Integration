// Book Title: Decentralized AI Networks and Blockchain Integration
// This code is provided as a companion reference for the publication above.
// Chapter 2: AImodel license
// AI model licensing automation
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract AIModelLicense {
    address public owner;
    mapping(address => bool) private licensedUsers;
    event LicenseGranted(address indexed user);
    event LicenseRevoked(address indexed user);
    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }
    constructor() {
        owner = msg.sender;
    }
    function grantLicense(address user) public onlyOwner {
        licensedUsers[user] = true;
        emit LicenseGranted(user);
    }
    function revokeLicense(address user) public onlyOwner {
        licensedUsers[user] = false;
        emit LicenseRevoked(user);
    }
    function checkLicense(address user) public view returns (bool) {
        return licensedUsers[user];
    }
}

