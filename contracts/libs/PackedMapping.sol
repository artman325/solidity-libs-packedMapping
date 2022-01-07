// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";
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

    // useful method to sort native memory array 
    function sortAsc(uint256[] memory data, uint16[] memory data2) private returns(uint[] memory, uint16[] memory) {
       quickSortAsc(data, data2, int(0), int(data.length - 1));
       return (data, data2);
    }
    
    function quickSortAsc(uint[] memory arr, uint16[] memory arr2, int left, int right) private {
        int i = left;
        int j = right;
        if(i==j) return;
        uint pivot = arr[uint(left + (right - left) / 2)];
        while (i <= j) {
            while (arr[uint(i)] < pivot) i++;
            while (pivot < arr[uint(j)]) j--;
            if (i <= j) {
                (arr[uint(i)], arr[uint(j)]) = (arr[uint(j)], arr[uint(i)]);
                (arr2[uint(i)], arr2[uint(j)]) = (arr2[uint(j)], arr2[uint(i)]);
                i++;
                j--;
            }
        }
        if (left < j)
            quickSortAsc(arr, arr2, left, j);
        if (i < right)
            quickSortAsc(arr, arr2, i, right);
    }


    function get(Map storage map, uint256 key) internal view returns (uint16 ret) {
        return _get(map, key);
    }

    function set(Map storage map, uint256 key, uint16 value) internal {
        _set(map, key, value);
    }

    function setLoopBatch(Map storage map, uint256[] memory keys, uint16[] memory values) internal {
        for(uint256 i = 0; i< keys.length; i++) {
            _set(map, keys[i], values[i]);
        }
    }

    function getBatch(Map storage map, uint256[] memory keys) internal view returns (uint16[] memory values) {
        values = new uint16[](keys.length);
        for(uint256 i = 0; i< keys.length; i++) {
            values[i] = _get(map, keys[i]);
        }
        //return _get(map, key);
    }

    function setBatch(Map storage map, uint256[] memory keys, uint16[] memory values) internal {
        // sort asc by key
        (keys, values) = sortAsc(keys, values);
        
        uint256 imapId;
        uint256 mapId;
        uint256 mapVal;
        uint16 mapValueIndex;
        uint16 bitOffset;
        uint256 zeroMask;
        uint256 valueMask;
        
        
        //then loop
        for(uint256 i = 0; i< keys.length; i++) {
            
            imapId = keys[i] >> 4;

            if (imapId == mapId) {
                // same slot
                if (i==0) {
                    // first item in O slot
                    mapId == imapId;
                    mapVal = map.list[mapId];
                }
            } else {
                //else already next slot so need save previous

                if (i != 0) {
                    map.list[mapId] = mapVal;
                }
                mapId = imapId;

                mapVal = map.list[mapId];
            }
            
            mapValueIndex = uint16((keys[i]) - ((keys[i]>>4)<<4)) + 1;
            bitOffset = (256-((mapValueIndex)<<4));
            zeroMask = (type(uint256).max)^(0xffff<<(bitOffset));
            valueMask = uint256(values[i])<<bitOffset;
            mapVal = (mapVal & zeroMask | valueMask); // 1234 & FF0F | 00A0 => 12A4
            
            // save last iteration or first with single element
            if (i == (keys.length-1)) {
                map.list[mapId] = mapVal;

            }

        }
        
    }

}
