pragma solidity ^0.5.0;

contract Decentragram {
  string public name = "Decentragram";

  // store images
  mapping(uint => Image) public images;

  struct Image {
    uint256 id;
    string hash;
    string description;
    uint256 tipAmount;
    address payable author;
  }
  // create images
  function uploadImage() public {
    images[1] =
    Image(
      1,
      'aafadfa234235',
      'Hi guys check this shit out',
      0,
      address(0x0)
    );
  }
  // tip images

}
