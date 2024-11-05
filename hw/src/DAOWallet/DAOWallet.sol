// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {ReentrancyGuard} from "openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol";

contract DAOWallet is ReentrancyGuard {
    mapping(address user => uint256) private balance;

    error NotEnoughBalance();
    error FailToSendETH();

    function deposit() external payable {
        balance[msg.sender] += msg.value;
    }

    function withdraw() external nonReentrant {
        if (balance[msg.sender] == 0) revert NotEnoughBalance();

        uint256 amount = balance[msg.sender];
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        if (!success) revert FailToSendETH();

        balance[msg.sender] = 0;
    }

    function transfer(address _recipient, uint256 _amount) external {
        if (_amount > balance[msg.sender]) revert NotEnoughBalance();

        balance[msg.sender] -= _amount;
        balance[_recipient] += _amount;
    }

    function userBalance(address user) public view returns (uint256) {
        return balance[user];
    }
}
