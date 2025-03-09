// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract EEGModelStorage {
    address public owner;
    string private modelURI;
    string private modelMetadata;
    uint256 public modelAccuracy;

    mapping(string => uint256) public modelVotes;
    mapping(address => string) public userBrainSignature;
    mapping(address => string) public userPredictions;

    event ModelUpdated(string newURI);
    event MetadataUpdated(string newMetadata);
    event PredictionRequested(address indexed user, string eegData);
    event PredictionStored(address indexed user, string result);
    event ModelAccuracyUpdated(uint256 newAccuracy);
    event ModelVoted(string modelURI, uint256 votes);
    event BrainSignatureStored(address indexed user, string signature);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor(string memory initialURI, string memory initialMetadata, uint256 initialAccuracy) {
        owner = msg.sender;
        modelURI = initialURI;
        modelMetadata = initialMetadata;
        modelAccuracy = initialAccuracy;
    }

    // Update AI Model URI (stored off-chain, like IPFS)
    function updateModelURI(string memory newURI) public onlyOwner {
        modelURI = newURI;
        emit ModelUpdated(newURI);
    }

    function getModelURI() public view returns (string memory) {
        return modelURI;
    }

    // Update model metadata (JSON format with details about architecture, dataset, etc.)
    function updateModelMetadata(string memory newMetadata) public onlyOwner {
        modelMetadata = newMetadata;
        emit MetadataUpdated(newMetadata);
    }

    function getModelMetadata() public view returns (string memory) {
        return modelMetadata;
    }

    // Allow users to request an EEG prediction
    function requestPrediction(string memory eegData) public {
        emit PredictionRequested(msg.sender, eegData);
    }

    // Store AI-generated predictions on-chain
    function storePrediction(string memory result) public {
        userPredictions[msg.sender] = result;
        emit PredictionStored(msg.sender, result);
    }

    function getPrediction(address user) public view returns (string memory) {
        return userPredictions[user];
    }

    // Update model accuracy (ensuring it only improves)
    function updateModelAccuracy(uint256 newAccuracy) public onlyOwner {
        require(newAccuracy > modelAccuracy, "New model must be better!");
        modelAccuracy = newAccuracy;
        emit ModelAccuracyUpdated(newAccuracy);
    }

    // function to get model accuracy
    function getModelAccuracy() public view returns (uint256) {
        return modelAccuracy;
    }

    // Allow users to vote for a better AI model
    function voteForModel(string memory _modelURI) public {  
        modelVotes[_modelURI] += 1; 
        emit ModelVoted(_modelURI, modelVotes[_modelURI]);
    }

    function getModelVotes(string memory _modelURI) public view returns (uint256) {  
        return modelVotes[_modelURI];
    }

    // Store a unique brain signature for each user
    function storeBrainSignature(string memory signature) public {
        userBrainSignature[msg.sender] = signature;
        emit BrainSignatureStored(msg.sender, signature);
    }

    function getBrainSignature(address user) public view returns (string memory) {
        return userBrainSignature[user];
    }
}

