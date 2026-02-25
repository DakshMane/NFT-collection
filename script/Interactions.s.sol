// SPDX-License-Identifier: MIT

pragma solidity ^0.8.29;

import {Script , console} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNFT.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
contract MintBasicNft is Script {
    string  public constant PUG = "https://ipfs.io/ipfs/QmPAqePphJLrwy8rEJrJrW5ts5p73SgnnBM7Z4or4WNCJb" ;

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);
        console.log("Most recently deployed BasicNft contract address: %s", mostRecentlyDeployed);
        mintNftOnContract(mostRecentlyDeployed) ;


    }

    function mintNftOnContract(address _contractAddress) internal {
        vm.startBroadcast();
        BasicNft(_contractAddress).mintNft(PUG);
        vm.stopBroadcast();
    }
}
