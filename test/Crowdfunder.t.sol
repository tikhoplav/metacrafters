// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Crowdfunder.sol";
import "../src/CrowdfunderStorage.sol";

contract CrowdfunderTest is Test {
    using stdStorage for StdStorage;

    Crowdfunder public _imp;
    CrowdfunderStorage public _c;

    receive() external payable {
        //
    }

    function setUp() public {
        _imp = new Crowdfunder(address(0), 0);
        _c = new CrowdfunderStorage(address(_imp), 10e18);
    }

    function testCanPladge() public {
        _c.pledge{ value: 1e18 }();

        assertEq(address(_c).balance, 1e18);
        assertEq(_c.balanceOf(address(this)), 1e18);
    }

    function testCannotPladgeIfGoalIsReached() public {
        stdstore
            .target(address(_c))
            .sig(_c.isComplete.selector)
            .checked_write(true);

        vm.expectRevert("The goal is reached!");
        _c.pledge{ value: 1e18 }();
    }

    function testCanRefund() public {
        uint _before = address(this).balance;

        _c.pledge{ value: 1e18 }();
        _c.refund(2e18);

        uint _after = address(this).balance;

        assertEq(_c.balanceOf(address(this)), 0);
        assert(_after - _before < 1e8);
    }

    function testCannotRefundIfGoalIsReached() public {
        stdstore
            .target(address(_c))
            .sig(_c.isComplete.selector)
            .checked_write(true);

        vm.expectRevert("The goal is reached, no refunds.");
        _c.refund(1e18);
    }

    event Pledged(address indexed from, uint indexed amount);

    function testPledgedEmitted() public {
        vm.expectEmit(true, true, false, false, address(_c));
        emit Pledged(address(this), 1e18);

        _c.pledge{ value: 1e18 }();
    }

    event Complete(uint indexed amount);

    function testCompleteEmitted() public {
        vm.expectEmit(true, false, false, false, address(_c));
        emit Complete(10.2e18);

        _c.pledge{value: 10.2e18}();
    }

    event Refunded(address indexed to, uint indexed amount);

    function testRefundedEmitted() public {
        _c.pledge{ value: 1e18 }();

        vm.expectEmit(true, true, false, false, address(_c));
        emit Refunded(address(this), 0.2e18);

        _c.refund(0.2e18);
    }
}