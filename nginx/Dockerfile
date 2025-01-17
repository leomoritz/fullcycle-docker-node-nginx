# Usa versão alpine do nginx como base para essa imagem
FROM nginx:1.15.0-alpine

# Remove o arquivo padrão do nginx antes de copiar o arquivo personalizado para não haver conflitos
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf

# Liberar conteiner na porta 8081
EXPOSE 80

# Inicie o Nginx quando o contêiner for executado - foi especificado no docker-compose
# CMD ["nginx", "-g", "daemon off;"]


