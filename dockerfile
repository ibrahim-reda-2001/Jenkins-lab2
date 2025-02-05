#docker run -v /var/run/docker.sock:/var/run/docker.sock
FROM node:12
COPY nodeapp /nodeapp
WORKDIR /nodeapp
RUN npm install
CMD ["node", "/nodeapp/app.js"]
