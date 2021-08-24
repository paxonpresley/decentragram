pragma solidity ^0.5.0;

contract Decentragram {
  string public name = "Decentragram";

  // stoare images
  uint public imageCount = 0;
  mapping(uint => Image) public images;

  struct Image {
    uint256 id;
    string hash;
    string description;
    uint256 tipAmount;
    address payable author;
  }

  event ImageCreated(
    uint256 id;
    string hash;
    string description;
    uint256 tipAmount;
    address payable author;
  );
  
  // create images
  function uploadImage(string memory _imgHash, string memory _description, string memory) public {
    // Incriment image id
    imageCount = imageCount ++;
    // add image contract
    images [] = Image(  
      imageCount,
      _imgHash,
      _description,
      0,
      msg.sender
    );

    // envoke the event
    emit ImageCreated(
      imageCount, 
      _imgHash, 
      _description, 
      0, 
      msg.sender
      );
      
  }
  // tip images

}
