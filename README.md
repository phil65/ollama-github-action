# Ollama GitHub Action

[![Test Ollama Action](https://github.com/phil65/ollama-github-action/actions/workflows/test.yml/badge.svg)](https://github.com/phil65/ollama-github-action/actions/workflows/test.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A GitHub Action to easily install and run Ollama models in your workflow. Supports Linux, macOS, and Windows runners.

## Features

- 🚀 Cross-platform support (Linux, macOS, Windows)
- 🔄 Automatic installation and setup
- 🎯 Run specific model commands or serve models
- ⚡ Fast model pulling and execution
- 🔒 Secure default configurations

## Prerequisites

- GitHub Actions runner (Ubuntu 20.04+, macOS 11+, or Windows Server 2019+)
- Minimum 8GB RAM (16GB+ recommended for larger models)
- At least 10GB free disk space

## Usage

### Basic Example

```yaml
- name: Run Ollama Model
  uses: phil65/ollama-github-action@v1
  with:
    model: "smollm2:135m"
    prompt: "Write a hello world program in Python"
```

### Advanced Example

```yaml
- name: Serve Ollama Model
  uses: phil65/ollama-github-action@v1
  with:
    model: codellama
    command: serve
    timeout: 600
```

### Docker Compose Example

```yaml
- name: Run Ollama with Docker
  uses: phil65/ollama-github-action@v1
  with:
    model: "smollm2:135m"
    use_docker: true
    docker_compose_file: './custom-compose.yml'
```

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `model` | Ollama model to use (e.g., llama2, codellama, mistral) | Yes | `llama2` |
| `command` | Command to run (`run` or `serve`) | No | `run` |
| `prompt` | Prompt to send to the model | No | `Hello, how are you?` |
| `timeout` | Timeout in seconds for operations | No | `300` |

## Supported Models

- llama2
- codellama
- mistral
- vicuna
- orca-mini
- And [many more](https://ollama.ai/library)

## Platform-Specific Notes

### Linux
- Runs natively using the official installer
- Requires sudo privileges for installation

### macOS
- Supports both Intel and Apple Silicon
- Automatically detects and uses appropriate binary

### Windows
- Uses official Windows installer
- Custom installation path support
- May require additional setup time

## Examples

### Using with Python

```yaml
jobs:
  generate-code:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.x'

      - name: Run Ollama
        uses: phil65/ollama-github-action@v1
        with:
          model: codellama
          prompt: "Write a Python function to calculate fibonacci numbers"
```

### Long-Running Server

```yaml
jobs:
  serve-model:
    runs-on: ubuntu-latest
    steps:
      - name: Start Ollama Server
        uses: phil65/ollama-github-action@v1
        with:
          model: llama2
          command: serve
          timeout: 3600  # 1 hour timeout
```

## Troubleshooting

### Common Issues

1. **Model Download Timeout**
   - Increase the `timeout` parameter
   - Check network connectivity
   - Verify model name is correct

2. **Memory Issues**
   - Use a runner with more RAM
   - Try a smaller model
   - Close unnecessary processes

3. **Port Conflicts**
   - Default port is 11434
   - Check for other services using the same port
   - Use Docker setup for better isolation

### Debug Logs

Enable debug logging by setting:

```yaml
env:
  ACTIONS_STEP_DEBUG: true
```

## Contributing

Contributions are welcome! Please read our [Contributing Guidelines](CONTRIBUTING.md) first.

1. Fork the repo
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Ollama](https://ollama.ai/) for the amazing model serving framework
- The GitHub Actions team
- All contributors to this project

## Support

- 📖 [Documentation](docs/README.md)
- 🐛 [Issue Tracker](https://github.com/phil65/ollama-github-action/issues)
- 💬 [Discussions](https://github.com/phil65/ollama-github-action/discussions)
