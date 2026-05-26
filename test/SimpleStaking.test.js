const { expect } = require("chai");

describe("SimpleStaking", function() {
    let staking;
    let token;
    let owner, user1;
    
    beforeEach(async function() {
        [owner, user1] = await ethers.getSigners();
        const SimpleToken = await ethers.getContractFactory("SimpleToken");
        token = await SimpleToken.deploy("Stake Token", "STK");
        await token.deployed();
        
        const SimpleStaking = await ethers.getContractFactory("SimpleStaking");
        staking = await SimpleStaking.deploy(token.address);
        await staking.deployed();
        
        await token.transfer(user1.address, ethers.utils.parseEther("1000"));
        await token.connect(user1).approve(staking.address, ethers.utils.parseEther("1000"));
    });
    
    it("Should allow staking", async function() {
        const stakeAmount = ethers.utils.parseEther("100");
        await staking.connect(user1).stake(stakeAmount);
        const balance = await staking.balances(user1.address);
        expect(balance).to.equal(stakeAmount);
    });
    
    it("Should update total staked", async function() {
        const stakeAmount = ethers.utils.parseEther("100");
        await staking.connect(user1).stake(stakeAmount);
        const totalStaked = await staking.totalStaked();
        expect(totalStaked).to.equal(stakeAmount);
    });
    
    it("Should allow withdrawal", async function() {
        const stakeAmount = ethers.utils.parseEther("100");
        await staking.connect(user1).stake(stakeAmount);
        await staking.connect(user1).withdraw(stakeAmount);
        const balance = await staking.balances(user1.address);
        expect(balance).to.equal(0);
    });
});