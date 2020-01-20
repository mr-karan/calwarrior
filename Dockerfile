FROM nginx:latest
WORKDIR /app
COPY dist/ /app/dist
COPY deploy/calwarrior-nginx.conf /etc/nginx/conf.d/default.conf
CMD ["nginx", "-g", "daemon off;"]
