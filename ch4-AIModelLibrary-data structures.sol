// Book Title: Decentralized AI Networks and Blockchain Integration
// This code is provided as a companion reference for the publication above.
// Chapter 4: AImodel library data structure
// Code example for smart contract Data structures for AI models and  data architecture for AI model inference, i.e., request tracking and reputation management:
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
library AIModelLibrary {
    struct ModelMetadata {
        string name;
        string category;
        bytes32 algorithmHash;   // hash of model/algorithm definition
        uint256 inputDim;
        uint256 outputDim;
        bytes32 metadataHash;    // off-chain metadata (e.g., IPFS)
    }
}
contract AIModelContract {
    using AIModelLibrary for AIModelLibrary.ModelMetadata;
    struct InferenceRequest {
        bytes32 requestId;
        address requester;
        bytes  inputData;
        uint256 timestamp;
        bool   completed;
        bytes  result;
    }

    AIModelLibrary.ModelMetadata public modelMetadata;
    mapping(bytes32 => InferenceRequest) public inferenceRequests;
    mapping(address => uint256) public userReputation;
    event InferenceRequested(bytes32 indexed requestId, address indexed requester);
    event InferenceCompleted(bytes32 indexed requestId, bytes32 resultHash);
    uint256 public constant MAX_DIMENSION = 10_000; // example upper bound

    constructor(
        string memory _name,
        string memory _category,
        bytes32 _algorithmHash,
        uint256 _inputDim,
        uint256 _outputDim,
        bytes32 _metadataHash
    ) {
        // Basic sanity checks for model registration
        require(_algorithmHash != bytes32(0), "Invalid algorithm hash");
        require(_metadataHash != bytes32(0), "Invalid metadata hash");
        require(_inputDim > 0 && _inputDim <= MAX_DIMENSION, "Invalid input dimension");
        require(_outputDim > 0 && _outputDim <= MAX_DIMENSION, "Invalid output dimension");

        modelMetadata = AIModelLibrary.ModelMetadata({
            name: _name,
            category: _category,
            algorithmHash: _algorithmHash,
            inputDim: _inputDim,
            outputDim: _outputDim,
            metadataHash: _metadataHash
        });
    }
    // ... existing inference logic using inferenceRequests / userReputation ...
}
