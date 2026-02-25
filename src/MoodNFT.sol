// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

import {ERC721} from  "@openzeppelin/contracts/token/ERC721/ERC721.sol" ;
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol" ;
contract MoodNFT is ERC721 {

    uint256 private s_tokenCounter ;
    string private s_sadSvgImageUri;
    string private s_happySvgImageUri;
    mapping(uint256 => Mood) private s_tokenIdToMood ;
    enum Mood {HAPPY
        , SAD }
    constructor(string memory sadSvgImageUri , string memory happySvgImageUri) ERC721("MoodNFT" , "MN") {
        s_tokenCounter = 0 ;
        s_sadSvgImageUri = sadSvgImageUri ;
        s_happySvgImageUri = happySvgImageUri ;
    }

    function flipMood(uint256 tokenId) public {
        address owner = ownerOf(tokenId);

    _checkAuthorized(owner, msg.sender, tokenId);

    if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
        s_tokenIdToMood[tokenId] = Mood.SAD;
    }
    else {
        s_tokenIdToMood[tokenId] = Mood.HAPPY ;
    }


    }


    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter) ;
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY ;
        s_tokenCounter++ ;

    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory imageUri ;
        if (s_tokenIdToMood[s_tokenCounter] == Mood.HAPPY) {
            imageUri = s_happySvgImageUri ;
        } else {
            imageUri = s_sadSvgImageUri ;
        }

      return  string(abi.encodePacked( _baseURI() , Base64.encode( bytes (abi.encodePacked(
                            '{"name":"',
                            name(), // You can add whatever name here
                            '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
                            '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                            imageUri,
                            '"}'
                        ) ))));
}
}
