
pragma solidity ^0.8.0;

contract DataTypes {
    bool public isActive = true;
    uint8 public smallNumber = 255;
    uint256 public bigNumber = 1000;
    int256 public negativeNumber = -42;
    address public wallet = 0x0000000000000000000000000000000000000000;
    bytes32 public data = "Hello";
    string public text = "Hello World";
    uint[] public numbers = [1, 2, 3];
    uint[3] public fixedArray = [1,2,3];
    mapping(address => uint256) public balances;
    
    struct Person {
        string name;
        uint256 age;
        address wallet;
    }
    Person[] public people;
    
    enum Status { Pending, Active, Completed }
    Status public currentStatus = Status.Pending;
    
    function addPerson(string memory _name, uint256 _age) public {
        people.push(Person(_name, _age, msg.sender));
    }
}