// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;


import "../lib/drosera-contracts/interfaces/ITrap.sol";

contract SergeantTrap is ITrap {
    // Struct to hold whale alert data
    struct WhaleAlert {
        address whale;
        uint256 transferSize;
        address token;
        uint256 timestamp;
    }

    uint256 public constant ETH_THRESHOLD = 2 * 10**18; // 2 ETH in wei
    uint256 public constant ERC20_THRESHOLD = 50000 * 10**6; // 50,000 tokens with 6 decimals

    string public constant VERSION = "1.0.1"; // Updated version

    function collect() external view override returns (bytes memory) {
        // Returns sample data for testing threshold logic
        WhaleAlert memory alert = WhaleAlert({
            whale: 0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045, // real whale
            transferSize: 3 * 10**18, // > 2 ETH threshold
            token: address(0), // ETH
            timestamp: block.timestamp
        });
        return abi.encode(alert);
       }

   
    function shouldRespond(
        bytes[] calldata data
    ) external pure override returns (bool shouldTrigger, bytes memory responseData) {
        if (data.length == 0 || data[0].length == 0) return (false, "");

        WhaleAlert memory alert = abi.decode(data[0], (WhaleAlert));
        bool isAboveThreshold = false; // Default value
        if (alert.whale == address(0)) return (false, "");

        if (alert.token == address(0)) {
            if (alert.transferSize >= ETH_THRESHOLD) {
                string memory alertMessage = string(abi.encodePacked(
                    "ETH_WHALE:",
                    _addressToString(alert.whale),
                    "_",
                    _uintToString(alert.transferSize / 10**18),
                    "ETH"
                ));
                responseData = abi.encode(alertMessage);
                return (true, responseData);
            }
        } else {
            if (alert.transferSize >= ERC20_THRESHOLD) {
                string memory alertMessage = string(abi.encodePacked(
                    "TOKEN_WHALE:",
                    _addressToString(alert.whale),
                    "_",
                    _uintToString(alert.transferSize / 10**6),
                    "USD"
                ));
                responseData = abi.encode(alertMessage);
                return (true, responseData);
            }
        }
        return (false, "");
    }

    function _addressToString(address _addr) internal pure returns (string memory) {
        bytes32 value = bytes32(uint256(uint160(_addr)));
        bytes memory alphabet = "0123456789abcdef";
        bytes memory str = new bytes(42);
        str[0] = '0';
        str[1] = 'x';
        for (uint i = 0; i < 20; i++) {
            str[2+i*2] = alphabet[uint8(value[i + 12] >> 4)];
            str[3+i*2] = alphabet[uint8(value[i + 12] & 0x0f)];
        }
        return string(str);
    }
    
    function _uintToString(uint256 _value) internal pure returns (string memory) {
        if (_value == 0) return "0";
        uint256 temp = _value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (_value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(_value % 10)));
            _value /= 10;
        }
        return string(buffer);
    }
    // End of SergeantTrap contract
}
