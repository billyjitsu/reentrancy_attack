// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

error NoBalance();

contract Stake {
    mapping(address => uint256) public deposits;

    function deposit() public payable {
        deposits[msg.sender] += msg.value;
    }

    function withdraw() public {
        if (deposits[msg.sender] == 0) revert NoBalance();
        uint256 bal = deposits[msg.sender];

        (bool sent,) = msg.sender.call{value: bal}("");
        require(sent, "Failed to send Ether");

        deposits[msg.sender] = 0;
    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
