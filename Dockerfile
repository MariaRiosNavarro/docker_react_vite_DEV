FROM node
WORKDIR /react_dev_in_alpine
COPY . .
EXPOSE 5173
CMD ["npm","run", "dev", "--", "--host"]