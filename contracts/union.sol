pragma solidity ^0.4.23;

contract union {

	mapping(address => mapping(bytes32 => bool)) public job_detail;

	struct union_member {
		uint weight;
		bytes32 profession; 
		bool voted;
		address delegate;
		uint vote; //index of the voted proposal
	}

	struct Proposal {
		uint256 minimum_wage;
		uint votecount;
	}

	mapping(address => union_member) public voters;

	Proposal[] public proposals;

	address public owner;

	constructor(uint256[] minimum_wage_proposals) public {
		
		owner = msg.sender;

		for(uint i = 0; i < minimum_wage_proposals.length; i++) {
			
			proposals.push(Proposal({

				minimum_wage: minimum_wage_proposals[i],
				votecount: 0

				}));
		}
	}

	modifier Authoriser() {
		require(msg.sender == owner);
		_;
	}

	function voteforProfession(bytes32 _profession) public {

		job_detail[msg.sender][_profession] = true;
	}

	function giveRighttoVote(address voter, bytes32 _profession) public {

		require(msg.sender == owner);

		require(!voters[voter].voted);

		require(voters[voter].weight == 0);

		require(job_detail[voter][_profession]);

		voters[voter].weight = 1;
	}

	function delegate(address to) public returns (bool success) {

		union_member storage sender = voters[msg.sender];

		require(!sender.voted);

		require(to != msg.sender);

		while (voters[to].delegate != address(0)) {

			to = voters[to].delegate;

			require(to != msg.sender);
		}

		sender.voted = true;

		sender.delegate = to;

		union_member storage _delegate = voters[to];

		if(_delegate.voted) {

			proposals[_delegate.vote].votecount += sender.weight; 
		}
		else {

			_delegate.weight += sender.weight;
		}

		return true;
	}

	function winningProposal() public view returns(uint _winningProposal) {

		uint winningVotecount = 0;

		for(uint p = 0; p < proposals.length; p++) {

			if(proposals[p].votecount > winningVotecount) {

				winningVotecount = proposals[p].votecount;

				_winningProposal = p;
			}
		}
	}

	function winnerdetail() public view returns(uint256 _winning_wage) {

		_winning_wage = proposals[winningProposal()].minimum_wage;
	}

}




























