// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import {Test, console2} from "forge-std/Test.sol";
import {Stake} from "../src/Stake.sol";
import {Attack} from "../src/Attack.sol";

contract StakeTest is Test {
    Stake public stake;
    Attack public attack;

    address alice = makeAddr("alice");
    address bob = makeAddr("bob");

    function setUp() public {
        stake = new Stake();
        attack = new Attack(address(stake));

        vm.deal(alice, 10000 ether);
        vm.deal(bob, 10000 ether);
    }

    // function test_Deposit() public {
    //     vm.startPrank(alice);
    //     stake.deposit{value: 1000 ether}();
    //     assertEq(stake.deposits(address(alice)), 1000 ether);
    //     vm.stopPrank();
    // }

    // function test_Withdraw() public {
    //     vm.startPrank(alice);
    //     stake.deposit{value: 1000 ether}();
    //     // console2.log("Balance of Contract", stake.getBalance());
    //     stake.withdraw();
    //     assertEq(stake.deposits(address(alice)), 0);
    //     // console2.log("Balance of Contract", stake.getBalance());
    //     vm.stopPrank();
    // }

    function test_Attack() public {
        vm.startPrank(alice);
        stake.deposit{value: 2 ether}();
        vm.stopPrank();
        console2.log("Balance of Contract", stake.getBalance());

        vm.startPrank(bob);
        attack.attack{value: 1 ether}();
        vm.stopPrank();
    }
}
