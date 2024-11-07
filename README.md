# Ollama GitHub Action

[![Test Ollama Action](https://github.com/phil65/ollama-github-action/actions/workflows/test.yml/badge.svg)](https://github.com/phil65/ollama-github-action/actions/workflows/test.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A GitHub Action to easily install and run Ollama models in your workflow. Supports Linux, macOS, and Windows runners.

## Features

- 🚀 Cross-platform support (Linux, macOS, Windows)
- 🔄 Automatic installation and setup
- 🎯 Run specific model commands or serve models
- ⚡ Fast model pulling and execution


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
    model: "smollm2:135m"
    command: serve
    timeout: 600
```

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `model` | Ollama model to use (e.g., llama2, codellama, mistral) | Yes | `smollm2:135m` |
| `command` | Command to run (`run` or `serve`) | No | `run` |
| `prompt` | Prompt to send to the model | No | `Hello, how are you?` |
| `timeout` | Timeout in seconds for operations | No | `300` |

## Platform-Specific Notes

### Linux
- Runs natively using the official installer

### macOS
- Installs via Homebrew
- Supports both Intel and Apple Silicon

### Windows
- Uses the latest release from GitHub
- Custom installation path at C:\ollama

## Examples

### Using in a Workflow

```yaml
jobs:
  generate-code:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Run Ollama
        uses: phil65/ollama-github-action@v1
        with:
          model: "smollm2:135m"
          prompt: "Write a Python function to calculate fibonacci numbers"
```

### Running as a Server

```yaml
jobs:
  serve-model:
    runs-on: ubuntu-latest
    steps:
      - name: Start Ollama Server
        uses: phil65/ollama-github-action@v1
        with:
          model: "smollm2:135m"
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

### Debug Logs

Enable debug logging by setting:

```yaml
env:
  ACTIONS_STEP_DEBUG: true
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

- 🐛 [Issue Tracker](https://github.com/phil65/ollama-github-action/issues)
