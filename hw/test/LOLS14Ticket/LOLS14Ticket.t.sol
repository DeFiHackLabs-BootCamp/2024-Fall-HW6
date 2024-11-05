// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {LOLS14TicketExploit} from "src/LOLS14Ticket/LOLS14TicketExploit.sol";
import {LOLS14TicketBaseTest} from "test/LOLS14Ticket/LOLS14TicketBase.t.sol";

contract LOLS14TicketTest is LOLS14TicketBaseTest {
    LOLS14TicketExploit public lolS14TicketExploit;

    function testLOLS14TicketExploit() public checkSolved {
        // DO NOT use any cheat codes here.
        // @todo drain all tickets from LOLS14Ticket contract
        lolS14TicketExploit = new LOLS14TicketExploit(address(lolS14Ticket));
        lolS14TicketExploit.exploit();
    }
}
