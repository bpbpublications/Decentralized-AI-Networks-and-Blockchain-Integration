// Book Title: Decentralized AI Networks and Blockchain Integration
// This code is provided as a companion reference for the publication above.
// Chapter 4: AITraining for modularity
// Code example of AITraining for modular smart contract architecture with separated concerns like libraries, interfaces, and access control is as follows
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/* ========== LIBRARY: MathUtils.sol ========== */
library MathUtils {
    function average(uint256 a, uint256 b) internal pure returns (uint256) {
        return (a + b) / 2;
    }
    
    function max(uint256 a, uint256 b) internal pure returns (uint256) {
        return a >= b ? a : b;
    }
}

/* ========== INTERFACE: ITraining.sol ========== */
interface ITraining {
    function startTraining(bytes32 modelId) external;
    function completeRound(bytes32 modelId, uint256 accuracy) external;
}

/* ========== CONTRACT: AccessControl.sol ========== */
contract AccessControl {
    mapping(address => bool) public admins;
    
    modifier onlyAdmin() {
        require(admins[msg.sender], "Not admin");
        _;
    }
    
    constructor() { 
        admins[msg.sender] = true; 
    }
    
    function addAdmin(address user) external onlyAdmin {
        admins[user] = true;
    }
}

/* ========== CONTRACT: AITraining.sol ========== */
contract AITraining is ITraining, AccessControl {
    using MathUtils for uint256;
    
    mapping(bytes32 => bool) public validModel;
    mapping(bytes32 => uint256) public roundOf;
    mapping(address => bool) public trainers;
    
    event TrainingStarted(bytes32 modelId, uint256 round);
    event RoundCompleted(bytes32 modelId, uint256 round, uint256 accuracy);
    
    modifier onlyTrainer() {
        require(trainers[msg.sender], "Not trainer");
        _;
    }
    
    function registerModel(bytes32 modelId) external onlyAdmin {
        validModel[modelId] = true;
    }
    
    function authorizeTrainer(address user) external onlyAdmin {
        trainers[user] = true;
    }
    
    function startTraining(bytes32 modelId) external override onlyTrainer {
        require(validModel[modelId], "Invalid model");
        uint256 r = ++roundOf[modelId];
        emit TrainingStarted(modelId, r);
    }
    
    function completeRound(bytes32 modelId, uint256 accuracy) 
        external 
        override 
        onlyTrainer 
    {
        require(validModel[modelId], "Invalid model");
        require(accuracy <= 10000, "Accuracy >100%");
        uint256 r = roundOf[modelId];
        emit RoundCompleted(modelId, r, accuracy);
    }
    
    // Example use of library
    function compareAccuracies(uint256 a, uint256 b) external pure returns (uint256) {
        return MathUtils.max(a, b);
    }
}
