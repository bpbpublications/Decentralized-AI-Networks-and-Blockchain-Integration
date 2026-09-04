// Book Title: Decentralized AI Networks and Blockchain Integration
// This code is provided as a companion reference for the publication above.
// Chapter 7: Vesting lockup
// For example, a DAI network contract might monitor seven-day price volatility (σ_p) and total value locked (TVL)
// Sample variables initialized for context
let volatility = 0.35;      // 35% representation
let TVL = 500000;
let threshold = 1000000;
let activeUsers = 1500;
let target = 1000;
let baseRate = 100;
let timeElapsed = 10;

let vestingMultiplier;

// CORRECTED: Converted "30%" to "0.3" and "OR" to "||"
if (volatility > 0.3 || TVL < threshold) {
    vestingMultiplier = 0.5;  // Slow release during stress
} else if (activeUsers > target) {
    vestingMultiplier = 1.5;  // Accelerate during growth
} else {
    vestingMultiplier = 1.0;  // Standard default
}

// CORRECTED: Changed 'uint256' to 'let' or 'const' and added semi-colons
let vestingRate = baseRate * vestingMultiplier;
let tokensReleased = vestingRate * timeElapsed;

console.log(`Vesting Multiplier: ${vestingMultiplier}`);
console.log(`Tokens Released: ${tokensReleased}`);