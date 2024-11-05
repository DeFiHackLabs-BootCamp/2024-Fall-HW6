// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {DAOWalletBaseTest} from "test/DAOWallet/DAOWalletBase.t.sol";

contract DAOWalletTest is DAOWalletBaseTest {
    function testDAOWalletExploit() public checkSolved {
        // DO NOT use any cheat codes here.
        // @todo drain all ETH from DAOWallet contract
    }
}
