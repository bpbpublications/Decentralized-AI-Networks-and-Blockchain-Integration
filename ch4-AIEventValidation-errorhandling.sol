// Book Title: Decentralized AI Networks and Blockchain Integration
// This code is provided as a companion reference for the publication above.
// Chapter 4: AIEventValidation error handling
//Code example for AIEventValidation of smart contract error handling, event logging, and input validation for AI training and inference is as follows:
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
/**
 * @title AIEventValidation
 * @dev Basic event handling, logging, error handling, and validation for AI training & inference
 */
contract AIEventValidation {
    // Custom errors
    error InvalidModel(bytes32 modelId);
    error Unauthorized(address user);
    error InvalidAccuracy(uint256 accuracy);
    error NoPayment();
    // Events
    event ModelTrainingStarted(
        bytes32 indexed modelId,
        address indexed trainer,
        uint256 indexed round,
        uint256 timestamp
    );
    event TrainingRoundCompleted(
        bytes32 indexed modelId,
        uint256 indexed round,
        address indexed participant,
        uint256 accuracy,   // Scaled by 1e4
        uint256 timestamp
    );
    event InferenceRequested(
        bytes32 indexed modelId,
        address indexed user,
        uint256 payment,
        uint256 timestamp
    );

    // State
    mapping(bytes32 => bool) public activeModel;
    mapping(bytes32 => uint256) public roundOf;
    mapping(address => bool) public authorized;
    uint256 public constant MIN_ACCURACY = 5000; // 50%

    address public admin;
    // Modifiers
    modifier onlyActiveModel(bytes32 modelId) {
        if (!activeModel[modelId]) revert InvalidModel(modelId);
        _;
    }
    modifier onlyAuthorized() {
        if (!authorized[msg.sender]) revert Unauthorized(msg.sender);
        _;
    }
    modifier onlyAdmin() {
        if (msg.sender != admin) revert Unauthorized(msg.sender);
        _;
    }
    constructor() {
        admin = msg.sender;
        authorized[msg.sender] = true; // bootstrap admin as authorized trainer
    }
    // Register model (admin-only to avoid spam/abuse)
    function registerModel(bytes32 modelId) external onlyAdmin {
        activeModel[modelId] = true;
    }
    // Authorize user (admin-only in this simple example)
    function authorizeUser(address user) external onlyAdmin {
        authorized[user] = true;
    }

    // Start training
    function startTraining(bytes32 modelId)
        external
        onlyActiveModel(modelId)
        onlyAuthorized
    {
        uint256 r = ++roundOf[modelId];
        emit ModelTrainingStarted(modelId, msg.sender, r, block.timestamp);
    }

    // Complete round
    function completeRound(bytes32 modelId, uint256 accuracy)
        external
        onlyActiveModel(modelId)
        onlyAuthorized
    {
        if (accuracy < MIN_ACCURACY) revert InvalidAccuracy(accuracy);
        uint256 r = roundOf[modelId];
        emit TrainingRoundCompleted(modelId, r, msg.sender, accuracy, block.timestamp);
    }

    // Request inference
    function requestInference(bytes32 modelId)
        external
        payable
        onlyActiveModel(modelId)
    {
        if (msg.value == 0) revert NoPayment();
        emit InferenceRequested(modelId, msg.sender, msg.value, block.timestamp);
    }
}
