
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Crowdfunding is ReentrancyGuard, Ownable {
    struct Campaign {
        address creator;
        string title;
        string description;
        uint256 goal;
        uint256 raised;
        uint256 deadline;
        bool completed;
        mapping(address => uint256) contributions;
    }
    
    uint256 public campaignCount;
    mapping(uint256 => Campaign) public campaigns;
    
    event CampaignCreated(uint256 indexed id, string title, uint256 goal);
    event Donated(uint256 indexed id, address donor, uint256 amount);
    event Withdrawn(uint256 indexed id, address creator, uint256 amount);
    
    function createCampaign(
        string memory _title,
        string memory _description,
        uint256 _goal,
        uint256 _durationDays
    ) external {
        require(_goal > 0, "Goal must be positive");
        campaignCount++;
        Campaign storage newCampaign = campaigns[campaignCount];
        newCampaign.creator = msg.sender;
        newCampaign.title = _title;
        newCampaign.description = _description;
        newCampaign.goal = _goal;
        newCampaign.deadline = block.timestamp + (_durationDays * 1 days);
        emit CampaignCreated(campaignCount, _title, _goal);
    }
    
    function donate(uint256 _campaignId) external payable nonReentrant {
        Campaign storage campaign = campaigns[_campaignId];
        require(block.timestamp < campaign.deadline, "Campaign ended");
        require(!campaign.completed, "Campaign completed");
        require(msg.value > 0, "Donation must be positive");
        campaign.raised += msg.value;
        campaign.contributions[msg.sender] += msg.value;
        emit Donated(_campaignId, msg.sender, msg.value);
        if (campaign.raised >= campaign.goal) {
            campaign.completed = true;
        }
    }
    
    function withdrawFunds(uint256 _campaignId) external nonReentrant {
        Campaign storage campaign = campaigns[_campaignId];
        require(msg.sender == campaign.creator, "Not creator");
        require(campaign.completed, "Campaign not completed");
        require(campaign.raised > 0, "No funds to withdraw");
        uint256 amount = campaign.raised;
        campaign.raised = 0;
        payable(campaign.creator).transfer(amount);
        emit Withdrawn(_campaignId, campaign.creator, amount);
    }
    
    function getCampaignInfo(uint256 _campaignId)
        external
        view
        returns (
            address creator,
            string memory title,
            uint256 goal,
            uint256 raised,
            uint256 deadline,
            bool completed
        )
    {
        Campaign storage c = campaigns[_campaignId];
        return (c.creator, c.title, c.goal, c.raised, c.deadline, c.completed);
    }
    
    function getContribution(uint256 _campaignId, address _donor)
        external
        view
        returns (uint256)
    {
        return campaigns[_campaignId].contributions[_donor];
    }
}