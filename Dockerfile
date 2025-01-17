# ------- Etapa 1 ---------#
# Utiliza uma imagem base
FROM node:16 AS node

# Cria um diretório
WORKDIR /usr/src/app

# Copia os arquivos da pasta atual para dentro da pasta criada no passo anterior
COPY . .

# Instala o Dockerize que serve para permitir configurar dependência entre containers
ENV DOCKERIZE_VERSION v0.6.1

RUN apt-get update \
    && apt-get install -y wget \
    && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

EXPOSE 3000

# CMD ["node", "index.js"]