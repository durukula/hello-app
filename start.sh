#!/bin/bash

echo "Starting SSH service..."
service ssh start

echo "Starting Node.js app..."
node index.js
