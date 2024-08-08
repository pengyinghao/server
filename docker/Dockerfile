# build stage
FROM node:20.16.0-alpine3.19 AS build-stage

WORKDIR /app

RUN npm config set registry https://registry.npmmirror.com/

COPY package.json package-lock.json ./

RUN npm install

COPY . .

RUN npm run build

# production stage
FROM node:20.16.0-alpine3.19 AS production-stage

WORKDIR /app

COPY --from=build-stage /app/dist /app
COPY --from=build-stage /app/package.json /app/package-lock.json ./

RUN npm config set registry https://registry.npmmirror.com/

ENV NODE_ENV=production
RUN npm install --production
RUN mkdir -p uploads

EXPOSE 5000
CMD ["node", "/app/main.js"]
