# Stage 1: Build the Node.js application
FROM node:18-slim AS build

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the application source code to the container
COPY . .

# Build the application for production (adjust build command as needed)
RUN npm run build

# Stage 2: Prepare the runtime environment for production
FROM node:18-slim

# Set the working directory for the runtime environment
WORKDIR /app

# Copy the built application from the build stage
COPY --from=build /app/dist ./dist # Adjust path if your build output is different

# Copy package.json to install production dependencies only
COPY package*.json ./

# Install production dependencies only
RUN npm install --production

# Expose the application port (adjust based on your app's requirements)
EXPOSE 8080

# Create a non-root user for running the app securely
RUN useradd -ms /bin/bash nodeuser

# Switch to the non-root user for security reasons
USER nodeuser

# Set the command to run the application (adjust based on your app's start script)
CMD ["node", "dist/index.js"] # Or whatever your main entry point is