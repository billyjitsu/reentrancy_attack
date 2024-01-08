// // SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import {Script, console2} from "forge-std/Script.sol";
import {Stake} from "../src/Stake.sol";

contract StakeScript is Script {
    Stake public stake;

    function setUp() public {}

    function run() public {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(privateKey);
        new Stake();
        vm.stopBroadcast();
    }
}
