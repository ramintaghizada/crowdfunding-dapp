

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract SimpleStaking is ReentrancyGuard {
    IERC20 public stakingToken;
    mapping(address => uint256) public balances;
    uint256 public totalStaked;
    
    event Staked(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);
    
    constructor(address _tokenAddress) {
        stakingToken = IERC20(_tokenAddress);
    }
    
    function stake(uint256 _amount) external nonReentrant {
        require(_amount > 0, "Cannot stake 0");
        stakingToken.transferFrom(msg.sender, address(this), _amount);
        balances[msg.sender] += _amount;
        totalStaked += _amount;
        emit Staked(msg.sender, _amount);
    }
    
    function withdraw(uint256 _amount) external nonReentrant {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        totalStaked -= _amount;
        stakingToken.transfer(msg.sender, _amount);
        emit Withdrawn(msg.sender, _amount);
    }
    
    function getBalance(address _user) external view returns (uint256) {
        return balances[_user];
    }
}