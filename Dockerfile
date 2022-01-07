# la phase s'appelle builder
FROM node:16-alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# phase de deploy
FROM nginx
EXPOSE 80
#On copie de le répertoire build de la premiere phase qui est le seul qui nous interesse en prod
COPY --from=builder /app/build /usr/share/nginx/html


