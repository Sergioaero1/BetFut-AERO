import { Span } from "next/dist/trace";
import Head from "next/head";

export default function Home() {
  return (
    <>
    <Head>
      <meta charSet="utf-8"/>
      <meta name="viewport" content="width=device-width, initial-scale=1"/>
      <tittle>BetFutebol | Apostar</tittle>
    </Head>
    <div className="container px-4 py-5">
      <div className="row align-items-center">
      <h1 className="display-5 fw-bold text-body-emphasis lh-1 mb-3">BetFutebol</h1>
          <p className="lead">Aposta No Vencedor</p>
          <p className="lead">DATA DO SORTEIO: 22/12/2025</p>
      </div>

      <div className="row flex-lg-row-reverse align-items-center g-1 py-5">
        <div className="col"></div>
        <div className="col">
            <h3 className="my-2 d-block mx-auto" style={{width: 250}}>
                FLAMENGO
            </h3>
            <img src="/src/app/Aerinho3.png" className="d-block mx-auto img-fluid rounded" width={250}></img>
            <button className="btn btn-primary p-3 my-2 d-block mx-auto" style={{width: 250}}>Aposto nesse clube</button>
            <span className="badge text-bg-secundary d-block mx-auto" style={{width: 250}}>0 Pol Apostados</span>
        </div>

        <div className="col">
            <h3 className="my-2 d-block mx-auto" style={{width: 250}}>
                SPFC
            </h3>
            <img src="/src/app/Aerinho3.png" className="d-block mx-auto img-fluid rounded" width={250}></img>
            <button className="btn btn-primary p-3 my-2 d-block mx-auto" style={{width: 250}}>Aposto nesse clube</button>
            <span className="badge text-bg-secundary d-block mx-auto" style={{width: 250}}>0 Pol Apostados</span>
        </div>
      </div>

      <div className="row align-items-center">
        <p className="message"></p>
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
