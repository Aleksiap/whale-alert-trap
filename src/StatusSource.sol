// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract StatusSource {
    function isActive() external pure returns (bool) {
        return true; // Всегда активен для теста
    }
}
