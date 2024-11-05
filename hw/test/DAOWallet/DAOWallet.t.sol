// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {DAOWalletExploit} from "src/DAOWallet/DAOWalletExploit.sol";
import {DAOWalletBaseTest} from "test/DAOWallet/DAOWalletBase.t.sol";

contract DAOWalletTest is DAOWalletBaseTest {
    DAOWalletExploit public daoWalletExploit1;
    DAOWalletExploit public daoWalletExploit2;

    function testDAOWalletExploit() public checkSolved {
        // DO NOT use any cheat codes here.
        // @todo drain all ETH from DAOWallet contract
        daoWalletExploit1 = new DAOWalletExploit{value: 1 ether}(
            address(daoWallet)
        );
        daoWalletExploit2 = new DAOWalletExploit{value: 1 ether}(
            address(daoWallet)
        );

        daoWalletExploit1.setSidekick(address(daoWalletExploit2));
        daoWalletExploit2.setSidekick(address(daoWalletExploit1));

        daoWalletExploit1.exploit();
    }
}
