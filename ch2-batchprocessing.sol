// Book Title: Decentralized AI Networks and Blockchain Integration
// This code is provided as a companion reference for the publication above.
// Chapter 2: Batch processing
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
// Main batch processing function
// Free functions don't need visibility modifiers
function batchPredict(int256[][] memory inputBatches) 
    view returns (int256[][] memory) {  // Removed 'public'
    int256[][] memory results = new int256[][](inputBatches.length);
    
    for (uint i = 0; i < inputBatches.length; i++) {
        results[i] = predict(inputBatches[i]);
    }
    
    return results;
}

function predict(int256[] memory input) 
    pure returns (int256[] memory) {  // Removed visibility
    int256[] memory result = new int256[](input.length);
    for (uint j = 0; j < input.length; j++) {
        result[j] = input[j] * 2;
    }
    return result;
}
