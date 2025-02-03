# Use Node.js to build the Angular app

FROM node:20.10.0 AS builder
 
# Set the working directory

WORKDIR /app
 
# Copy package files and install dependencies

COPY package*.json ./

RUN npm install
 
# Copy the entire project

COPY . .
 
# Build the Angular app

RUN npm run build --prod
 
# Use Nginx for serving the production build

FROM nginx:stable-alpine
 
# Copy the built Angular app to Nginx's default static directory

COPY --from=builder /app/dist/angular-conduit/browser/* /usr/share/nginx/html/
 
# Expose port 80

EXPOSE 80
 
# Start Nginx server

CMD ["nginx", "-g", "daemon off;"]

 
