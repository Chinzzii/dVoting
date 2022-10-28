// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Election {
    //Candidate datatype
    struct Candidate {
        uint256 id;
        string name;
        uint256 votecount;
    }

    //Number of candidates
    uint256 public candidateCount;

    //Identify candidate uniquely
    mapping(uint256 => Candidate) public candidates;

    //List of voters who voted or not voted
    mapping(address => bool) public voted;

    //Used to update UI
    event electionUpdate(uint256 id, string name, uint256 votecount);

    //Initiate candidate when smart contract is deployed
    constructor() {
        addCandidate("Narendra Modi");
        addCandidate("Rahul Gandhi");
    }

    //Add candidate
    function addCandidate(string memory name) private {
        candidateCount++;
        candidates[candidateCount] = Candidate(candidateCount, name, 0);
    }

    //Used to register voters vote.
    function castVote(uint256 _id) public {
        //Check if voter has already voted or not
        require(!voted[msg.sender], "You have already voted!");

        require(candidates[_id].id != 0, "The ID doesnt exist!");

        //Increment candidates vote by 1 and mark voter as voted and update UI
        candidates[_id].votecount++;
        voted[msg.sender] = true;
        emit electionUpdate(
            _id,
            candidates[_id].name,
            candidates[_id].votecount
        );
    }
}
