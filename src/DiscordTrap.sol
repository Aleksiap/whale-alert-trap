// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "../lib/drosera-contracts/interfaces/ITrap.sol";

interface IMockResponse {
    function isActive() external view returns (bool);
}

contract DiscordTrap is ITrap {
    address public constant RESPONSE_CONTRACT = 0x25E2CeF36020A736CF8a4D2cAdD2EBE3940F4608;
    string constant discordName = "sanyrium";

    function collect() external view override returns (bytes memory) {
        bool active = IMockResponse(RESPONSE_CONTRACT).isActive();
        return abi.encode(active, discordName);
    }

    function shouldRespond(bytes[] calldata data) external pure override returns (bool, bytes memory) {
        if (data.length == 0) return (false, "");
        
        (bool active, string memory name) = abi.decode(data[0], (bool, string));
        
        if (!active || bytes(name).length == 0) {
            return (false, "");
        }

        return (true, abi.encode(name));
    }
}
