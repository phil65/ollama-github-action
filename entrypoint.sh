#!/bin/bash

# Exit on any error
set -e

# Enable debug mode if DEBUG is set
if [ "${DEBUG}" = "true" ]; then
    set -x
fi

# Default environment variables
MODEL=${MODEL:-"smollm2"}
COMMAND=${COMMAND:-"run"}
PORT=${PORT:-11434}
HOST=${HOST:-"127.0.0.1"}
PROMPT=${PROMPT:-"Hello, how are you?"}
TIMEOUT=${TIMEOUT:-300}

# Function to check if Ollama server is ready
wait_for_ollama() {
    echo "Waiting for Ollama server to start..."
    local max_attempts=30
    local attempt=1

    while [ $attempt -le $max_attempts ]; do
        if curl -s "http://${HOST}:${PORT}/api/tags" >/dev/null 2>&1; then
            echo "Ollama server is ready!"
            return 0
        fi
        echo "Attempt $attempt/$max_attempts: Server not ready yet..."
        sleep 1
        attempt=$((attempt + 1))
    done

    echo "Error: Ollama server failed to start within $max_attempts seconds"
    return 1
}

# Function to cleanup processes
cleanup() {
    echo "Cleaning up processes..."
    jobs -p | xargs -r kill || true
    exit 0
}

# Register cleanup function
trap cleanup EXIT INT TERM

# Install Ollama if not already installed
if ! command -v ollama >/dev/null 2>&1; then
    echo "Installing Ollama..."
    curl -fsSL https://ollama.ai/install.sh | sh

    if [ $? -ne 0 ]; then
        echo "Error: Failed to install Ollama"
        exit 1
    fi
fi

# Start Ollama service in background
echo "Starting Ollama service..."
ollama serve &

# Wait for server to be ready
wait_for_ollama

# Pull the specified model
echo "Pulling model: $MODEL"
timeout $TIMEOUT ollama pull "$MODEL"

if [ $? -ne 0 ]; then
    echo "Error: Failed to pull model $MODEL"
    exit 1
fi

# Execute based on command
if [ "$COMMAND" = "serve" ]; then
    echo "Running Ollama in server mode on ${HOST}:${PORT}"
    echo "Server will remain active for $TIMEOUT seconds"

    # Keep the server running for specified timeout
    sleep $TIMEOUT &
    wait $!
else
    echo "Running model with prompt: $PROMPT"

    # Run the model with timeout
    timeout $TIMEOUT ollama run "$MODEL" "$PROMPT"

    if [ $? -eq 124 ]; then
        echo "Error: Command timed out after $TIMEOUT seconds"
        exit 1
    elif [ $? -ne 0 ]; then
        echo "Error: Command failed"
        exit 1
    fi
fi

echo "Operation completed successfully"
