# Use official Node.js image
FROM node:20-alpine

# Create app directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package.json vite.config.js ./
COPY index.html ./
COPY src ./src

# Install app dependencies
RUN npm install

# Expose port
EXPOSE 5173

# Start the app
CMD ["npm", "run", "dev", "--", "--host"]
