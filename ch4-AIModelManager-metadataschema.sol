// Book Title: Decentralized AI Networks and Blockchain Integration
// This code is provided as a companion reference for the publication above.
// Chapter 4: AIModelManager metadataschema
// Code example of AIModelManager for a comprehensive model registration system with rich metadata schema and capability tracking is as follows:
pragma solidity ^0.8.19;
contract AIModelManager {
    struct ModelRegistration {
        bytes32 modelId;
        string name;
        string description;
        bytes32 modelHash;
        string modelType;
        uint256 version;
        address owner;
        uint256 registrationTime;
        bool isActive;
        ModelCapabilities capabilities;
        ModelRequirements requirements;
    }
    
    struct ModelCapabilities {
        string[] supportedTasks;
        uint256 maxInputSize;
        uint256 averageProcessingTime;
        uint256 accuracyMetric;
    }
    
    struct ModelRequirements {
        uint256 minComputeUnits;
        uint256 minMemory;
        string[] requiredLibraries;
    }
    mapping(bytes32 => ModelRegistration) public registeredModels;
    mapping(address => bytes32[]) public ownerModels;
}
