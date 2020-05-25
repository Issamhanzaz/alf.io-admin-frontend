FROM node:12.16.1-alpine As node

WORKDIR /usr/src/app

COPY package.json package-lock.json ./

RUN npm install

COPY . .

RUN npm run build --prod

FROM nginx:1.15.8-alpine

## Remove default nginx index page
RUN rm -rf /usr/share/nginx/html/*

COPY --from=node /usr/src/app/dist/ /usr/share/nginx/html

# FROM node:12.16.1-alpine as builder

# COPY package.json package-lock.json ./

# RUN npm install && mkdir /app-ui && mv ./node_modules ./app-ui

# WORKDIR /app-ui

# COPY . .

# RUN npm run ng build -- --deploy-url=/envapp/ --prod


# FROM nginx:alpine

# #!/bin/sh

# # COPY ./.nginx/nginx.conf /etc/nginx/nginx.conf

# ## Remove default nginx index page
# RUN rm -rf /usr/share/nginx/html/*

# COPY --from=builder /app-ui/dist /usr/share/nginx/html

# EXPOSE 4200 80

# ENTRYPOINT ["nginx", "-g", "daemon off;"]
