
# C2S-ScrapingService

Responsavel por executar o web scraping.

Se comunica com o serviço principal e com o serviço de notifcação via RabbitMQ.

## Rodando localmente

Alterar o arquivo de configuração rabbitmq.yml(Enviada juntamente com o teste) e database.yml

Execute as migrações

```bash
  rails db:create
  rails db:migrate
```

Execute a aplicação

```bash
  rake sneakers:run
```
