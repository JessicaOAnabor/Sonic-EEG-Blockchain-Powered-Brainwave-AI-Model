require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
    solidity: "0.8.19",
    networks: {
        sonicblaze: {
            url: "https://rpc.blaze.soniclabs.com",
            accounts: [process.env.PRIVATE_KEY],
        },
    },
};
