// Book Title: Decentralized AI Networks and Blockchain Integration
// This code is provided as a companion reference for the publication above.
// Chapter 4: AI data oracle
// Code example of AI data Oracle for decentralized oracle design pattern with confidence-weighted data feeds and provider authorization is as follows:
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
contract AIDataOracle {
    struct DataFeed {
        bytes32 feedId;
        string description;
        address dataProvider;
        uint256 lastUpdate;
        bytes data;
        uint256 confidence;
    }
    mapping(bytes32 => DataFeed) public dataFeeds;
    mapping(address => bool) public authorizedProviders;
    event DataFeedUpdated(bytes32 indexed feedId, address indexed provider, uint256 confidence, uint256 timestamp);

    // Example separate registration to set description & initial provider
    function registerDataFeed(
        bytes32 _feedId,
        string calldata _description
    ) external {
        require(dataFeeds[_feedId].feedId == bytes32(0), "Feed already exists");
        dataFeeds[_feedId].feedId = _feedId;
        dataFeeds[_feedId].description = _description;
        dataFeeds[_feedId].dataProvider = msg.sender;
        dataFeeds[_feedId].lastUpdate = block.timestamp;
    }

    function updateDataFeed(
        bytes32 _feedId,
        bytes calldata _data,
        uint256 _confidence
    ) external {
        require(authorizedProviders[msg.sender], "Unauthorized data provider");
        DataFeed storage feed = dataFeeds[_feedId];

        // Ensure feed exists before updating
        require(feed.feedId != bytes32(0), "Unknown data feed");
        // Optional: enforce same provider or allow multiple providers
        // require(feed.dataProvider == msg.sender, "Not feed owner");
        feed.dataProvider = msg.sender;
        feed.lastUpdate = block.timestamp;
        feed.data = _data;
        feed.confidence = _confidence;
        emit DataFeedUpdated(_feedId, msg.sender, _confidence, block.timestamp);
    }
}
