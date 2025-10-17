// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.13;

import "forge-std/console2.sol";
import "forge-std/Script.sol";
import {UnizenRouterExecutor} from "../src/sample-executors/UnizenRouterExecutor.sol";
import {ISwapRouter02} from "../src/external/ISwapRouter02.sol";
import {IReactor} from "../src/interfaces/IReactor.sol";

contract DeployUnizenRouterExecutor is Script {
    function setUp() public {}

    function run() public returns (UnizenRouterExecutor executor) {
        uint256 privateKey = vm.envUint("FOUNDRY_PRIVATE_KEY");
        IReactor reactor = IReactor(vm.envAddress("FOUNDRY_UNIZENROUTEREXECUTOR_DEPLOY_REACTOR"));
        address whitelistedCaller = vm.envAddress("FOUNDRY_UNIZENROUTEREXECUTOR_DEPLOY_WHITELISTED_CALLER");
        address owner = vm.envAddress("FOUNDRY_UNIZENROUTEREXECUTOR_DEPLOY_OWNER");
        address unizenRouter = vm.envAddress("FOUNDRY_UNIZENROUTEREXECUTOR_DEPLOY_SWAPROUTER02");
        address wethAddress = vm.envAddress("0x82aF49447D8a07e3bd95BD0d56f35241523fBab1");


        vm.startBroadcast(privateKey);
        executor = new UnizenRouterExecutor{salt: 0x00}(whitelistedCaller, reactor, owner, unizenRouter, wethAddress);
        vm.stopBroadcast();

        console2.log("UnizenRouterExecutor", address(executor));
        console2.log("owner", executor.owner());
    }
}
