// SPDX-License-Identifier: No License
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Create2.sol";

import "./17_FuzzyIdentitySolution.sol";

contract FuzzyIdentityFactory {
    address public latestDeploy;

    function deploy(bytes32 salt) external
    {
        latestDeploy = Create2.deploy(0, salt, type(FuzzyIdentityChallengeSolver).creationCode);
    }

    function computeAddress(bytes32 salt) external view returns (address) {
        return Create2.computeAddress(salt, keccak256(type(FuzzyIdentityChallengeSolver).creationCode));
    }

    function getCreationCode() external pure returns(bytes memory) {
        return type(FuzzyIdentityChallengeSolver).creationCode;
    }
}
