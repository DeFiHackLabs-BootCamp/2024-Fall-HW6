// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {Test, console2} from "forge-std/Test.sol";
import {LPToken} from "src/TokenLend/LPToken.sol";
import {SyntheticETH} from "src/TokenLend/SyntheticETH.sol";
import {LiquidityPool} from "src/TokenLend/LiquidityPool.sol";
import {Lender} from "src/TokenLend/Lender.sol";

contract TokenLendBaseTest is Test {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");
    uint256 public constant USR_PARTICIPATION = 10 ether;

    LPToken public lpToken;
    SyntheticETH public stEth;
    LiquidityPool public pool;
    Lender public lender;

    // roles
    address public liquidityProvider = makeAddr("liquidityProvider");
    address public player = makeAddr("player");

    modifier checkSolved() {
        vm.startPrank(player, player);
        _;
        vm.stopPrank();

        _isSolved();
    }

    function setUp() public {
        lpToken = new LPToken();
        stEth = new SyntheticETH();
        pool = new LiquidityPool(address(stEth), address(lpToken));
        lender = new Lender(address(stEth), address(pool));

        // Initial set up
        lpToken.grantRole(MINTER_ROLE, address(pool));
        lpToken.grantRole(BURNER_ROLE, address(pool));

        // Funding both parties
        vm.deal(address(lender), 100 ether);
        stEth.mint(address(lender), 100 ether);
        vm.deal(liquidityProvider, 1 ether);
        stEth.mint(liquidityProvider, 1 ether);

        // add liquidity
        vm.startPrank(liquidityProvider);
        stEth.approve(address(pool), 1 ether);
        pool.addLiquidity{value: 1 ether}(1 ether, 1 ether);
        vm.stopPrank();

        vm.deal(player, 2 ether);
        stEth.mint(player, 2 ether);
    }

    function _isSolved() private view {
        assertGt(stEth.balanceOf(player), 2 ether);
        assertGt(player.balance + stEth.balanceOf(player), 4 ether);
    }
}
