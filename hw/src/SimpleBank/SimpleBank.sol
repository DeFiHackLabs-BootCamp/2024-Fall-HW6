// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract SimpleBank {
    mapping(address user => uint256) private balance;

    error NotEnoughFunds();
    error FailToSendETH();

    function deposit() external payable {
        balance[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        if (amount > balance[msg.sender]) revert NotEnoughFunds();

        (bool success, ) = payable(msg.sender).call{value: amount}("");
        if (!success) revert FailToSendETH();

        balance[msg.sender] -= amount;
    }

    function withdrawAll() external {
        if (balance[msg.sender] == 0) revert NotEnoughFunds();

        uint256 amount = balance[msg.sender];
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        if (!success) revert FailToSendETH();

        balance[msg.sender] = 0;
    }

    function amount(address _user) public view returns (uint256) {
        return balance[_user];
    }
}
