// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;
//import "hardhat/console.sol";
import "../libs/PackedSet.sol";

contract MockContract {
    using PackedSet for PackedSet.Set;

    PackedSet.Set x;

    uint256[1000] keyexample;
    uint16[1000] valexample;

    mapping(uint256 => uint16) list;

    constructor() {
        // for(uint256 i = 0; i < 1000; i++) {
        //     keyexample[i]=(i);
        //     valexample[i]=uint16(i);
        // }
    }

    function add(uint16 value) public {
        x.add(value);
    }
    function remove(uint16 value) public {
        x.remove(value);
    }
    function get(uint256 key) public view returns(uint16) {
        return x.get(key);
    }

//  function getZeroSlot() public view returns(uint256) {
//         return x.getZeroSlot();
//     }
    function isContain(uint256 value) public view returns(bool) {
        return x.contains(value);
    }

   
    // function getBatch(uint256[] memory keys) public view returns (uint16[] memory values) {
    //     return x.getBatch(keys);
    // }

    // function setBatch(uint256[] memory keys, uint16[] memory values) public {
    //     x.setBatch(keys, values);
    // }
    
    /////////////////////
    // set mapping 1000
    // get mapping 1000
    // set packed 1000
    // get packed 1000
    // get batch packed 1000
    // set batch packed 1000
  
    // /////////////////////

    // function setMapping1000(uint256 key, uint16 value) public {
    //     list[key] = value;
    // }
    // function getMapping1000(uint256 key) public view returns(uint16 value){
    //     value = list[key];
    // }
    // function setPacked1000(uint256 key, uint16 value) public {
    //     x.set(key,value);
    // }
    // function getPacked1000(uint256 key) public view returns(uint16 value){
    //     value = x.get(key);
    // }
    // function setBatchPacked1000(uint256[] memory keys, uint16[] memory values) public {
    //     x.setBatch(keys,values);
    // }
    // function getBatchPacked1000(uint256[] memory keys) public view returns (uint16[] memory values) {
    //     values = x.getBatch(keys);
    // }

    // /////////////////////
    // function setMapping1000Shuffle(uint256 key, uint16 value) public {
    //     list[key] = value;
    // }
    // function getMapping1000Shuffle(uint256 key) public view returns(uint16 value){
    //     value = list[key];
    // }
    // function setPacked1000Shuffle(uint256 key, uint16 value) public {
    //     x.set(key,value);
    // }
    // function getPacked1000Shuffle(uint256 key) public view returns(uint16 value){
    //     value = x.get(key);
    // }
    // function setBatchPacked1000Shuffle(uint256[] memory keys, uint16[] memory values) public {
    //     x.setBatch(keys,values);
    // }
    // function getBatchPacked1000Shuffle(uint256[] memory keys) public view returns (uint16[] memory values) {
    //     values = x.getBatch(keys);
    // }

    /////////////////////
}