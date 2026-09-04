// Book Title: Decentralized AI Networks and Blockchain Integration
// This code is provided as a companion reference for the publication above.
// Chapter 2: AImodel licensing
//This Solidity contract implements a basic AI model licensing system
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AIModelLicense {
    address public owner;
    uint256 public constant LICENSE_FEE = 0.1 ether;
    
    mapping(address => uint256) private licenseExpirations;
    bool public paused = false;
    
    event LicenseGranted(address indexed user, uint256 expiration);
    event LicenseRevoked(address indexed user);
    event Paused(bool status);
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }
    
    modifier whenNotPaused() {
        require(!paused, "Contract is paused");
        _;
    }
    
    constructor() {
        owner = msg.sender;
    }
    
    function grantLicense(address user, uint256 duration) public onlyOwner {
        licenseExpirations[user] = block.timestamp + duration;
        emit LicenseGranted(user, block.timestamp + duration);
    }
    
    function purchaseLicense(uint256 duration) public payable whenNotPaused {
        require(msg.value >= LICENSE_FEE * duration / 30 days, "Insufficient payment");
        licenseExpirations[msg.sender] = block.timestamp + duration;
        emit LicenseGranted(msg.sender, block.timestamp + duration);
    }
    
    function revokeLicense(address user) public onlyOwner {
        licenseExpirations[user] = 0;
        emit LicenseRevoked(user);
    }
    
    function checkLicense(address user) public view returns (bool) {
        return licenseExpirations[user] > block.timestamp;
    }
    
    function getLicenseExpiration(address user) public view returns (uint256) {
        return licenseExpirations[user];
    }
    
    function togglePause() public onlyOwner {
        paused = !paused;
        emit Paused(paused);
    }
    
    function withdraw() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}
