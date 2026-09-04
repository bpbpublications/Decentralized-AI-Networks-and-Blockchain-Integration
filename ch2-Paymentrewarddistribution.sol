// Book Title: Decentralized AI Networks and Blockchain Integration
// This code is provided as a companion reference for the publication above.
// Chapter 2: Payment and reward distribution
// Payment and reward distribution.Payment contracts implement advanced distribution mechanisms that incentivize participation while ensuring fair compensation.
// SPDX-License-Identifier:  MIT
pragma solidity ^0.8.28;

// Interface for ERC20 token - MOVED OUTSIDE THE CONTRACT
interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract PaymentDistribution {
    // Define the TrainingJob struct
    struct TrainingJob {
        address[] participants;
        mapping(address => uint256) contributions;
        uint256 totalReward;
        bool isActive;
    }
    
    // ERC20 token interface (simplified)
    IERC20 public paymentToken;
    
    // Mapping to store training jobs
    mapping(bytes32 => TrainingJob) public trainingJobs;
    
    // Event for reward distribution
    event RewardsDistributed(bytes32 indexed jobId, uint256 totalParticipants, uint256 totalRewards);
    
    // Constructor to set the payment token
    constructor(address _paymentToken) {
        paymentToken = IERC20(_paymentToken);
    }
    
    // Payment contracts implement advanced distribution mechanisms that incentivize participation while ensuring fair compensation
    function distributeRewards(bytes32 _jobId) external {
        TrainingJob storage job = trainingJobs[_jobId];
        uint256 totalContributions = _calculateTotalContributions(_jobId);
        
        // Check if there are contributions to distribute
        require(totalContributions > 0, "No contributions to distribute");
        require(job.totalReward > 0, "No rewards to distribute");
        
        uint256 distributedParticipants = 0;
        
        for (uint i = 0; i < job.participants.length;) {
            address participant = job.participants[i];
            uint256 contribution = job.contributions[participant];
            
            if (contribution > 0) {
                uint256 reward = (job.totalReward * contribution) / totalContributions;
                require(paymentToken.transfer(participant, reward), "Reward transfer failed");
                distributedParticipants++;
            }
            
            unchecked { ++i; }
        }
        
        emit RewardsDistributed(_jobId, distributedParticipants, job.totalReward);
    }
    
    // Helper function to calculate total contributions
    function _calculateTotalContributions(bytes32 _jobId) internal view returns (uint256) {
        TrainingJob storage job = trainingJobs[_jobId];
        uint256 total = 0;
        
        for (uint i = 0; i < job.participants.length; i++) {
            total += job.contributions[job.participants[i]];
        }
        
        return total;
    }
    
    // Function to add a participant to a training job (example utility)
    function addParticipant(bytes32 _jobId, address _participant, uint256 _contribution) external {
        TrainingJob storage job = trainingJobs[_jobId];
        job.participants.push(_participant);
        job.contributions[_participant] = _contribution;
    }
    
    // Function to set total reward for a job (example utility)
    function setTotalReward(bytes32 _jobId, uint256 _totalReward) external {
        trainingJobs[_jobId].totalReward = _totalReward;
    }
}
