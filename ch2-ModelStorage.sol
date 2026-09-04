// Book Title: Decentralized AI Networks and Blockchain Integration
# This code is provided as a companion reference for the publication above.
# Chapter 2: Model storage
// Separate JavaScript (Off-chain)ipfs-storage.js - Off-chain code + Solidity (On-chain) (ModelStorage.sol)
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ModelStorage {
    struct ModelRecord {
        string ipfsCID;
        string metadata;
        address owner;
        uint256 timestamp;
    }
    
    mapping(uint256 => ModelRecord) public models;
    uint256 public modelCount;
    
    event ModelStored(
        uint256 indexed modelId,
        string ipfsCID,
        address indexed owner
    );
    
    function storeModel(
        string memory _ipfsCID,
        string memory _metadata
    ) public {
        modelCount++;
        models[modelCount] = ModelRecord({
            ipfsCID: _ipfsCID,
            metadata: _metadata,
            owner: msg.sender,
            timestamp: block.timestamp
        });
        
        emit ModelStored(modelCount, _ipfsCID, msg.sender);
    }
    
    function getModel(uint256 _modelId) public view returns (ModelRecord memory) {
        return models[_modelId];
    }
}
