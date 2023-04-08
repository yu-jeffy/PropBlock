# PropBlock🏠🧱
a blockchain-based low-income housing assistance platform built on the Ethereum network 


it utilizes smart contracts to streamline Section 8 program processes, including eligibility verification, rent calculations, housing condition monitoring, and fund disbursement



1. ERC-721 Compliant Housing Voucher NFT (HousingVoucherNFT.sol) - Represents the housing vouchers with their associated values.


2. Eligibility Verification Contract (EligibilityVerification.sol) - Handles the registration and verification of applicant eligibility, as well as voucher assignment.


3. Rent Calculation Contract (RentCalculation.sol) - Manages housing unit details and calculates rent subsidies, including innovative incentivization mechanisms for promoting affordable and high-quality housing opportunities.


4. Housing Condition Monitoring Contract (HousingConditionMonitoring.sol) - Stores inspection data and calculates rent adjustments based on housing unit conditions.


# 📝 Housing Assistance Platform: Technical Documentation

This decentralized housing assistance platform aims to streamline and expand low-income housing support using a suite of Ethereum-based smart contracts. The system includes eligibility verification, rent calculation, and housing condition monitoring to foster responsible participation, encourage high-quality affordable housing, and empower beneficiaries. 🏡💡

## 📚 Table of Contents

1. [Eligibility Verification Contract](#eligibility-verification-contract)
2. [Housing Voucher NFT (ERC-721) Contract](#housing-voucher-nft-erc-721-contract)
3. [Rent Calculation Contract](#rent-calculation-contract)
4. [Housing Condition Monitoring Contract](#housing-condition-monitoring-contract)

---

### Eligibility Verification Contract

The Eligibility Verification Contract is responsible for registering applicants, verifying their eligibility, calculating voucher amounts, and assigning housing vouchers as NFTs. 💼🚀

#### Register Applicant 📋

```solidity
function registerApplicant(
    address _applicant,
    uint _familySize,
    uint _annualIncome,
    uint _jobStabilityScore,
    uint _creditScore
) public;
```

Registers an applicant on the platform with the family size, annual income, job stability score, and credit score. This function is only callable by the housing authority.

#### Verify Eligibility ✅

```solidity
function verifyEligibility(address _applicant) public;
```

Checks the eligibility of the applicant based on predefined criteria, such as income limits, family size, job stability scores, and credit scores. If eligible, it also calculates bonus voucher amounts for responsible participation.

#### Assign Voucher 🎫

```solidity
function assignVoucher(address _applicant) public;
```

If the applicant is eligible and unassigned, a voucher amount is assigned, and a housing voucher NFT is minted for the applicant.

#### Calculate Voucher Amount 💸

```solidity
function calculateVoucherAmount(Applicant memory applicant) internal pure returns (uint256);
```

Implements custom logic to calculate the voucher amount based on factors such as family size, income, local rent median, existing subsidy limits, and additional economic factors like employment rates and local housing markets.

#### Check Eligibility 🔍

```solidity
function isEligible(Applicant memory applicant) internal pure returns (bool);
```

Determines whether the applicant is eligible for the program based on predefined income limits, family size, job stability score, credit score, and other relevant criteria.

---

### Housing Voucher NFT (ERC-721) Contract

This contract represents housing vouchers as non-fungible tokens (NFTs), allowing secure tracking and seamless integration into the Ethereum ecosystem. This contract extends the ERC721.sol standard. 🎨🔗

#### Mint Voucher 🪙

```solidity
function mint(address recipient, uint256 voucherAmount) public returns (uint256);
```

Mints a new unique Housing Voucher NFT for the specified recipient with a specific voucher amount.

#### Get Voucher Amount 💲

```solidity
function getVoucherAmount(uint256 tokenId) public view returns (uint256);
```

Retrieves the voucher amount associated with a specific NFT token ID.

---

### Rent Calculation Contract

The Rent Calculation Contract helps housing authorities update housing unit information, calculate rent subsidy amounts, and apply adjustments based on market conditions and housing unit quality. 🏠💰

#### Update Housing Unit 🔄

```solidity
function updateHousingUnit(
    address _housingUnit,
    uint _rent,
    uint _squareFootage,
    uint _utilityCosts,
    uint _amenitiesScore
) public;
```

Updates the details of a housing unit, including rent, square footage, utility costs, and amenities score.

#### Calculate Rent Subsidy 🧮

```solidity
function calculateRentSubsidy(address _housingUnit, uint _familySize) public view returns (uint);
```

Calculates the rent subsidy amount based on the housing unit's base rent, utility costs, and amenity-based incentives for landlords.

#### Get Max Rent Subsidy 📈

```solidity
function getMaxRentSubsidy(uint _familySize) private pure returns (uint);
```

Determines the maximum rent subsidy amount based on family size, local rent median, and other relevant factors.

---

### Housing Condition Monitoring Contract

The Housing Condition Monitoring Contract allows housing authorities to store inspection data, calculate average inspection scores, and incentivize or penalize landlords based on the conditions of their housing units. 🛠️⚖️

#### Add Inspection Data 📊

```solidity
function addInspectionData(
    address _housingUnit,
    string memory _inspectionCategory,
    uint256 _score
) public;
```

Adds inspection data for housing units based on specific categories such as health and safety, maintenance, amenities, etc., and updates the average inspection score.

#### Calculate Rent Adjustment 🔧

```solidity
function calculateRentAdjustment(address _housingUnit) public view returns (int256);
```

Calculates rent adjustments for housing units based on their average inspection scores, rewarding well-maintained units with incentives and penalizing poorly-maintained units.

---
