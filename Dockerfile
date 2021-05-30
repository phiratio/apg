FROM node:alpine as builder
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
RUN npm run test -- --coverage

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html