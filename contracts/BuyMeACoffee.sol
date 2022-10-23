//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// BuyMeACoffee deployed to: 0x0EA1ec1fbd3883cDd63562Ee6c2E37d3C29efdd2

contract BuyMeACoffee{
    //Event to emit when a memo is created
    event NewMemo(
        address indexed sender,
        uint256 timestamp,
        string name,
        string message
    );

    //Memo struct
    struct Memo{
        address sender;
        uint256 timestamp;
        string name;
        string message;
    }

    //List of Memos
    Memo[] memolist;

    //address payable: owner's address
    address payable owner;

    constructor(){
        //set owner by getting address of who deployed
        owner = payable(msg.sender);
    }

    function buyCoffee(string memory _name, string memory _message) public payable{
        require(msg.value > 0,"You cant buy with 0ETH!!");

        //add memo to memolist
        memolist.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));
        
        emit NewMemo(msg.sender, block.timestamp, _name, _message);

    }

    // send the balance stored in contract to owner
    function withdrawTips() public{
        //access the address of this contract and send balance to owner
        require(owner.send(address(this).balance));
    }

    //retrieve all the memos recieved and stored on blockchain 
    function getMemos() public view returns (Memo[] memory){
        return memolist;
    }

}