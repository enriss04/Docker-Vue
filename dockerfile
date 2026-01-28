FROM node:22-alpine

# Argumentos para sincronizar permisos con el host
ARG UID=1000
ARG GID=1000

# Instalamos dependencias básicas y aseguramos que el usuario 'node' tenga los IDs correctos
RUN apk add --no-cache shadow \
    && usermod -u $UID node \
    && groupmod -g $GID node

WORKDIR /app

# Instalamos la última versión de NPM
RUN npm install -g npm@latest

# Cambiamos al usuario node para que los archivos creados pertenezcan a tu usuario físico
USER node

# Exponemos el puerto del servidor de desarrollo de Vite
EXPOSE 5173

# Arrancamos en modo desarrollo con host 0.0.0.0 para que sea accesible fuera del contenedor
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]