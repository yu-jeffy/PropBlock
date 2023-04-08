pragma solidity >= 0.6.0 < 0.9.0;

contract HousingConditionMonitoring {
    struct HousingUnit {
        mapping(string => uint256) inspectionData;
        uint256 averageInspectionScore;
    }

    mapping(address => HousingUnit) public housingUnits;
    address payable public housingAuthority;

    uint256 public constant PERFECT_SCORE = 100;

    // Incentivization factors and thresholds
    uint256 public constant BONUS_THRESHOLD = 90;
    uint256 public constant PENALTY_THRESHOLD = 60;
    uint256 public constant BONUS_PERCENT = 5;
    uint256 public constant PENALTY_PERCENT = 5;

    constructor() {
        housingAuthority = msg.sender;
    }

    function addInspectionData(
        address _housingUnit,
        string memory _inspectionCategory,
        uint256 _score
    ) public {
        require(
            msg.sender == housingAuthority,
            "Only housing authority can add inspection data."
        );
        HousingUnit storage unit = housingUnits[_housingUnit];
        unit.inspectionData[_inspectionCategory] = _score;

        // Update average inspection score
        uint256 totalScore = 0;
        uint256 numCategories = 0;
        for (string memory category in unit.inspectionData) {
            totalScore += unit.inspectionData[category];
            numCategories += 1;
        }
        unit.averageInspectionScore = totalScore / numCategories;
    }

    function calculateRentAdjustment(address _housingUnit)
        public
        view
        returns (int256)
    {
        HousingUnit storage unit = housingUnits[_housingUnit];
        int256 rentAdjustment = 0;

        if (unit.averageInspectionScore >= BONUS_THRESHOLD) {
            // Apply an incentive bonus for top-performing housing units
            rentAdjustment = int256(
                (unit.averageInspectionScore * BONUS_PERCENT) / 100
            );
        } else if (unit.averageInspectionScore < PENALTY_THRESHOLD) {
            // Apply a penalty for housing units that fall below the threshold
            rentAdjustment = -int256(
                (PERFECT_SCORE - unit.averageInspectionScore) * PENALTY_PERCENT /
                    100
            );
        }

        return rentAdjustment;
    }
}
