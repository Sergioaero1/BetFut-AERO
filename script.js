import { connectWallet, bet } from "./contract.js";

document.getElementById("connectWalletBtn").addEventListener("click", async () => {
    const account = await connectWallet();
    if (account) {
        document.getElementById("walletInfo").innerText = `Carteira conectada: ${account}`;
    }
});

document.getElementById("betFlamengoBtn").addEventListener("click", () => {
    const amount = document.getElementById("betFlamengo").value;
    bet(2, amount);
});

document.getElementById("betSPFCBtn").addEventListener("click", () => {
    const amount = document.getElementById("betSPFC").value;
    bet(1, amount);
});
