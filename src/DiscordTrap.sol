// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "../lib/drosera-contracts/interfaces/ITrap.sol";

interface IStatusSource {
    function isActive() external view returns (bool);
}

contract DiscordTrap is ITrap {
    address public constant STATUS_SOURCE = 0x7aCf4DDA2BA8cbac1f644A271881975B45c28017;
    string private constant discordName = "sanyrium";

    function collect() external view override returns (bytes memory) {
        bool active = false;
        uint256 size;
        assembly {
            size := extcodesize(STATUS_SOURCE)
        }
        if (size > 0) {
            try IStatusSource(STATUS_SOURCE).isActive() returns (bool a) {
                active = a;
            } catch {
                active = false;
            }
        }
        return abi.encode(active, discordName);
    }

    function shouldRespond(bytes[] calldata data) 
        external 
        pure 
        override 
        returns (bool, bytes memory) 
    {
        if (data.length == 0 || data[0].length == 0) return (false, "");
        (bool active, string memory name) = abi.decode(data[0], (bool, string));
        if (!active || bytes(name).length == 0) return (false, "");
        return (true, abi.encode(name));
    }
}
