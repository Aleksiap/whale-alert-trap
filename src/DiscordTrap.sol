// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

interface ITrap {
    function collect() external returns (bytes memory);
    function shouldRespond(bytes[] calldata data) external returns (bool, bytes memory);
}

contract DiscordTrap is ITrap {
    function collect() external pure returns (bytes memory) {
        return abi.encode("sanyrium");
    }
    
    function shouldRespond(bytes[] calldata) external pure returns (bool, bytes memory) {
        return (true, abi.encode("sanyrium"));
    }
}
