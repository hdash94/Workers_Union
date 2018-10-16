# Workers_Union
##Prerequisites

---Truffle framework
---Ganache Blockchain
---Any Text Editor of choice
   **Sublime used for the project
   
##Steps to reproduce
---open ganache blockchain
---change parameters of truffle.js folder (if required) to test on another blockchain
---contract can be run upon private blockchain or ropsten test network for which the truffle.js needs the modification
--- js tests are pre built in the project
    you can find it in tests folder of the project
---Travel to the directory of the folder 
---Run truffle test to test the js tests for smart contract

##Description the Smart contract
---Workers union is a sample contract to get votes for a required proposal for a particular job
   the person can either vote by himself or can delegate the vote to some one else.
   This specific contract is to vote for minimum wage proposal for a particular job.
   The persons to vote is validated by the Authoriser which is done by the function giveRighttoVote.
   At last the winnig proposal is calculated and Declared
   
##This smart contract is subject to change to add extra functionalities

Contributions are requested to make it better
