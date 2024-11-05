// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {TokenLendExploit} from "src/TokenLend/TokenLendExploit.sol";
import {TokenLendBaseTest} from "test/TokenLend/TokenLendBase.t.sol";

contract TokenLendTest is TokenLendBaseTest {
    TokenLendExploit public tokenLendExploit;

    function testTokenLendExploit() public checkSolved {
        // DO NOT use any cheat codes here.
        // @todo
        tokenLendExploit = new TokenLendExploit(
            address(stEth),
            address(pool),
            address(lender)
        );

        stEth.transfer(address(tokenLendExploit), 2 ether);

        tokenLendExploit.exploit{value: 2 ether}();
    }
}
