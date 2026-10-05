# JWT Products API

Simple Node.js API demonstrating JWT-based authentication for a protected `products` endpoint.

Quick start (PowerShell):

1. Install dependencies

```powershell
cd "c:/Users/danim/OneDrive - KreatiBox/Proyectos/Go_perl/Tutoriales desarrollos/Node vs Perl/jwt-products-api"
npm install
```

2. Set the secret and start (PowerShell)

```powershell
$env:JWT_SECRET = "mi_secreto_largo"
npm start
```

3. Example requests

- Login (get token):

```powershell
curl -Method POST -Uri http://localhost:3000/login -Headers @{ 'Content-Type' = 'application/json' } -Body '{"username":"admin","password":"password"}'
```

- Use token to call products:

```powershell
curl -Method GET -Uri http://localhost:3000/products -Headers @{ 'Authorization' = 'Bearer YOUR_TOKEN_HERE' }
```

Notes:
- This project uses hardcoded credentials for demo. Replace with real user handling for production.
- Copy `.env.example` to `.env` to set defaults.
