// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Hyperlane_Counter} from "@benchmarking-cross-chain-bridges/Hyperlane/Counter.sol";

contract HyperlaneCounterTest is Test {
    Hyperlane_Counter public counter;

    function setUp() public {
        counter = new Hyperlane_Counter();
    }

    function testFuzz_handle(uint256 x) public {
        uint32 origin = 5;
        bytes32 sender;
        address senderAddr = address(this);

        assembly {
            sender := mload(0x00)
            mstore(sender, senderAddr)
        }
        bytes memory body = abi.encode(x);

        uint256 initialNumber = counter.number();

        counter.handle(origin, sender, body);

        assertEq(counter.number(), initialNumber + x);
    }
}
