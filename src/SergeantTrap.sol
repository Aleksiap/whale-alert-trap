// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "../lib/drosera-contracts/interfaces/ITrap.sol";

contract SergeantTrap is ITrap {
    struct WhaleAlert {
        address whale;
        uint256 transferSize;
        address token;
        uint256 timestamp;
    }

    uint256 public constant ETH_THRESHOLD = 2 * 10**18;

    function collect() external view override returns (bytes memory) {
        WhaleAlert memory alert = WhaleAlert({
            whale: 0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045,
            transferSize: 3 * 10**18,
            token: address(0),
            timestamp: block.timestamp
        });
        return abi.encode(alert);
    }

    function shouldRespond(
        bytes[] calldata data
    ) external pure override returns (bool shouldTrigger, bytes memory responseData) {
        if (data.length == 0) return (false, "");

        WhaleAlert memory alert = abi.decode(data[0], (WhaleAlert));

        // Логика для ETH переводов (token = address(0))
        if (alert.token == address(0)) {
            if (alert.transferSize >= ETH_THRESHOLD) {
                string memory alertMessage = string(abi.encodePacked(
                    "ETH_WHALE_",
                    _addressToString(alert.whale),
                    "_",
                    _uintToString(alert.transferSize / 10**18),
                    "ETH"
                ));
                responseData = abi.encode(alertMessage);
                return (true, responseData);
            }
        }
        // Логика для ERC-20 переводов
        else if (alert.transferSize > 10000 * 10**6) {
            string memory alertMessage = string(abi.encodePacked(
                "WhaleAlert_",
                _addressToString(alert.whale),
                "_",
                _uintToString(alert.transferSize / 10**6),
                "USD"
            ));
            responseData = abi.encode(alertMessage);
            return (true, responseData);
        }

        return (false, "");
    }

    function triggerTestAlert() public pure returns (string memory) {
        return "ETH_WHALE_0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045_3ETH";
    }

    // Вспомогательные функции для преобразования
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
}
