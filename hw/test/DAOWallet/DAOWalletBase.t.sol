// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {Test, console2} from "forge-std/Test.sol";
import {DAOWallet} from "src/DAOWallet/DAOWallet.sol";

/**
 * DO NOT MODIFY THIS FILE, OR YOU WILL GET ZERO POINTS FROM THIS CHALLENGE
 */
contract DAOWalletBaseTest is Test {
    address internal player = makeAddr("player");

    DAOWallet internal daoWallet;

    modifier checkSolved() {
        vm.startPrank(player, player);
        _;
        vm.stopPrank();

        _isSolved();
    }

    function setUp() public virtual {
        daoWallet = new DAOWallet();

        vm.deal(address(daoWallet), 102 ether);
        vm.deal(player, 2 ether);
    }

    function _isSolved() private view {
        assertEq(
            address(daoWallet).balance,
            0,
            "The DAOWallet still has funds"
        );
        assertEq(
            player.balance,
            104 ether,
            "The player has not stolen enough tokens from the bank"
        );
    }
}
