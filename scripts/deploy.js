const hre = require("hardhat");

async function main() {
  const Crowdfunding = await hre.ethers.getContractFactory("Crowdfunding");
  const crowdfunding = await Crowdfunding.deploy();
  await crowdfunding.waitForDeployment();
  
  console.log("Crowdfunding deployed to SEPOLIA at:", await crowdfunding.getAddress());
  console.log("Network:", await hre.ethers.provider.getNetwork());
}

main().catch(console.error);