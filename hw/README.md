# DeFiHackLabs BootCamp - Week2 Homework Bonus

> [!WARNING]
> DO NOT MODIFY THE `SimpleBankBase.t.sol`, `LOLS14TicketBase.t.sol`, `DAOWalletBase.t.sol`, `TokenLendBase.t.sol` FILES, OR YOU WILL GET ZERO POINTS FROM THIS CHALLENGE

### Task 1 - SimpleBank

Welcome to the `SimpleBank`, a straightforward smart contract where any user can deposit and withdraw their ETH. 🏦✨

The contract currently holds 10 ETH, carefully managed for its users.

📌 `SimpleBank` has two core functions: allowing users to safely deposit their ETH and withdraw it fully or partially when needed.

However, this bank may not be as secure as it seems. 😈💰

Your task: find a way to exploit `SimpleBank` and drain all 10 ETH from the contract.

Can you crack the code and make off with the bank’s entire vault? 🌪️💸

### Task 2 - LOLS14Ticket

The LOL S14 World Championship is here, and LOLS14Ticket has just been deployed as an ERC721 contract to distribute free tickets! 🎟️🎮

📌 There are only 10 free tickets in total, open for anyone to claim. Each person is limited to one ticket, so only the fastest 10 people will succeed!

Your task: find a way to exploit the contract and claim all 10 tickets for yourself. 😈💥

Can you outsmart the contract and grab every single ticket to the LOL S14 World Championship? 🌪️🎫

### Task 3 - DAOWallet

The infamous DAO attack of 2016 changed everything, leading to the split between Ethereum and Ethereum Classic. Since then, developers have become vigilant, adding protections against reentrancy attacks in critical functions. 🚨🛡️

In this challenge, the developers of `DAOWallet` carefully implemented a nonReentrant modifier to guard against reentrancy attacks. They’re confident it’s safe—but is it really? 🤔

📌 `DAOWallet` currently holds 102 ETH.

Your task: uncover the hidden vulnerability and steal all 102 ETH from `DAOWallet`. 😈💰

Can you prove that even the best defenses can sometimes fail? 🌪️💸

### Task 4 - TokenLend

In this challenge, you’ll face a liquidity pool contract for ETH-stETH, which serves as a data source for a lending protocol. 📊💸

📌 The LiquidityPool contract provides key functions for liquidity management and price retrieval:

addLiquidity() to supply both ETH and stETH,
removeLiquidity() to withdraw liquidity,
getSpotPriceStEth() and getSpotPriceEth() to check spot prices for each asset.
Despite having nonReentrant protection on all functions and carefully placed external calls, a vulnerability still exists, offering a pathway to generate additional value. 😈💥

Your task: exploit the contract’s vulnerabilities to create extra value. You’ll start with 2 ETH and 2 stETH (total value of 4 ETH) and aim to increase your holdings to at least 4.483 ETH in combined value through the exploit.
