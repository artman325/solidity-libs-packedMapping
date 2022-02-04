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
    var amountItems=100;
    for (let i = 0; i< amountItems; i++) {
        arr[i] = i;
    }

    arr1000linear = [...arr];
    arr1000shuffle = shuffle(arr);


    beforeEach("deploying", async() => {

        const PackedSet = await ethers.getContractFactory("PackedSet");
        const library = await PackedSet.deploy();
        await library.deployed();

        MockContractFactory = await ethers.getContractFactory("MockContract", {
            // libraries: {
            //     PackedSet:library.address
            // }
        });


        MockContractInstance = await MockContractFactory.deploy();
        
    });
it("set/get", async() => {
        // let key = 1;
        // let val = 3;
        // await MockContractInstance.set(key, val);
        

        // let expectVal = await MockContractInstance.__push_get(key);
        // await expect(val).to.be.eq(expectVal);

let arrVal = [11,12,13,14];
let arrVal2Remove = [12];
let N = arrVal.length + 1;
for(let j = 0; j<arrVal.length;j++) {
    console.log(await MockContractInstance.isContain(arrVal[j]));
    await MockContractInstance.add(arrVal[j]);
    console.log(await MockContractInstance.isContain(arrVal[j]));
    console.log((await MockContractInstance.getZeroSlot()).toHexString());for(let i = 0; i<N;i++) {console.log(i+'= ', await MockContractInstance.get(i));console.log("==================================================");}
}
for(let j = 0; j<arrVal2Remove.length;j++) {
    console.log(await MockContractInstance.isContain(arrVal2Remove[j]));
    await MockContractInstance.remove(arrVal2Remove[j]);
    console.log(await MockContractInstance.isContain(arrVal2Remove[j]));
    console.log((await MockContractInstance.getZeroSlot()).toHexString());for(let i = 0; i<N;i++) {console.log(i+'= ', await MockContractInstance.get(i));console.log("==================================================");}
}

// await expect(val).to.be.eq(expectVal);

        
    }); 
/*
    it("set/get", async() => {
        let key = 1;
        let val = 3;
        await MockContractInstance.set(key, val);

        let expectVal = await MockContractInstance.get(key);
        await expect(val).to.be.eq(expectVal);

        
    }); 

    it("set/get linear data", async() => {
        let expectVal;
        for (let i = 0; i< arr1000linear.length; i++) {
            await MockContractInstance.set(arr1000linear[i], arr1000linear[i]);
        }
        for (let i = 0; i< arr1000linear.length; i++) {
            expectVal = await MockContractInstance.get(arr1000linear[i]);
            await expect(arr1000linear[i]).to.be.eq(expectVal);
        }
    }); 
    it("set/get shuffle data", async() => {
        let expectVal;
        for (let i = 0; i< arr1000shuffle.length; i++) {
            await MockContractInstance.set(arr1000shuffle[i], arr1000shuffle[i]);
        }
        for (let i = 0; i< arr1000shuffle.length; i++) {
            expectVal = await MockContractInstance.get(arr1000shuffle[i]);
            await expect(arr1000shuffle[i]).to.be.eq(expectVal);
        }
    }); 
    it("set/get batch linear data", async() => {
        await MockContractInstance.setBatch(arr1000linear, arr1000linear);
        let expectVals = await MockContractInstance.getBatch(arr1000linear);

        for (let i = 0; i< expectVals.length; i++) {
            await expect(arr1000linear[i]).to.be.eq(expectVals[i]);
        }
    }); 
    it("set/get batch shuffle data", async() => {
        await MockContractInstance.setBatch(arr1000shuffle, arr1000shuffle);
        let expectVals = await MockContractInstance.getBatch(arr1000shuffle);
        for (let i = 0; i< expectVals.length; i++) {
            await expect(arr1000shuffle[i]).to.be.eq(expectVals[i]);
        }
    }); 
*/
// set mapping 1000
// get mapping 1000
// set packed 1000
// get packed 1000
// get batch packed 1000
// set batch packed 1000
/*
describe("with linear data items", function () {
    var arr;
    
    beforeEach("set vars", async() => {
        arr = arr1000linear;
        
    });
    it("set/get", async() => {
        let expectVal;
        for (let i = 0; i< arr.length; i++) {
            await MockContractInstance.set(arr[i], arr[i]);
        }
        for (let i = 0; i< arr.length; i++) {
            expectVal = await MockContractInstance.get(arr[i]);
            await expect(arr[i]).to.be.eq(expectVal);
        }
    }); 
    xit("set mapping 1000", async() => {
        for (let i = 0; i< arr.length; i++) {
            await MockContractInstance.setMapping1000(arr[i], arr[i]);
        }
    }); 
    // xit("get mapping 1000", async() => {
    //     for (let i = 0; i< arr.length; i++) {
    //         await MockContractInstance.getMapping1000(BigNumber.from(arr[i]));
    //     }
    // }); 
    xit("set packed 1000", async() => {
        for (let i = 0; i< arr.length; i++) {
            await MockContractInstance.setPacked1000(BigNumber.from(arr[i]), BigNumber.from(arr[i]));
        }
    }); 
    // xit("get packed 1000", async() => {
    //     for (let i = 0; i< arr.length; i++) {
    //         await MockContractInstance.getPacked1000(BigNumber.from(arr[i]));
    //     }
    // }); 
    xit("set batch packed 1000", async() => {
        await MockContractInstance.setBatchPacked1000(arr, arr);
    }); 
    // xit("get batch packed 1000", async() => {
    //     await MockContractInstance.getBatchPacked1000(arr);
    // }); 
    
});

describe("with shuffle data items", function () {
    var arr;
    var Mock222ContractInstance;

    beforeEach("set vars", async() => {
        arr = arr1000shuffle;
    });

    xit("set mapping 1000", async() => {
        for (let i = 0; i< arr.length; i++) {
            await MockContractInstance.setMapping1000Shuffle(arr[i], arr[i]);
        }
    }); 

    //     xit("get mapping 1000", async() => {
    //         for (let i = 0; i< arr.length; i++) {
    //             await MockContractInstance.getMapping1000Shuffle(BigNumber.from(arr[i]));
    //         }
    //     }); 

    xit("set packed 1000", async() => {
        for (let i = 0; i< arr.length; i++) {
            await MockContractInstance.setPacked1000Shuffle(BigNumber.from(arr[i]), BigNumber.from(arr[i]));
        }
    }); 

    //     xit("get packed 1000", async() => {
    //         for (let i = 0; i< arr.length; i++) {
    //             await MockContractInstance.getPacked1000Shuffle(BigNumber.from(arr[i]));
    //         }
    //     }); 

    xit("set batch packed 1000", async() => {
        await MockContractInstance.setBatchPacked1000Shuffle(arr, arr);
    }); 

    //     xit("get batch packed 1000", async() => {
    //         await MockContractInstance.getBatchPacked1000Shuffle(arr);
    //     }); 


});
  */  

});