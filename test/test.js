const { ethers, waffle } = require('hardhat');
const { BigNumber } = require('ethers');
const { expect } = require('chai');
const chai = require('chai');
const { time } = require('@openzeppelin/test-helpers');

const ZERO = BigNumber.from('0');
const ONE = BigNumber.from('1');
const TWO = BigNumber.from('2');
const THREE = BigNumber.from('3');
const FOUR = BigNumber.from('3');
const SEVEN = BigNumber.from('7');
const TEN = BigNumber.from('10');
const HUNDRED = BigNumber.from('100');
const THOUSAND = BigNumber.from('1000');


const ONE_ETH = ethers.utils.parseEther('1');

function shuffle(array) {
  var copy = [], n = array.length, i;

  // While there remain elements to shuffle…
  while (n) {

    // Pick a remaining element…
    i = Math.floor(Math.random() * array.length);

    // If not already shuffled, move it to the new array.
    if (i in array) {
      copy.push(array[i]);
      delete array[i];
      n--;
    }
  }

  return copy;
}

describe("Staking contract tests", function () {
    const accounts = waffle.provider.getWallets();
    const owner = accounts[0];                     
    
    
    var MockContractInstance;

    var MockContractFactory;
    
    
    let arr=[];
    var arr1000linear=[];
    var arr1000shuffle=[];
    var amountItems=1000;
    for (let i = 0; i< amountItems; i++) {
        arr[i] = i;
    }

    arr1000linear = [...arr];
    arr1000shuffle = shuffle(arr);


    beforeEach("deploying", async() => {
        MockContractFactory = await ethers.getContractFactory("MockContract");
        MockContractInstance = await MockContractFactory.deploy();
        
    });
// set mapping 1000
// get mapping 1000
// set packed 1000
// get packed 1000
// get batch packed 1000
// set batch packed 1000

describe("with linear data items", function () {
    var arr;
    
    beforeEach("set vars", async() => {
        arr = arr1000linear;
        
    });
    it("set mapping 1000", async() => {
        console.log("arr[0]=",arr[0]);
        for (let i = 0; i< arr.length; i++) {
            await MockContractInstance.setMapping1000(arr[i], arr[i]);
        }
    }); 
    // it("get mapping 1000", async() => {
    //     for (let i = 0; i< arr.length; i++) {
    //         await MockContractInstance.getMapping1000(BigNumber.from(arr[i]));
    //     }
    // }); 
    it("set packed 1000", async() => {
        for (let i = 0; i< arr.length; i++) {
            await MockContractInstance.setPacked1000(BigNumber.from(arr[i]), BigNumber.from(arr[i]));
        }
    }); 
    // it("get packed 1000", async() => {
    //     for (let i = 0; i< arr.length; i++) {
    //         await MockContractInstance.getPacked1000(BigNumber.from(arr[i]));
    //     }
    // }); 
    it("set batch packed 1000", async() => {
        await MockContractInstance.setBatchPacked1000(arr, arr);
    }); 
    // it("get batch packed 1000", async() => {
    //     await MockContractInstance.getBatchPacked1000(arr);
    // }); 
    it("set loop batch packed 1000", async() => {
        await MockContractInstance.setLoopBatchPacked1000(arr, arr);
    }); 
});
describe("with shuffle data items", function () {
    var arr;
    var Mock222ContractInstance;
    beforeEach("set vars", async() => {
        arr = arr1000shuffle;

    });
    it("set mapping 1000", async() => {
        console.log("arr[0]=",arr[0]);
        for (let i = 0; i< arr.length; i++) {
            await MockContractInstance.setMapping1000Shuffle(arr[i], arr[i]);
        }
    }); 
//     it("get mapping 1000", async() => {
//         for (let i = 0; i< arr.length; i++) {
//             await MockContractInstance.getMapping1000Shuffle(BigNumber.from(arr[i]));
//         }
//     }); 
    it("set packed 1000", async() => {
        for (let i = 0; i< arr.length; i++) {
            await MockContractInstance.setPacked1000Shuffle(BigNumber.from(arr[i]), BigNumber.from(arr[i]));
        }
    }); 
//     it("get packed 1000", async() => {
//         for (let i = 0; i< arr.length; i++) {
//             await MockContractInstance.getPacked1000Shuffle(BigNumber.from(arr[i]));
//         }
//     }); 
    it("set batch packed 1000", async() => {
        await MockContractInstance.setBatchPacked1000Shuffle(arr, arr);
    }); 
//     it("get batch packed 1000", async() => {
//         await MockContractInstance.getBatchPacked1000Shuffle(arr);
//     }); 
    it("set loop batch packed 1000", async() => {
        await MockContractInstance.setLoopBatchPacked1000Shuffle(arr, arr);
    }); 
});
    

});