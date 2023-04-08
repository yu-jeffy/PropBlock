pragma solidity >= 0.6.0 < 0.9.0;

import "./VoucherNFT.sol";

contract EnhancedEligibilityVerification {
    struct Applicant {
        uint familySize;
        uint annualIncome;
        uint jobStabilityScore;
        uint creditScore;
        uint voucherAmount;
        bool isEligible;
        bool isAssigned;
    }

    address payable public housingAuthority;
    mapping(address => Applicant) public applicants;
    VoucherNFT public voucherNFT;

    uint constant public CREDIT_SCORE_THRESHOLD = 600;
    uint constant public TENANCY_BONUS_PERCENT = 10;

    event ParticipantRewarded(address participant, uint rewardAmount);

    constructor(address _voucherNFT) {
        housingAuthority = msg.sender;
        voucherNFT = VoucherNFT(_voucherNFT);
    }

    function registerApplicant(
        address _applicant,
        uint _familySize,
        uint _annualIncome,
        uint _jobStabilityScore,
        uint _creditScore
    ) public {
        require(msg.sender == housingAuthority, "Only housing authority can register applicants.");
        require(applicants[_applicant].familySize == 0, "Applicant already exists.");
        applicants[_applicant] = Applicant({
            familySize: _familySize,
            annualIncome: _annualIncome,
            jobStabilityScore: _jobStabilityScore,
            creditScore: _creditScore,
            voucherAmount: 0,
            isEligible: false,
            isAssigned: false
        });
    }

    function verifyEligibility(address _applicant) public {
        require(msg.sender == housingAuthority, "Only housing authority can verify eligibility.");
        Applicant storage applicant = applicants[_applicant];

        // Improve the eligibility criteria with custom logic, such as considering job stability and credit scores.
        bool eligibilityStatus = isEligible(applicant);
        if (eligibilityStatus) {
            applicant.isEligible = true;

            // Encourage responsible participation by rewarding high-credit score applicants with bonus voucher amounts.
            if (applicant.creditScore >= CREDIT_SCORE_THRESHOLD) {
                applicant.voucherAmount +=
                    (calculateVoucherAmount(applicant) * TENANCY_BONUS_PERCENT) / 100;
            }
            emit ParticipantRewarded(_applicant, applicant.voucherAmount);
        }
    }

    function assignVoucher(address _applicant) public {
        require(msg.sender == housingAuthority, "Only housing authority can assign vouchers.");
        Applicant storage applicant = applicants[_applicant];
        require(applicant.isEligible && !applicant.isAssigned, "Applicant must be eligible and unassigned.");

        uint256 voucherAmount = applicant.voucherAmount;
        applicant.isAssigned = true;

        // Mint voucher NFT (ERC-721 standard)
        voucherNFT.mint(_applicant, voucherAmount);
    }

    function calculateVoucherAmount(Applicant memory applicant) internal pure returns (uint256) {
        // Implement custom logic to calculate voucher amount based on factors like family size, income, local rent median, and existing subsidy limits.
        // Consider incorporating economic factors by examining the local housing market, employment rates, and other relevant parameters.
        uint256 voucherAmount = 0;
        // ...
        return voucherAmount;
    }

    function isEligible(Applicant memory applicant) internal pure returns (bool) {
        // Implement improved eligibility determination logic based on factors like family size, income, local income limits, job stability score, and credit score.
        bool eligibilityStatus = false;
        // ...
        return eligibilityStatus;
    }

}
