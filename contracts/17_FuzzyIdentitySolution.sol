// SPDX-License-Identifier: No License
pragma solidity ^0.8.0;

interface IChallenge {
     function authenticate() external;
}

contract FuzzyIdentityChallengeSolver {
    function name() external pure returns (bytes32)
    {
        return bytes32("smarx");
    }

    function authenticate(address challenge) external {
        IChallenge(challenge).authenticate();
    }
}