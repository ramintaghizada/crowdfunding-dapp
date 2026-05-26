const { expect } = require("chai");

describe("Crowdfunding", function() {
    let crowdfunding;
    let owner, donor1, donor2;
    
    beforeEach(async function() {
        [owner, donor1, donor2] = await ethers.getSigners();
        const Crowdfunding = await ethers.getContractFactory("Crowdfunding");
        crowdfunding = await Crowdfunding.deploy();
        await crowdfunding.deployed();
        await crowdfunding.createCampaign(
            "Test Campaign",
            "Test Description",
            ethers.utils.parseEther("10"),
            30
        );
    });
    
    it("Should accept donations", async function() {
        const donationAmount = ethers.utils.parseEther("1");
        await expect(
            crowdfunding.connect(donor1).donate(1, { value: donationAmount })
        ).to.emit(crowdfunding, "Donated")
         .withArgs(1, donor1.address, donationAmount);
        const contribution = await crowdfunding.getContribution(1, donor1.address);
        expect(contribution).to.equal(donationAmount);
    });
    
    it("Should not allow donations after deadline", async function() {
        await ethers.provider.send("evm_increaseTime", [31 * 24 * 60 * 60]);
        await ethers.provider.send("evm_mine");
        await expect(
            crowdfunding.connect(donor1).donate(1, { value: 1 })
        ).to.be.revertedWith("Campaign ended");
    });
    
    it("Should allow creator to withdraw funds", async function() {
        const donationAmount = ethers.utils.parseEther("10");
        await crowdfunding.connect(donor1).donate(1, { value: donationAmount });
        await expect(crowdfunding.connect(owner).withdrawFunds(1))
            .to.emit(crowdfunding, "Withdrawn")
            .withArgs(1, owner.address, donationAmount);
    });
    
    it("Should not allow non-creator to withdraw", async function() {
        const donationAmount = ethers.utils.parseEther("1");
        await crowdfunding.connect(donor1).donate(1, { value: donationAmount });
        await expect(
            crowdfunding.connect(donor1).withdrawFunds(1)
        ).to.be.revertedWith("Not creator");
    });
});