FROM node:18-bullseye

# Install SSH
RUN apt-get update && \
    apt-get install -y openssh-server && \
    mkdir /var/run/sshd

# Set root password (Azure SSH için gerekli)
RUN echo 'root:Docker!' | chpasswd

# Allow root login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# App directory
WORKDIR /app

# Copy package files
COPY package*.json ./
RUN npm install

# Copy app source
COPY . .

# Expose ports
EXPOSE 3000 2222

# SSH uses 2222 in App Service
RUN sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config

# Make start script executable
RUN chmod +x start.sh

# Start SSH + Web App
CMD ["./start.sh"]
