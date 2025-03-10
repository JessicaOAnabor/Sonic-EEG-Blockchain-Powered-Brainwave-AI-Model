const hre = require("hardhat");

async function main() {
    console.log("Deploying EEG Model Storage contract...");

    const EEGModelStorage = await hre.ethers.getContractFactory("EEGModelStorage");

    // Initialize with IPFS link, metadata, and model accuracy
    const modelURI = "https://ipfs.io/ipfs/bafkreievnqztqgvkqdsjynx44p2qhrd7zkicbrel76bsk36hllunpzfqlu";
    const modelMetadata = "Initial EEG Model for Brainwave Analysis";
    const modelAccuracy = 85; // Example accuracy in percentage

    const model = await EEGModelStorage.deploy(modelURI, modelMetadata, modelAccuracy);
    
    // Wait for deployment confirmation
    await model.waitForDeployment();

    console.log(`EEG Model Contract deployed to: ${await model.getAddress()}`);
}

main().catch((error) => {
    console.error("Deployment failed:", error);
    process.exitCode = 1;
});

