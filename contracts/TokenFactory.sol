

pragma solidity ^0.8.0;

contract TokenFactory {
    address[] public allTokens;
    event TokenCreated(address tokenAddress, string name, string symbol);
    
    function createToken(
        string memory _name,
        string memory _symbol
    ) external returns (address) {
        SimpleToken newToken = new SimpleToken(_name, _symbol);
        address tokenAddress = address(newToken);
        allTokens.push(tokenAddress);
        emit TokenCreated(tokenAddress, _name, _symbol);
        return tokenAddress;
    }
    
    function getAllTokens() external view returns (address[] memory) {
        return allTokens;
    }
    
    function getTokenCount() external view returns (uint256) {
        return allTokens.length;
    }
}

contract SimpleToken {
    string public name;
    string public symbol;
    mapping(address => uint256) public balanceOf;
    
    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
        balanceOf[msg.sender] = 1000 * 10**18;
    }
    
    function transfer(address _to, uint256 _amount) external returns (bool) {
        require(balanceOf[msg.sender] >= _amount, "Insufficient balance");
        balanceOf[msg.sender] -= _amount;
        balanceOf[_to] += _amount;
        return true;
    }
}