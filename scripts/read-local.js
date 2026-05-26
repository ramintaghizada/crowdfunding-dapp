const hre = require("hardhat");

async function main() {
  // Use the address from your deployment
  const CONTRACT_ADDRESS = "0xe7f1725e7734ce288f8367e1bb143e90bb3f0512";
  
  console.log("Connecting to contract at:", CONTRACT_ADDRESS);
  
  const Crowdfunding = await hre.ethers.getContractFactory("Crowdfunding");
  const crowdfunding = await Crowdfunding.attach(CONTRACT_ADDRESS);
  
  // Read campaign count
  const campaignCount = await crowdfunding.campaignCount();
  console.log("📊 Total campaigns:", campaignCount.toString());
  
  // If there are campaigns, show them
  if (campaignCount > 0) {
    for (let i = 1; i <= campaignCount; i++) {
      const campaign = await crowdfunding.getCampaignInfo(i);
      console.log(`\n🎯 Campaign #${i}:`);
      console.log(`   Title: ${campaign[1]}`);
      console.log(`   Goal: ${hre.ethers.formatEther(campaign[2])} ETH`);
      console.log(`   Raised: ${hre.ethers.formatEther(campaign[3])} ETH`);
      console.log(`   Completed: ${campaign[5]}`);
    }
  }
}

main().catch(console.error);