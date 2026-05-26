

pragma solidity ^0.8.0;

contract EventExample {
    event Transfer(address indexed from, address indexed to, uint256 amount);
    event UserRegistered(string name, uint256 timestamp);
    
    mapping(address => bool) public registered;
    
    function register(string memory _name) public {
        require(!registered[msg.sender], "Already registered");
        registered[msg.sender] = true;
        emit UserRegistered(_name, block.timestamp);
        emit Transfer(address(0), msg.sender, 100);
    }
}