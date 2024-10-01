// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

struct Bet {
    uint amount;    // quantia da aposta
    uint candidate; // qual o candidato dessa aposta?
    uint timestamp; // qndo foi realizada? "timestamp" carimbo de data e hora
    uint clained;   // já retirado, sacado ,campeão 
}

struct Dispute {  // STRUCT estrutura de dados
    string candidate1;
    string candidate2;
    string image1;
    string image2;
    uint total1;
    uint total2;
    uint winner;
}

contract BetFutebol{

    Dispute public  dispute; //Tipos de dados, Contratos, sempre começam com letra maiúscola / Variáveis sempre começam com letra minúscula

    mapping(address => Bet) public allBets; // mapping, tipo de dado baseado e chave-valor (=>), uma chave que é um indice de pesquisa que leva até uma estrutura de dados com todas info que qieremos - como se fosse um dicionario.
            // A variável "allBets" vai guardar todas as apostas
    address owner;  // Dono do contrato
    uint fee = 1000; // Comissão da casa? 10%, com escala de 4 zeros
    uint public netPrize;
    constructor() {
        owner = msg.sender;   // quem disparou a msg de construção?  o Dono
        dispute = Dispute({   // Inicializar o contract
            candidate1: "SPFC",
            candidate2: "FLAMENGO",
            image1: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpt.m.wikipedia.org%2Fwiki%2FFicheiro%3AEscudo_do_SPFC_2006-Atualmente.png&psig=AOvVaw3GjVsmF8g3wrG9cARgHXbi&ust=1727830722532000&source=images&cd=vfe&opi=89978449&ved=0CBQQjhxqFwoTCPj97pf964gDFQAAAAAdAAAAABAE",
            image2: "https://www.google.com/url?sa=i&url=https%3A%2F%2Flogodownload.org%2Fflamengo-logo-flamengo-escudo%2F&psig=AOvVaw3QtQpZ_LVbQKlMsUC7oppC&ust=1727830772592000&source=images&cd=vfe&opi=89978449&ved=0CBQQjhxqFwoTCKjTsq7964gDFQAAAAAdAAAAABAE",
            total1: 0,
            total2: 0,
            winner: 0
        });
    }

    function bet(uint candidate) external payable  { // fumcionalidade APOSTAR: "external" para que o front end possa chama-la; "payable" espera o pagamento de algo junto; "uint candidate" é em quem eu quero apostar. 
    require(candidate == 1 || candidate == 2, "Invalid candidate"); // require é o meio de validaçôes mais usado. 1° condição de sucesso. em caso de erro coloca a 2° parametro a msg de erro.
    require(msg.value > 0, "Invalid bet"); // ".value" quanto de cripto foi enviado junto a essa chamada de função? se maior que 0 okk. se menor que 0, "invalid bet"
    require(dispute.winner == 0, "Dispute closed"); // não permitir apostas se a disputa for encerrada
    
    Bet memory newBet; // declaração de "Bet". qndo declaramos struct em codigos dentro de uma função, dizemos memory salvo temporario. 
    newBet.amount = msg.value; 
    newBet.candidate = candidate;
    newBet.timestamp = block.timestamp; // block tras atualização do bloco atual
    
    allBets[msg.sender] = newBet; 
    
    if(candidate == 1)
        dispute.total1 += msg.value;
    else
        dispute.total2 += msg.value;
    }

    function finish(uint winner) external { 
        require(msg.sender == owner, "Invalide acount"); // só o dono pode chamar essa função
        require(winner == 1 || winner == 2, "Invalide Candidate");  // só o 1 ou  o 2 pode ganhar
        require(dispute.winner == 0, "Disputed Closed");    // só pode jogar 1x

        dispute.winner = winner;     // só pode jogar 1x

        uint grossPrize = dispute.total1 + dispute.total2;   // "grossPrize" premio bruto
        uint comission = (grossPrize + fee) / 1e4;   // comissão recebida pela casa dividido por  na escala de 4 zeros
        netPrize = grossPrize - comission;    // premio liquido = premio bruto - comissão

        payable(owner).transfer(comission);   // transferencia automatica para conta do dono. a comissão dele. o criador da Bet.

    }
}