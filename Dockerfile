# ------- Etapa 1 ---------#
# Utiliza uma imagem base
FROM node:15 AS node

# Cria um diretório
WORKDIR /usr/src/app

# Copia os arquivos da pasta atual para dentro da pasta criada no passo anterior
COPY . .

EXPOSE 3000

# CMD ["node", "index.js"]