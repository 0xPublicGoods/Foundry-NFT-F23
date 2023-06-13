// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

/** Imports */
import {Test, console} from "forge-std/Test.sol";

contract CallAnything is Test {
    address someAddress;
    uint256 amount;

    function transfer(address _someAddress, uint256 _amount) public {
        someAddress = _someAddress;
        amount = _amount;
    }

    function testSelectorOne() public pure returns (bytes4) {
        bytes4 selector = bytes4(keccak256(bytes("transfer(address,uint256)")));
        return selector;
    }

    function testGetDataToCallAndTransfer() public pure returns (bytes memory) {
        address _someAddress = 0x5504b3460C591Ce8b9845e9d4919Da8Df7D61f0f;
        uint256 _amount = 10;
        return abi.encodeWithSelector(testSelectorOne(), _someAddress, _amount);
    }

    function testCallTransferFunctionDirectly(
        address _someAddress,
        uint256 _amount
    ) public returns (bytes4, bool) {
        (bool success, bytes memory returnData) = address(this).call(
            abi.encodeWithSelector(testSelectorOne(), _someAddress, _amount)
        );

        assertEq(someAddress, _someAddress);
        // assertEq(someAddress, makeAddr("sf"));
        assertEq(amount, _amount);

        return (bytes4(returnData), success);
    }

    function testCallTransferFunctionDirectlyWithSignatureEncoding(
        address _someAddress,
        uint256 _amount
    ) public returns (bytes4, bool) {
        (bool success, bytes memory returnData) = address(this).call(
            abi.encodeWithSignature(
                "transfer(address,uint256)",
                _someAddress,
                _amount
            )
        );

        assertEq(someAddress, _someAddress);
        // assertEq(someAddress, makeAddr("sf"));
        assertEq(amount, _amount);

        return (bytes4(returnData), success);
    }
}
