require("dotenv").config();
const Web3 = require("web3");
const contract = require("../build/contracts/Shopping.json");
const web3 = new Web3(`http://${process.env.HOST}:${process.env.GANACHEPORT}`);
const contractAddress = contract.networks[process.env.NETWORKID].address;
const abi = contract.abi;
const deployed = new web3.eth.Contract(abi, contractAddress, {
    gas: 1000000,
    from: process.env.ADDRESS
});


exports.deployed = deployed;