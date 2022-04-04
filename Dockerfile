FROM node:14.15 as rdd-landing-build
WORKDIR /app

COPY package.json .
COPY package-lock.json .
RUN npm install

COPY . .

RUN npm run build-prod

FROM nginx:1.19 as rdd-landing-runtime
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=rdd-landing-build /app/dist/RDD/ /usr/share/nginx/html
