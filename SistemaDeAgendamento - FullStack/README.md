# SistemaDeAgendamento — Preparação para deploy (Oracle Cloud)

Este README traz comandos e instruções rápidas para gerar o artefato, criar a imagem Docker e preparar o deploy no Oracle (OCIR / Oracle Cloud Run / OKE).

Pré-requisitos

- Java 17 (para builds locais) ou usar o _Maven Wrapper_ incluso
- Docker (se for publicar como container)
- Credenciais Oracle (OCIR) se for push da imagem

Build local (usando o Maven Wrapper incluso)
Execute no PowerShell na raiz do projeto:

```
# No PowerShell
.\mvnw -U -DskipTests package
```

Se você não tiver `mvn` instalado, use o `mvnw` (Windows) ou `./mvnw` (Linux/macOS).

Construir a imagem Docker (usa o multi-stage Dockerfile já criado)

```
# tag substitua por seu repositório
docker build -t meu-registry/sistemaagendamento:latest .
```

Executar container localmente

```
docker run --rm -p 8080:8080 -e PORT=8080 -e SPRING_DATASOURCE_URL="jdbc:mysql://host:3306/agendamento" -e SPRING_DATASOURCE_USERNAME=root -e SPRING_DATASOURCE_PASSWORD=senha meu-registry/sistemaagendamento:latest
```

Dicas para Oracle Cloud

- Oracle aceita imagens em OCIR (Oracle Cloud Infrastructure Registry) ou deploy via container on Compute / OKE.
- Configure variáveis de ambiente no painel de Deployment/Job/Function:
  - PORT (ex: 8080)
  - SPRING_DATASOURCE_URL
  - SPRING_DATASOURCE_USERNAME
  - SPRING_DATASOURCE_PASSWORD

Actuator e health checks

- O projeto inclui `spring-boot-starter-actuator` e, por padrão, expõe endpoints: `/actuator/health`, `/actuator/info`, `/actuator/metrics`.
- Configure o health check no Oracle apontando para `/actuator/health`.

Notes

- Dockerfile usa usuário não-root e otimizações de build em multi-stage.
- As credenciais sensíveis não devem ficar no `application.properties` em produção; sempre utilize variáveis de ambiente/secret manager.

Se quiser, eu posso também:

- Gerar um `Procfile` para Cloud Run/Heroku-style deploys
- Gerar um `docker-compose.yml` para desenvolvimento local
- Ajudar a configurar push automatizado para OCIR (ex.: GitHub Actions)
