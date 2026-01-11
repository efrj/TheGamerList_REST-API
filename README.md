# The Gamer List API

API REST para gerenciamento de jogos, plataformas, gêneros e desenvolvedoras de videogames.

## Tecnologias

- Ruby 3.2.0
- Rails 7.0.4
- PostgreSQL 9.6
- Docker & Docker Compose
- JWT Authentication
- Swagger/OpenAPI Documentation

## Requisitos

- Docker
- Docker Compose

## Configuração e Instalação

### 1. Clone o repositório

```bash
git clone <repository-url>
cd api
```

### 2. Inicie os containers

```bash
docker-compose up -d
```

### 3. Crie o banco de dados

```bash
docker-compose exec web rails db:create
docker-compose exec web rails db:migrate
```

### 4. Popule o banco com dados de exemplo

```bash
docker-compose exec web rails db:seed
```

## Acesso

- **API Base URL:** http://localhost:8000
- **Documentação Swagger:** http://localhost:8000/api-docs

## Autenticação

A API utiliza autenticação JWT (JSON Web Token). Todos os endpoints de recursos requerem autenticação.

### Credenciais de Teste

- **Email:** admin@gamerlist.com
- **Password:** password123

### Endpoints de Autenticação

- `POST /api/v1/auth/register` - Registro de novo usuário
- `POST /api/v1/auth/login` - Login
- `GET /api/v1/users/me` - Dados do usuário autenticado
- `PUT /api/v1/users/me` - Atualizar dados do usuário

Para mais detalhes sobre autenticação, consulte [docs/AUTHENTICATION.md](docs/AUTHENTICATION.md)

## Endpoints Disponíveis

### Recursos

- **Games** - `/api/v1/games`
- **Genres** - `/api/v1/genres`
- **Platforms** - `/api/v1/platforms`
- **Generations** - `/api/v1/generations`
- **Softhouses** - `/api/v1/softhouses`
- **Contents** - `/api/v1/contents`
- **Banners** - `/api/v1/banners`
- **Platforms Informations** - `/api/v1/platforms_informations`

Todos os recursos suportam operações CRUD completas (GET, POST, PUT, DELETE).

## Estrutura do Banco de Dados

### Models Principais

- **User** - Usuários do sistema
- **Game** - Jogos
- **Genre** - Gêneros (Ação, RPG, Aventura, etc.)
- **Platform** - Plataformas (PlayStation, Xbox, Nintendo, etc.)
- **Generation** - Gerações de consoles (3ª, 4ª, 5ª geração, etc.)
- **Softhouse** - Desenvolvedoras/Publishers
- **Content** - Artigos e conteúdos
- **Banner** - Banners promocionais
- **PlatformsInformation** - Informações adicionais de plataformas

## Exemplo de Uso

### 1. Fazer Login

```bash
curl -X POST http://localhost:8000/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "admin@gamerlist.com",
    "password": "password123"
  }'
```

### 2. Listar Jogos (com autenticação)

```bash
curl -X GET http://localhost:8000/api/v1/games \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

## Comandos Úteis

### Acessar o container

```bash
docker-compose exec web bash
```

### Ver logs

```bash
docker-compose logs -f web
```

### Rodar testes

```bash
docker-compose exec web rspec
```

### Parar containers

```bash
docker-compose down
```

### Recriar banco de dados

```bash
docker-compose exec web rails db:drop db:create db:migrate db:seed
```

### Gerar documentação Swagger

```bash
docker-compose exec web rails rswag:specs:swaggerize
```

## Desenvolvimento

### Estrutura de Diretórios

```
app/
├── controllers/        # Controllers da API
│   └── api/v1/        # Versão 1 da API
├── models/            # Models ActiveRecord
├── serializers/       # Serializers para JSON
└── services/          # Serviços (ex: JsonWebToken)

config/
├── routes.rb          # Definição de rotas
└── initializers/      # Configurações iniciais

db/
├── migrate/           # Migrations
└── seeds.rb          # Dados iniciais

spec/
├── models/           # Testes de models
├── requests/         # Testes de API
└── factories/        # Factories para testes
```

## Documentação Adicional

- [Autenticação JWT](docs/AUTHENTICATION.md)

## Licença

Este projeto é privado e proprietário.

