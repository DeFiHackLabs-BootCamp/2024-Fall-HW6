// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {SimpleBankExploit} from "src/SimpleBank/SimpleBankExploit.sol";
import {SimpleBankBaseTest} from "test/SimpleBank/SimpleBankBase.t.sol";

contract SimpleBankTest is SimpleBankBaseTest {
    SimpleBankExploit public simpleBankExploit;

    function testSimpleBankExploit() public checkSolved {
        // DO NOT use any cheat codes here.
        // @todo drain all ETH from SimpleBank contract
        simpleBankExploit = new SimpleBankExploit{value: 1 ether}(
            address(simpleBank)
        );
        simpleBankExploit.exploit();
    }
}
