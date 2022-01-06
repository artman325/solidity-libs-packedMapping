// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "../libs/PackedMapping.sol";

contract MockContract {
    using PackedMapping for PackedMapping.Map;

    PackedMapping.Map x;

    mapping(uint256 => uint16) list;

    function set(uint256 key, uint16 value) public {
        x.set(key,value);
    }
    function get(uint256 key) public view returns(uint16) {
        return x.get(key);
    }

    function getBatch(uint256[] memory keys) public view returns (uint16[] memory values) {
        return x.getBatch(keys);
    }

    function setBatch(uint256[] memory keys, uint16[] memory values) public {
        x.setBatch(keys, values);
    }
    
    function set1000Lib(uint256 key, uint16 value) public {
        x.set(key,value);
    }

    function set1000Map(uint256 key, uint16 value) public {
        list[key] = value;
    }
    
}