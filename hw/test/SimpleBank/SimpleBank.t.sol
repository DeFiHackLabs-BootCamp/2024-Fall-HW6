// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {SimpleBankBaseTest} from "test/SimpleBank/SimpleBankBase.t.sol";

contract SimpleBankTest is SimpleBankBaseTest {
    function testSimpleBankExploit() public checkSolved {
        // DO NOT use any cheat codes here.
        // @todo drain all ETH from SimpleBank contract
    }
}
