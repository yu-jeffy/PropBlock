pragma solidity >= 0.6.0 < 0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract HousingVoucherNFT is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    mapping(uint256 => uint256) private _voucherAmounts;

    // Additional mappings for extra functionality
    mapping(uint256 => uint) public voucherExpirationDates;
    mapping(uint256 => address) public voucherRedeemers;

    // Voucher expiration parameters and time-related constants
    uint public constant ANNUAL_DURATION_SECONDS = 365 days;
    uint public constant GRACE_PERIOD_SECONDS = 7 days;

    constructor() ERC721("HousingVoucher", "HVNFT") {}

    // Existing mint function for creating new HousingVoucherNFTs
    // ...

    // Function to update the voucher expiration date when voucher is transferred
    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override
    {
        ERC721._beforeTokenTransfer(from, to, tokenId);

        if (from != address(0) && to != address(0)) {
            // Update the voucherExpirationDates mapping with a new expiration date.
            voucherExpirationDates[tokenId] = block.timestamp + ANNUAL_DURATION_SECONDS;
        }
    }

    // Function to check if a voucher has expired
    function isVoucherExpired(uint256 tokenId) public view returns (bool) {
        return block.timestamp > voucherExpirationDates[tokenId];
    }

    // Function to allow landlords to redeem a voucher
    function redeemVoucher(uint256 tokenId) public {
        require(ownerOf(tokenId) != address(0), "Nonexistent voucher.");
        require(!isVoucherExpired(tokenId), "Voucher has expired.");
        require(voucherRedeemers[tokenId] == address(0), "Voucher has already been redeemed.");
        
        _burn(tokenId); // Burn the voucher after redemption to prevent reuse
        voucherRedeemers[tokenId] = msg.sender; // Record the redeemer (landlord) for reference
    }

    // Function to enable users to extend voucher expiration date during the grace period
    function extendVoucherExpiration(uint256 tokenId) public {
        require(ownerOf(tokenId) == msg.sender, "Only voucher owner can extend its expiration date.");
        require(isVoucherExpired(tokenId), "Voucher hasn't expired yet.");
        require(block.timestamp <= voucherExpirationDates[tokenId] + GRACE_PERIOD_SECONDS, "Grace period for extending expired voucher has passed.");

        voucherExpirationDates[tokenId] = block.timestamp + ANNUAL_DURATION_SECONDS;
    }
}
