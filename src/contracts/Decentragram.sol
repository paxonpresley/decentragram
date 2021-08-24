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
  // syntax is same as an index
  event ImageCreated(
    uint256 id,
    string hash,
    string description,
    uint256 tipAmount, 
    address payable author
  );

  event TippedImage(
    uint id,
    string hash,
    string description, 
    uint tipAmount, 
    address payable author
  );
  
  // create images
  function uploadImage(string memory _imgHash, string memory _description) public {
    // image hash exists
    require(bytes(_imgHash).length > 0, 'YAY! There is an image hash');
    // must have a description
    require(bytes(_description).length > 0, 'YAY! There is a description.');
    // must be a valid user uploading
    require(msg.sender != address(0x0));
    // Incriment image id
    imageCount ++;
    // add image contract
    images [imageCount] = Image(  
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
  function tipImageOwner(uint _id) public payable {
    require(_id > 0 && _id <= imageCount);
    // grab image
    Image memory _image = images[_id];
    // get image author
    address payable _author = _image.author;
    // pay the auther with ether
    address(_author).transfer(msg.value);
    // increment the amount of ether
    _image.tipAmount = _image.tipAmount + msg.value;
    // update the image
    images[_id] = _image;
    // trigger event
    emit TippedImage(_id, _image.hash, _image.description, _image.tipAmount, _author);
  }
}