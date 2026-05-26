
pragma solidity ^0.8.0;

contract AccessControl {
    address public owner;
    
    error Unauthorized(address caller);
    
    constructor() {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        if (msg.sender != owner) revert Unauthorized(msg.sender);
        _;
    }
    
    modifier validAmount(uint _amount) {
        require(_amount > 0, "Amount must be > 0");
        _;
    }
    
    function withdraw(uint _amount) 
        public 
        onlyOwner 
        validAmount(_amount) 
    {
        payable(msg.sender).transfer(_amount);
    }
    
    function changeOwner(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }
}