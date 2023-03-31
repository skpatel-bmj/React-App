# Use an official Node.js runtime as a parent image
FROM node:14-alpine

# Set the working directory to /app
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Build the React app for production
RUN npm run build

# Serve the app with a lightweight HTTP server
FROM node:14-alpine
RUN npm install -g serve
WORKDIR /app
COPY --from=0 /app/build .
CMD ["serve", "-p", "80", "-s", "."]
