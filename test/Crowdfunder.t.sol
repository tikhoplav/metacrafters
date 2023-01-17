// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Crowdfunder.sol";

contract CrowdfunderTest is Test {
    Crowdfunder public _c;

    function setUp() public {
        c = new Counter();
    }
}
