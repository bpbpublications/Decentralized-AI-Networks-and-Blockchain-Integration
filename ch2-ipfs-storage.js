// Book Title: Decentralized AI Networks and Blockchain Integration
// This code is provided as a companion reference for the publication above.
// Chapter 2: IPS Storage
// Separate JavaScript (Off-chain) + Solidity (On-chain) (ModelStorage.sol)
// JavaScript File (ipfs-storage.js) - Keep as is, but ensure proper usage:

// ipfs-storage.js - Off-chain code
async function storeModel(buffer, metadata) {
  try {
    // Dynamically import the modern kubo-rpc-client package
    const { create } = await import('kubo-rpc-client');
    
    // Connects to your local IPFS daemon
    const ipfs = create(); 

    // Construct the payload package
    const pkg = { 
      weights: buffer.toString('base64'),  
      metadata 
    };
    
    const dataString = JSON.stringify(pkg);
    
    // Upload to IPFS
    const result = await ipfs.add(dataString);
    
    // Returns the CID hash string
    return result.cid.toString(); 
  } catch (error) {
    console.error('IPFS storage failed:', error);
    throw error;
  }
}

module.exports = { storeModel };