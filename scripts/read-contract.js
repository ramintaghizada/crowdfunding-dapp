const hre = require("hardhat");

async function main() {
  const CONTRACT_ADDRESS = "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512";
  
  const Crowdfunding = await hre.ethers.getContractFactory("Crowdfunding");
  const crowdfunding = await Crowdfunding.attach(CONTRACT_ADDRESS);
  
  // Read campaign count
  const campaignCount = await crowdfunding.campaignCount();
  console.log("Total campaigns:", campaignCount.toString());
  
  // If there are campaigns, read the first one
  if (campaignCount > 0) {
    const campaign = await crowdfunding.getCampaignInfo(1);
    console.log("Campaign 1:");
    console.log("  Creator:", campaign[0]);
    console.log("  Title:", campaign[1]);
    console.log("  Goal:", hre.ethers.formatEther(campaign[2]), "ETH");
    console.log("  Raised:", hre.ethers.formatEther(campaign[3]), "ETH");
    console.log("  Deadline:", new Date(Number(campaign[4]) * 1000));
    console.log("  Completed:", campaign[5]);
  }
}

main().catch(console.error);