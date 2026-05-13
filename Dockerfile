FROM node:20-alpine

RUN apk add --no-cache python3 make g++

WORKDIR /app

COPY package*.json ./

RUN npm install --legacy-peer-deps

COPY . .

RUN npm run build && npx medusa build

EXPOSE 9000

CMD ["sh", "-c", "cd /app && npx medusa db:migrate && cd /app/.medusa/server && npx medusa start"]
