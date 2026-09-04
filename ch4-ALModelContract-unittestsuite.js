// Book Title: Decentralized AI Networks and Blockchain Integration
// This code is provided as a companion reference for the publication above
// Chapter 4: AIModel contract unit testsuite


const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("AIModelContract", function () {
    let aiModel, owner, user1, user2;
    
    beforeEach(async function () {
        [owner, user1, user2] = await ethers.getSigners();
        const AIModel = await ethers.getContractFactory("AIModelContract");
        // Deploying the contract
        aiModel = await AIModel.deploy("TestModel", "Classification", owner.address);
    });
    
    it("Should register a new model", async function () {
        await expect(aiModel.connect(owner).updateModel("v1.0", "0x123..."))
            .to.emit(aiModel, "ModelUpdated");
    });
    
    it("Should handle inference requests", async function () {
        // Modern Ethers v6 utilities syntax
        const inputData = ethers.toBeUtf8Bytes("test input");
        await expect(aiModel.connect(user1).requestInference(inputData, { value: ethers.parseEther("0.1") }))
            .to.emit(aiModel, "InferenceRequested");
    });
});