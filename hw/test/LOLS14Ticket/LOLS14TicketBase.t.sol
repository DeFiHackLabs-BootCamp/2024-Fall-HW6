// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {Test, console2} from "forge-std/Test.sol";
import {LOLS14Ticket} from "src/LOLS14Ticket/LOLS14Ticket.sol";

/**
 * DO NOT MODIFY THIS FILE, OR YOU WILL GET ZERO POINTS FROM THIS CHALLENGE
 */
contract LOLS14TicketBaseTest is Test {
    address internal player = makeAddr("player");

    LOLS14Ticket internal lolS14Ticket;

    modifier checkSolved() {
        vm.startPrank(player, player);
        _;
        vm.stopPrank();

        _isSolved();
    }

    function setUp() public virtual {
        lolS14Ticket = new LOLS14Ticket();
    }

    function _isSolved() private view {
        assertEq(
            lolS14Ticket.balanceOf(player),
            10,
            "The player needs to grab all the tickets"
        );
    }
}
