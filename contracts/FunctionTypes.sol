
pragma solidity ^0.8.0;

contract FunctionTypes {
    uint256 private secretNumber = 42;
    
    function publicFunction() public view returns (uint256) {
        return secretNumber;
    }
    
    function privateFunction() private view returns (uint256) {
        return secretNumber;
    }
    
    function internalFunction() internal view returns (uint256) {
        return secretNumber;
    }
    
    function externalFunction() external view returns (uint256) {
        return secretNumber;
    }
    
    function pureFunction() public pure returns (uint256) {
        return 2 + 2;
    }
    
    function viewFunction() public view returns (uint256) {
        return block.timestamp;
    }
    
    function payableFunction() public payable returns (uint256) {
        return msg.value;
    }
}