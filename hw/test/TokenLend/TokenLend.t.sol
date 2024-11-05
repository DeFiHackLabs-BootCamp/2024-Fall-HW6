// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {TokenLendBaseTest} from "test/TokenLend/TokenLendBase.t.sol";

contract TokenLendTest is TokenLendBaseTest {
    function testTokenLendExploit() public checkSolved {
        // DO NOT use any cheat codes here.
        // @todo you start from 2 ETH and 2 stETH, exploit the contract’s vulnerabilities to create extra tokens
    }
}
