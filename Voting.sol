pragma solidity ^0.8.0;
// SPDX-License-Identifier: MIT
// need to add different positions - president and vice president 
contract Voting {
   
    //Candidate Model 
    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }

    //Accounts that have voted
    mapping (address => bool) public voters;

    //Candidate storage 
    //Fetch candidate using mapping - key/value pair
    mapping(uint => Candidate) public candidates; 

    // Store Candidates Count - index
    uint public candidatesCount;

    // Trigger an event to store the vote data on the blockchain
    event votedEvent(
        uint indexed _candidateId
    );

    //Constructor to initialized state variables
    constructor(){
        //Initialized candidate names
        addCandidate("President 1");
        addCandidate("President 2");
    }
    //Add Candidate function
    //must only be accessed by the me when i 
    function addCandidate(string memory _name) private{
        //Increment vote count
        candidatesCount++;
        //create a mapping
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    //learn require statement to accomplish
    function vote (uint _candidateId) public {
            //check if they have not voted before - check the address mapping
            require(!voters[msg.sender]);

            // check if vote is a valid candidate
            require(_candidateId > 0 && _candidateId <= candidatesCount);

            //record that the voter has voted
            voters[msg.sender] = true;

            //update candidate vote count
            candidates[_candidateId].voteCount++;

            //trigger voted event
            emit votedEvent(_candidateId);
    }




}
