//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../contracts/NikaTokenV2.sol";
import "./DeployHelpers.s.sol";

contract DeployScript is ScaffoldETHDeploy {
    error InvalidPrivateKey(string);

    function run() external {
        uint256 deployerPrivateKey = setupLocalhostEnv();
        if (deployerPrivateKey == 0) {
            revert InvalidPrivateKey(
                "You don't have a deployer account. Make sure you have set DEPLOYER_PRIVATE_KEY in .env or use `yarn generate` to generate a new random account"
            );
        }
        vm.startBroadcast(deployerPrivateKey);
        NikaTokenV2 nikaTokenV2 = new NikaTokenV2(
            uint(200000),
            uint(10000),
            uint(0.01 ether),
            vm.addr(deployerPrivateKey)
        );
        console.logString(
            string.concat(
                "YourContract deployed at: ",
                vm.toString(address(nikaTokenV2))
            )
        );
        vm.stopBroadcast();

        /**
         * This function generates the file containing the contracts Abi definitions.
         * These definitions are used to derive the types needed in the custom scaffold-eth hooks, for example.
         * This function should be called last.
         */
        exportDeployments();
    }

    function test() public {}
}
