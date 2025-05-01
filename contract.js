import { ethers } from "https://cdnjs.cloudflare.com/ajax/libs/ethers/6.3.0/ethers.min.js";

const CONTRACT_ADDRESS = "0xf8e81D47203A594245E36C48e151709F0C19fBe8";
const ABI = [
    {
        "inputs": [{ "internalType": "uint256", "name": "candidate", "type": "uint256" }],
        "name": "bet",
        "outputs": [],
        "stateMutability": "payable",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "dispute",
        "outputs": [{ "internalType": "uint256", "name": "winner", "type": "uint256" }],
        "stateMutability": "view",
        "type": "function"
    }
];

async function connectWallet() {
    if (!window.ethereum) {
        alert("Instale o MetaMask!");
        return null;
    }
    try {
        const accounts = await window.ethereum.request({ method: "eth_requestAccounts" });
        return accounts[0]; 
    } catch (error) {
        alert("Erro ao conectar: " + error.message);
        return null;
    }
}


async function bet(teamId, amount) {
    const provider = new ethers.BrowserProvider(window.ethereum);
    const signer = await provider.getSigner();
    const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, signer);
    
    try {
        const tx = await contract.bet(teamId, { value: ethers.parseEther(amount) });
        await tx.wait();
        alert("Aposta realizada com sucesso!");
    } catch (error) {
        alert("Erro ao apostar!");
    }
}

export { connectWallet, bet };
