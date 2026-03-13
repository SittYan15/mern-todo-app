FROM node:alpine

WORKDIR /app

COPY TODO/ .

RUN cd todo_backend && npm install
RUN cd todo_frontend && npm install && npm run build

RUN mkdir -p /app/todo_backend/static
RUN mv /app/todo_frontend/build /app/todo_backend/static/

WORKDIR /app/todo_backend

EXPOSE 5000

CMD ["npm", "start"]