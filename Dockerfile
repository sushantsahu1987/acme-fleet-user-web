# Step 1: Build the Next.js app
FROM node:latest AS builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Next.js app
RUN npm run build

# Step 2: Deploy the built app
FROM node:latest AS deploy

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install only production dependencies
RUN npm install --production

# Copy the built app from the previous stage
COPY --from=builder /app/.next ./.next

# Expose the port your app runs on
EXPOSE 3000

# Command to run the app
CMD ["npm", "start"]
