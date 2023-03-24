const { ethers } = require("ethers");
const {
  Contract,
} = require("hardhat/internal/hardhat-network/stack-traces/model");
require("dotenv").config();

const tokenAddress = "0xfB7dC383447CA3d76309Aab086e69C487E5D33df";
const tokenAbi = require("../artifacts/contracts/Token.sol/Token.json").abi;
const provider = new ethers.providers.JsonRpcProvider(
  `https://eth-sepolia.g.alchemy.com/v2/${process.env.ALCHEMY}`
);
const signer = new ethers.Wallet(process.env.PK, provider);

const test = async () => {
  const res = await signer.getAddress();
  console.log(res);
};

const read = async () => {
  const contract = new ethers.Contract(tokenAddress, tokenAbi, signer);

  contract.on("Transfer", (from, to, amount) => {
    console.log(from, to, Number(amount));
  });
  await contract.mint("0x994fB7C0c2675da8CC6ed13f31781FA4393a6eCe");
  //   Transfer(address(0), account, amount);
};
read();
