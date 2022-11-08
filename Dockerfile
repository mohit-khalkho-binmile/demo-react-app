# STAGE 1

# pull the official base image
FROM node:16.17.1-slim as builder

# set working direction
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
# ENV PATH /app/node_modules/.bin:$PATH

# add app
COPY package*.json ./

RUN npm set strict-ssl false
RUN set NODE_TLS_REJECT_UNAUTHORIZED=0

# install dependencies
RUN npm i --only=production

# Copy source code
COPY . .

# build project
RUN npm run build



# STAGE 2

FROM nginx

WORKDIR /usr/share/nginx/html

RUN rm -rf ./*

COPY --from=builder /app/build .