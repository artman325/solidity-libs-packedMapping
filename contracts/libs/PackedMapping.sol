// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

/**
 * 
 */
library PackedMapping {

    struct Map {
        // mapKey - key in mapping
        // key - position in mapping value 
        // value value at position key in mapping value
        // for example
        // if store [0=>65535 1=>4369 2=>13107]
        // in packed mapping we will store 
        // in mapkey = 0 value "ffff111133330000000000000000000000000000000000000000000000000000"
        // where 0xffff, 0x1111, 0x3333 it's 65535,4369,13107 respectively,  with indexes 0,1,2
        mapping(uint256 => uint256) list;
        // map

    }

    // function zeroMasks() private pure returns(uint256[16] memory ret) {
    //     ret = [
    //         0x0000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff,
    //         0xffff0000ffffffffffffffffffffffffffffffffffffffffffffffffffffffff,
    //         0xffffffff0000ffffffffffffffffffffffffffffffffffffffffffffffffffff,
    //         0xffffffffffff0000ffffffffffffffffffffffffffffffffffffffffffffffff,
    //         0xffffffffffffffff0000ffffffffffffffffffffffffffffffffffffffffffff,
    //         0xffffffffffffffffffff0000ffffffffffffffffffffffffffffffffffffffff,
    //         0xffffffffffffffffffffffff0000ffffffffffffffffffffffffffffffffffff,
    //         0xffffffffffffffffffffffffffff0000ffffffffffffffffffffffffffffffff,
    //         0xffffffffffffffffffffffffffffffff0000ffffffffffffffffffffffffffff,
    //         0xffffffffffffffffffffffffffffffffffff0000ffffffffffffffffffffffff,
    //         0xffffffffffffffffffffffffffffffffffffffff0000ffffffffffffffffffff,
    //         0xffffffffffffffffffffffffffffffffffffffffffff0000ffffffffffffffff,
    //         0xffffffffffffffffffffffffffffffffffffffffffffffff0000ffffffffffff,
    //         0xffffffffffffffffffffffffffffffffffffffffffffffffffff0000ffffffff,
    //         0xffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000ffff,
    //         0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000
    //     ];
    // }

    function _get(Map storage map, uint256 key) private view returns (uint16 ret) {
        uint256 mapId = key >> 4;
        uint256 mapVal = map.list[mapId];
        uint16 mapValueIndex = uint16((key) - ((key>>4)<<4)) + 1;
        uint16 bitOffset = (256-((mapValueIndex)<<4));
        ret = uint16( (mapVal & (0xffff<<bitOffset))>>bitOffset);
    }

    function _set(Map storage map, uint256 key, uint16 value) private {
        uint256 mapId = key >> 4;
        uint256 mapVal = map.list[mapId];
        uint16 mapValueIndex = uint16((key) - ((key>>4)<<4)) + 1;
        uint16 bitOffset = (256-((mapValueIndex)<<4));
        uint256 zeroMask = (type(uint256).max)^(0xffff<<(bitOffset));
        uint256 valueMask = uint256(value)<<bitOffset;
        map.list[mapId] = (mapVal & zeroMask | valueMask);
    }

    function get(Map storage map, uint256 key) internal view returns (uint16 ret) {
        return _get(map, key);
    }

    function set(Map storage map, uint256 key, uint16 value) internal {
        _set(map, key, value);
    }

    function getBatch(Map storage map, uint256[] memory keys) internal view returns (uint16[] memory values) {
        for(uint256 i = 0; i< keys.length; i++) {
            values[i] = _get(map, keys[i]);
        }
        //return _get(map, key);
    }

    function setBatch(Map storage map, uint256[] memory keys, uint16[] memory values) internal {
        for(uint256 i = 0; i< keys.length; i++) {
            _set(map, keys[i], values[i]);
        }

    }

// irb(main):282:0> (w1).to_s(16)
// => "ffff111133330000"
// irb(main):283:0> (w2).to_s(16)
// => "ffff0000ffffffff"
// irb(main):284:0> (w3).to_s(16)
// => "0000bbbb00000000"
// irb(main):285:0> (w1&w2|w3).to_s(16)
// => "ffffbbbb33330000"

}
