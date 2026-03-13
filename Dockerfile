FROM node:20

WORKDIR /app

COPY . .

WORKDIR /app/TODO/todo_backend
RUN npm install

WORKDIR /app/TODO/todo_frontend
RUN npm install
RUN npm run build

WORKDIR /app/TODO/todo_backend

RUN mkdir -p static
RUN cp -r /app/TODO/todo_frontend/build static/build

EXPOSE 5000

CMD ["npm", "start"]
