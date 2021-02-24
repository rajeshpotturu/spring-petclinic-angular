FROM node:12.18.3-alpine3.12 as builder
WORKDIR /app
COPY package.json /app/
RUN apk add git
RUN npm install && rm -rf dist/
COPY ./ /app/
RUN npm run-script build
FROM nginx:alpine
COPY --from=builder /app/dist/frontend /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf