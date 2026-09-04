// Book Title: Decentralized AI Networks and Blockchain Integration
// This code is provided as a companion reference for the publication above.
// Chapter 2: Offchain IPFS
// off-chain JavaScript Code
// ipfs-storage.js

async function storeModel(buffer, metadata) {
  // Dynamically import the modern kubo-rpc-client package (handles ESM inside CommonJS)
  const { create } = await import('kubo-rpc-client');
  
  // Connects to your local IPFS daemon (default: http://127.0.0.1:5001)
  const ipfs = create(); 

  // Construct the payload package
  const pkg = { 
    weights: buffer.toString('base64'), 
    metadata 
  };
  
  const dataString = JSON.stringify(pkg);
  
  // Upload to IPFS
  const result = await ipfs.add(dataString);
  
  // Returns the CID hash string safely across protocol versions
  return result.cid.toString(); 
}

module.exports = { storeModel };
