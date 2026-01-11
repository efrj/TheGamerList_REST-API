# Autenticação JWT

## Credenciais de Teste

- **Email:** admin@gamerlist.com
- **Senha:** password123

## Endpoints de Autenticação

### Registro
```bash
POST http://localhost:8000/api/v1/auth/register
Content-Type: application/json

{
  "name": "Seu Nome",
  "email": "seu@email.com",
  "password": "password123",
  "password_confirmation": "password123"
}
```

**Resposta:**
```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9...",
  "user": {
    "id": 1,
    "name": "Seu Nome",
    "email": "seu@email.com"
  }
}
```

### Login
```bash
POST http://localhost:8000/api/v1/auth/login
Content-Type: application/json

{
  "email": "admin@gamerlist.com",
  "password": "password123"
}
```

**Resposta:**
```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9...",
  "user": {
    "id": 1,
    "name": "Admin User",
    "email": "admin@gamerlist.com"
  }
}
```

### Obter dados do usuário autenticado
```bash
GET http://localhost:8000/api/v1/users/me
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9...
```

**Resposta:**
```json
{
  "id": 1,
  "name": "Admin User",
  "email": "admin@gamerlist.com",
  "created_at": "2026-01-10T00:00:00.000Z"
}
```

### Atualizar dados do usuário autenticado
```bash
PUT http://localhost:8000/api/v1/users/me
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9...
Content-Type: application/json

{
  "name": "Novo Nome",
  "email": "novo@email.com"
}
```

## Usando autenticação nos outros endpoints

Todos os endpoints de recursos (games, genres, platforms, etc.) agora requerem autenticação.

**Exemplo:**
```bash
GET http://localhost:8000/api/v1/games
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9...
```

## Testando com cURL

### 1. Fazer login
```bash
curl -X POST http://localhost:8000/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@gamerlist.com","password":"password123"}'
```

### 2. Usar o token retornado
```bash
# Salve o token em uma variável
TOKEN="seu_token_aqui"

# Use o token para acessar recursos protegidos
curl -X GET http://localhost:8000/api/v1/games \
  -H "Authorization: Bearer $TOKEN"
```

## Documentação Swagger

Acesse a documentação interativa em:
- http://localhost:8000/api-docs

Na interface Swagger, você pode:
1. Registrar um usuário ou fazer login
2. Copiar o token retornado
3. Clicar no botão "Authorize" no topo
4. Colar o token (sem o prefixo "Bearer")
5. Testar os endpoints protegidos
