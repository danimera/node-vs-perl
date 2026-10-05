# Perl Mojolicious Products API with JWT

Simple API demonstrating JWT authentication with Mojolicious Lite (Perl).

## Quick Start (PowerShell)

1. **Install dependencies** (requires Strawberry Perl or similar)

```powershell
cd "c:/Users/danim/OneDrive - KreatiBox/Proyectos/Go_perl/Tutoriales desarrollos/Node vs Perl/perl-products-api"
cpanm --installdeps .
```

2. **Start the server**

```powershell
cd "c:/Users/danim/OneDrive - KreatiBox/Proyectos/Go_perl/Tutoriales desarrollos/Node vs Perl/perl-products-api"
$env:JWT_SECRET = "perl_secreto_largo"
perl app.pl daemon -l http://127.0.0.1:3001
```

3. **Example requests**

Login (get token):
```powershell
curl -Method POST -Uri http://localhost:3001/login `
  -Headers @{ 'Content-Type' = 'application/json' } `
  -Body '{"username":"admin","password":"password"}'
```

Use token to get products:
```powershell
$token = (curl -Method POST -Uri http://localhost:3001/login `
  -Headers @{ 'Content-Type' = 'application/json' } `
  -Body '{"username":"admin","password":"password"}').Content | ConvertFrom-Json | Select-Object -ExpandProperty token

curl -Method GET -Uri http://localhost:3001/products `
  -Headers @{ 'Authorization' = "Bearer $token" }
```

## Project Structure

- `app.pl` — Main Mojolicious Lite server with routes
- `lib/Auth.pm` — JWT token issuing and verification
- `cpanfile` — Perl dependencies
- `.env.example` — Environment variables template

## Notes

- Credentials are hardcoded (admin/password) for demo—replace in production
- Tokens expire in 1 hour
- Requires Perl 5.20+ and Mojolicious 9.0+
