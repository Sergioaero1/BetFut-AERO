"use client"

import Head from "next/head";
import {useRouter} from "next/navigation";

export default function Home() {

  const{ push } = useRouter();

  function btnLoginClick() {
    push("/pag2");
  }

  return (
    <>
    <Head>
      <meta charSet="utf-8"/>
      <meta name="viewport" content="width=device-width, initial-scale=1"/>
      <tittle>BetFutebol | Login</tittle>
    </Head>
    <div className="container px-4 py-5">
      <div className="row flex-lg-row-reverse align-items-center g-5 py-5">
        <div className="col-6">

         <img src="./Aerinho3-700-500.png" alt="escudo do time" className="d-block mx-lg-auto img-fluid" width="700" height="500"/>
        </div>
  
        <div className="col-6">
          <h1 className="display-5 fw-bold text-body-emphasis lh-1 mb-3">BetFutebol</h1>
          <p className="lead">Aposta No Vencedor</p>
          <p className="lead">Autentique-se com sua carteira e deixe sua aposta para a proxima disputa</p>
          <div className="d-flex justify-content-start">
            <button type="button" className="btn btn-primary btn-lg px-4" onClick={btnLoginClick}>
              <img src="./60-60-.png" width={60} className="me-3"
              />
              Conectar Metamask
            </button>
            <p className="message"></p>
          </div>
        </div>
      </div>

      <footer className="d-flex flex-wrap justify-content-between align-items-center py-3 mx-4 border-top">
        <p className="col-4 mb-0 text-body-secondary">
          &copy; 2024 BetFutebol, Sergioaero
        </p>
        <ul className="nav col-4 justify-content-end">
          <li className="nav-item"><a href="/" className="nav-link px-2 text-body-secondary">Home</a></li>
          <li className="nav-item"><a href="/about" className="nav-link px-2 text-body-secondary">About</a></li>
        </ul>
      </footer>

    </div>
    </>  
  );
}
