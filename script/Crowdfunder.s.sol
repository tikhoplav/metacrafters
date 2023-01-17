// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Crowdfunder.sol";
import "../src/CrowdfunderStorage.sol";

contract Deploy is Script {
    /**
     * @dev Deploy contracts. This does not suppose to be used with a test
     * net or the mainnet. Local use only.
     */
    function setUp() public {
        // Deploy the implementation contract first,
        // after it will be used to deploy proxy.
        Crowdfunder _imp = new Crowdfunder(address(0), 0);

        // Deploy the proxy, this is what should be connected
        // this the FE app or any other apps running in local.
        // The default crowdfunding goal is set to 10 eth.
        CrowdfunderStorage _c = new CrowdfunderStorage(address(_imp), 10e18);

        console.log("Contract is deployed at address:", address(_c));
    }

    function run() public {
        vm.broadcast();
    }
}
