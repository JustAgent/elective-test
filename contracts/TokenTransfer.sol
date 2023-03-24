// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(address to, uint256 value) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}

contract TokenTransfer {
    address private _tokenAddress;
    address private _owner;
    
    constructor(address tokenAddress) {
        _tokenAddress = tokenAddress;
        _owner = msg.sender;
    }
    
    function deposit(uint256 amount) external {
        require(IERC20(_tokenAddress).transferFrom(msg.sender, address(this), amount), "Transfer failed");
    }
    
    function withdraw(uint256 amount) external {
        require(IERC20(_tokenAddress).transfer(_owner, amount), "Transfer failed");
    }
    
    function transfer(address to, uint256 amount) external {
        require(IERC20(_tokenAddress).balanceOf(address(this)) >= amount, "Insufficient balance");
        require(IERC20(_tokenAddress).transfer(to, amount), "Transfer failed");
    }
    
    function getBalance() external view returns (uint256) {
        return IERC20(_tokenAddress).balanceOf(address(this));
    }
}
