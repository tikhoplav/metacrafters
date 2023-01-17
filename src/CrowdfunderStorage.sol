// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin/access/Ownable.sol";
import "openzeppelin/token/ERC20/ERC20.sol";
import "./Crowdfunder.sol";

contract CrowdfunderStorage is ERC20, Ownable {
	address private _imp;

	uint public goal;
    bool public isComplete = false;

    constructor(address implementation, uint _goal) ERC20("CF", "^") {
    	_imp = implementation;
        goal = _goal;
    }

    function withdraw(uint _amount) external onlyOwner {
    	(bool success, bytes memory data) = _imp.delegatecall(
    		abi.encodeWithSignature("withdraw(uint256)", _amount)
    	);

        if(!success) {
        	assembly {
        		revert(add(data, 32), mload(data))
        	}
        }
    }

    function delegate(address implementation) external onlyOwner {
    	(bool success, bytes memory data) = _imp.delegatecall(
    		abi.encodeWithSignature("delegate(address)", implementation)
    	);

        if(!success) {
        	assembly {
        		revert(add(data, 32), mload(data))
        	}
        }
    }

    event Pledged(address indexed from, uint indexed amount);
    event Refunded(address indexed to, uint indexed amount);
    event Complete(uint indexed amount);

    /**
     * @dev Pledge funds to the Crowdfunding.
     */
    function pledge() external payable {
        (bool success, bytes memory data) = _imp.delegatecall(
    		abi.encodeWithSignature("pledge()")
    	);

        if(!success) {
        	assembly {
        		revert(add(data, 32), mload(data))
        	}
        }
    }

    /**
     * @dev Refund funds, available only if goal is not reached.
     */
    function refund(uint _amount) external {
        (bool success, bytes memory data) = _imp.delegatecall(
    		abi.encodeWithSignature("refund(uint256)", _amount)
    	);
        
        if(!success) {
        	assembly {
        		revert(add(data, 32), mload(data))
        	}
        }
    }
}