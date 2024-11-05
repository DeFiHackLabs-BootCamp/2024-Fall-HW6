// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {ReentrancyGuard} from "openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol";
import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

interface ILiquidityPool {
    function getSpotPriceStEth(uint256 amount) external view returns (uint256);
}

contract Lender is ReentrancyGuard {
    struct Loan {
        uint256 amount;
        uint256 collateral;
    }

    uint256 private constant FEE_PERCENTAGE = 5;
    uint256 private constant OVERCOLLATERALLIZATION_PERCENTAGE = 150;

    IERC20 public stEthToken;
    ILiquidityPool public pool;

    mapping(address loaner => Loan) public loans;

    error LoanAlreadyExists();
    error InsufficientLoanAmount();
    error InsufficientCollateral();
    error LoanNotFound();
    error RepaymentTransferFailed();

    constructor(address token_address, address _pool) {
        stEthToken = IERC20(token_address);
        pool = ILiquidityPool(_pool);
    }

    function borrowStEth(uint256 amount) external payable {
        if (loans[msg.sender].amount != 0) revert LoanAlreadyExists();

        uint256 price = pool.getSpotPriceStEth(amount);
        uint256 required_collateral = (price *
            OVERCOLLATERALLIZATION_PERCENTAGE) / 100;
        if (required_collateral == 0) revert InsufficientLoanAmount();

        uint256 collateral_with_fee = (price *
            (OVERCOLLATERALLIZATION_PERCENTAGE + FEE_PERCENTAGE)) / 100;
        if (collateral_with_fee > msg.value) revert InsufficientCollateral();
        loans[msg.sender] = Loan(amount, required_collateral);
        stEthToken.transfer(msg.sender, amount);
    }

    function repay() external payable {
        if (loans[msg.sender].amount == 0) revert LoanNotFound();

        uint256 steth_lent = loans[msg.sender].amount;
        uint256 eth_to_return = loans[msg.sender].collateral;
        delete loans[msg.sender];

        stEthToken.transferFrom(msg.sender, address(this), steth_lent);

        (bool success, ) = payable(msg.sender).call{value: eth_to_return}("");
        if (!success) revert RepaymentTransferFailed();
    }
}
