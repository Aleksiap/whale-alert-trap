// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract ResponseContract {
    function respondWithDiscordName(string memory name) external pure returns (bytes memory) {
        // Должен возвращать bytes, а не string!
        return abi.encode(name);
    }
}