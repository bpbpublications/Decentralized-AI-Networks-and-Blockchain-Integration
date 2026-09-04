// Book Title: Decentralized AI Networks and Blockchain Integration
// This code is provided as a companion reference for the publication above.
// Chapter 4: AIModel registry
// Code example for the high-level registry pattern for model discovery is as follows:
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
contract AIModelRegistry {
    struct ModelInfo {
        address modelContract;
        string name;
        string category;
        bytes32 metadataHash;
        uint256 reputation;
        bool isActive;
        address owner;
    }
    mapping(bytes32 => ModelInfo) public models;
    mapping(address => bool) public approvedPublishers; // or use AccessControl
    uint256 public minRegistrationStake;                // optional anti-spam stake
    mapping(bytes32 => uint256) public modelStake;      // stake per model
    address public admin;
    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }
    modifier onlyPublisher() {
        require(approvedPublishers[msg.sender], "Not approved publisher");
        _;
    }

    constructor(uint256 _minRegistrationStake) {
        admin = msg.sender;
        minRegistrationStake = _minRegistrationStake;
        approvedPublishers[msg.sender] = true; // bootstrap
    }

    function approvePublisher(address _publisher) external onlyAdmin {
        approvedPublishers[_publisher] = true;
    }

    function setMinRegistrationStake(uint256 _amount) external onlyAdmin {
        minRegistrationStake = _amount;
    }

    // If you want a stake requirement, make this function payable
    function registerModel(
        bytes32 _modelId,
        address _modelContract,
        string memory _name,
        string memory _category,
        bytes32 _metadataHash
    ) external payable onlyPublisher {
        require(models[_modelId].modelContract == address(0), "Model already registered");
        require(_modelContract != address(0), "Invalid model contract");
        require(_metadataHash != bytes32(0), "Invalid metadata hash");
        if (minRegistrationStake > 0) {
            require(msg.value >= minRegistrationStake, "Insufficient stake");
            modelStake[_modelId] = msg.value;
        }
        models[_modelId] = ModelInfo({
            modelContract: _modelContract,
            name: _name,
            category: _category,
            metadataHash: _metadataHash,
            reputation: 0,
            isActive: true,
            owner: msg.sender
        });
    }
}
