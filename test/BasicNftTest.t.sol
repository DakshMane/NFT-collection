// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNFT.sol";

contract BasicNftTest is Test {
    DeployBasicNft deployer ;
    BasicNft basicNft ;
    address public  user = makeAddr("USER") ;
    string  public constant PUG = "https://ipfs.io/ipfs/QmPAqePphJLrwy8rEJrJrW5ts5p73SgnnBM7Z4or4WNCJb" ;

    function setUp() public {
        deployer = new DeployBasicNft() ;
        basicNft = deployer.run() ;
    }
    function testNameisCorrect() public view  {
        assert(keccak256(abi.encodePacked("Doggie")) == keccak256(abi.encodePacked(basicNft.name())) );
    }

    function testCanMintNft() public {
        vm.prank(user);
        basicNft.mintNft(PUG);
        assert(basicNft.balanceOf(user) == 1);
        assert(
            keccak256(abi.encodePacked(PUG) ) == keccak256(abi.encodePacked((basicNft.tokenURI(0))))
        ) ;

    }


}
