// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {ERC721} from "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {ERC721Enumerable} from "openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract LOLS14Ticket is ERC721, ERC721Enumerable {
    uint256 private _nextTokenId;
    mapping(address buyer => bool) private hasBought;

    error InvalidMsgValue();
    error AlreadyBoughtTicket();
    error TicketSoldOut();

    constructor() ERC721("LOL S14 Ticket", "LEGENDS NEVER DIE") {}

    function buy() external payable {
        // everyone is only allowed to buy one ticket
        if (hasBought[msg.sender]) revert AlreadyBoughtTicket();
        if (totalSupply() > 10) revert TicketSoldOut();

        uint256 tokenId = _nextTokenId++;
        _safeMint(msg.sender, tokenId);

        hasBought[msg.sender] = true;
    }

    // Function override required by Solidity.
    function _update(
        address to,
        uint256 tokenId,
        address auth
    ) internal override(ERC721, ERC721Enumerable) returns (address) {
        return super._update(to, tokenId, auth);
    }

    // Function override required by Solidity.
    function _increaseBalance(
        address account,
        uint128 value
    ) internal override(ERC721, ERC721Enumerable) {
        super._increaseBalance(account, value);
    }

    // Function override required by Solidity.
    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
