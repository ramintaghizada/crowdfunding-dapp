
pragma solidity ^0.8.0;

contract SimpleStorage {
    uint256 public favoriteNumber;
    address public owner;
    
    constructor() {
        owner = msg.sender;
        favoriteNumber = 42;
    }
    
    function setNumber(uint256 _newNumber) public {
        require(msg.sender == owner, "Not authorized!");
        favoriteNumber = _newNumber;
    }
    
    function getNumber() public view returns (uint256) {
        return favoriteNumber;
    }
}