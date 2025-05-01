
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

struct Bet {
    uint amount;
    uint candidate;
    uint timestamp;
    uint claimed; // Corrigido o erro de digitação
}

struct Dispute {
    string candidate1;
    string candidate2;
    string image1;
    string image2;
    uint total1;
    uint total2;
    uint winner;
}

contract BetFutebol {
    Dispute public dispute;
    mapping(address => Bet) public allBets;
    address public owner;
    uint public fee = 1000;
    uint public netPrize;

    modifier onlyOwner() {
        require(msg.sender == owner, "Invalid account");
        _;
    }

    constructor() {
        owner = msg.sender;
        dispute = Dispute({
            candidate1: "SPFC",
            candidate2: "FLAMENGO",
            image1: "https://example.com/spfc.png",
            image2: "https://example.com/flamengo.png",
            total1: 0,
            total2: 0,
            winner: 0
        });
    }

    function bet(uint candidate) external payable {
        require(candidate == 1 || candidate == 2, "Invalid candidate");
        require(msg.value > 0, "Invalid bet");
        require(dispute.winner == 0, "Dispute closed");

        Bet memory newBet = Bet({
            amount: msg.value,
            candidate: candidate,
            timestamp: block.timestamp,
            claimed: 0
        });

        allBets[msg.sender] = newBet;

        if (candidate == 1) {
            dispute.total1 += msg.value;
        } else {
            dispute.total2 += msg.value;
        }
    }

    function finish(uint winner) external onlyOwner {
        require(winner == 1 || winner == 2, "Invalid candidate");
        require(dispute.winner == 0, "Dispute already closed");

        dispute.winner = winner;

        uint grossPrize = dispute.total1 + dispute.total2;
        uint commission = (grossPrize * fee) / 1e4;
        netPrize = grossPrize - commission;

        payable(owner).transfer(commission);
    }

    function claim() external {
        Bet memory userBet = allBets[msg.sender];
        require(dispute.winner > 0 && dispute.winner == userBet.candidate && userBet.claimed == 0, "Invalid claim");

        uint winnerAmount = (dispute.winner == 1) ? dispute.total1 : dispute.total2;
        uint ratio = (userBet.amount * 1e4) / winnerAmount;
        uint individualPrize = (netPrize * ratio) / 1e4;

        allBets[msg.sender].claimed = individualPrize;
        payable(msg.sender).transfer(individualPrize);
    }
}