// Book Title: Decentralized AI Networks and Blockchain Integration
// This code is provided as a companion reference for the publication above.
// Chapter 4: AImodel factory
// Code example for the high-level factory pattern for model deployment is as follows:
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// AIModel contract definition
contract AIModel {
    string public modelName;
    string public modelType;
    bytes32 public modelHash;
    uint256 public initialPrice;
    address public creator;
    bool public isActive;

    constructor(
        string memory _modelName,
        string memory _modelType,
        bytes32 _modelHash,
        uint256 _initialPrice,
        address _creator
    ) {
        modelName = _modelName;
        modelType = _modelType;
        modelHash = _modelHash;
        initialPrice = _initialPrice;
        creator = _creator;
        isActive = true;
    }
}

// Factory contract
contract AIModelFactory {
    address[] public deployedModels;
    mapping(address => bool) public isValidModel;

    // Include modelHash for traceability; you could also add a version or metadataHash here.
    event ModelDeployed(
        address indexed modelAddress, 
        address indexed creator, 
        string modelType, 
        bytes32 modelHash, 
        uint256 initialPrice
    );

    function createAIModel(
        string memory _modelName, 
        string memory _modelType, 
        bytes32 _modelHash, 
        uint256 _initialPrice
    ) public returns (address) {
        // Basic input validation
        require(_modelHash != bytes32(0), "Invalid model hash");
        require(_initialPrice > 0, "Initial price must be > 0");
        
        AIModel newModel = new AIModel(
            _modelName, 
            _modelType, 
            _modelHash, 
            _initialPrice, 
            msg.sender
        );
        
        address modelAddr = address(newModel);
        deployedModels.push(modelAddr);
        isValidModel[modelAddr] = true;
        emit ModelDeployed(modelAddr, msg.sender, _modelType, _modelHash, _initialPrice);
        return modelAddr;
    }
}
