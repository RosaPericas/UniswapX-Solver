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
        uint256 privateKey = vm.envUint("FOUNDRY_PRIVATE_KEY"); // The private key used to sign transactions
        IReactor reactor = IReactor(vm.envAddress("FOUNDRY_UNIZENROUTEREXECUTOR_DEPLOY_REACTOR")); // 0xB274d5F4b833b61B340b654d600A864fB604a87c
        address whitelistedCaller = vm.envAddress("FOUNDRY_UNIZENROUTEREXECUTOR_DEPLOY_WHITELISTED_CALLER"); // The address of the whitelisted caller: 0x0aeB829F4Ae77938E3eF407412454Be22fd43a41
        address owner = vm.envAddress("FOUNDRY_UNIZENROUTEREXECUTOR_DEPLOY_OWNER"); // Blockchain team owner address: 0xe6b9BB7257B7C0801794f7F37B51390E3D515695
        address unizenRouter = vm.envAddress("FOUNDRY_UNIZENROUTEREXECUTOR_DEPLOY_UNIZENROUTER"); // Unizen Router address, arbitrum: 0xef58B643240178c2BC37681f8d4E50d7Ec37Ee22
        address wethAddress = vm.envAddress("WETH_ADDRESS"); // Arbitrum: 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1


        vm.startBroadcast(privateKey);
        executor = new UnizenRouterExecutor{salt: 0x00}(whitelistedCaller, reactor, owner, unizenRouter, wethAddress);
        vm.stopBroadcast();

        console2.log("UnizenRouterExecutor", address(executor));
        console2.log("owner", executor.owner());
    }
}
