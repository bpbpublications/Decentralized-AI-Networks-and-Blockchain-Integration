// Book Title: Decentralized AI Networks and Blockchain Integration
// This code is provided as a companion reference for the publication above.
// Chapter 2: Model registry contracts
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// Model registry contracts: 
// Use the following example to illustrate how a model registry can be represented and optimized in Solidity for DAI marketplaces: 

struct ModelInfo {
    bytes32 modelHash;          // IPFS hash of the model
    address owner;              // Model owner
    uint128 price;              // Price in wei (packed for gas efficiency)
    uint64 createdAt;           // Creation timestamp (packed)
    uint32 version;             // Model version (packed)
    uint32 downloads;           // Download count (packed)
    bool isActive;              // Active status
}
