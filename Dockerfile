# Utiliza uma imagem base
FROM node:16 AS node

# Cria um diretório
WORKDIR /usr/src/app

# Copiar apenas arquivos necessários para instalar as dependências
COPY package*.json ./

# Instala as dependências do projeto Node antes de copiar os fontes (depende de um volume anônimo no docker-compose.yaml para proteger node_modules de ser substituído)
RUN npm install

# Copia os demais arquivos da pasta atual para dentro da pasta criada no passo anterior
COPY . .

# Instala o Dockerize que serve para permitir configurar dependência entre containers
ENV DOCKERIZE_VERSION v0.6.1

RUN apt-get update \
    && apt-get install -y wget \
    && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# Libera aplicação node na porta 3000
EXPOSE 3000

# CMD ["node", "index.js"] # não é mais necessário esse comando pois é configurado no docker-compose.yaml