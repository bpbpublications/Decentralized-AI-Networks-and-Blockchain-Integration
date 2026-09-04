// Book Title: Decentralized AI Networks and Blockchain Integration
// This code is provided as a companion reference for the publication above.
// Chapter 2: Model compression
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// Model compression uses quantization, pruning, and related techniques 
// to reduce model size and computational requirements, 
// enabling lighter on-chain representations

// Using 8-bit quantized weights instead of full precision
struct QuantizedLayer {
    int8[] weights;        // Flattened 1D array instead of 2D
    int256[] scales;
    int256[] biases;
}

