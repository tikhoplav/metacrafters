// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin/utils/math/Math.sol";
import "openzeppelin/access/Ownable.sol";
import "openzeppelin/token/ERC20/ERC20.sol";

contract Crowdfunder is ERC20, Ownable {
    using Math for uint;

    address private _imp;

    uint public goal;
    bool public isComplete = false;

    constructor(address _i, uint _goal) ERC20("CF", "^") {
        //
    }

    function withdraw(uint _amount) external onlyOwner {
        payable(msg.sender).transfer(_amount);
    }

    function delegate(address implementation) external onlyOwner {
        _imp = implementation;
    }

    event Pledged(address indexed from, uint indexed amount);
    event Refunded(address indexed to, uint indexed amount);
    event Complete(uint indexed amount);

    /**
     * @dev Pledge funds to the Crowdfunding.
     */
    function pledge() external payable {
        require(!isComplete, "The goal is reached!");

        _mint(msg.sender, msg.value);

        if (address(this).balance + msg.value >= goal) {
            isComplete = true;
            emit Complete(address(this).balance);
        }

        emit Pledged(msg.sender, msg.value); // In addition to ERC20 Transfer
    }

    /**
     * @dev Refund funds, available only if goal is not reached.
     */
    function refund(uint _amount) external {
        require(!isComplete, "The goal is reached, no refunds.");

        uint _value = _amount.min(balanceOf(msg.sender));
        require(_value > 0);

        _burn(msg.sender, _value);
        payable(msg.sender).transfer(_value); 

        emit Refunded(msg.sender, _value); // In addition to ERC20 Transfer
    }
}
