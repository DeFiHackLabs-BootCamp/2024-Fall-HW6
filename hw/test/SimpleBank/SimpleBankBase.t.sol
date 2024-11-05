// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {Test, console2} from "forge-std/Test.sol";
import {SimpleBank} from "src/SimpleBank/SimpleBank.sol";

/**
 * DO NOT MODIFY THIS FILE, OR YOU WILL GET ZERO POINTS FROM THIS CHALLENGE
 */
contract SimpleBankBaseTest is Test {
    address internal player = makeAddr("player");

    SimpleBank internal simpleBank;

    modifier checkSolved() {
        vm.startPrank(player, player);
        _;
        vm.stopPrank();

        _isSolved();
    }

    function setUp() public virtual {
        simpleBank = new SimpleBank();

        vm.deal(address(simpleBank), 10 ether);
        vm.deal(player, 1 ether);
    }

    function _isSolved() private view {
        assertEq(address(simpleBank).balance, 0, "Simple bank still has funds");
        assertEq(
            player.balance,
            11 ether,
            "The player has not stolen enough tokens from the bank"
        );
    }
}
