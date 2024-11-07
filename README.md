# Ollama GitHub Action

[![Test Ollama Action](https://github.com/phil65/ollama-github-action/actions/workflows/test.yml/badge.svg)](https://github.com/phil65/ollama-github-action/actions/workflows/test.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A GitHub Action to easily install and run Ollama models in your workflow. Supports Linux, macOS, and Windows runners.

## Features

- 🚀 Cross-platform support (Linux, macOS, Windows)
- 🔄 Automatic installation and setup
- 🎯 Run specific models
- ⚡ Fast model pulling and execution


## Usage


### Example

```yaml
- name: Serve Ollama Model
  uses: phil65/ollama-github-action@v1
  with:
    model: "smollm2:135m"
    timeout: 600
```

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `model` | Ollama model to use (e.g., llama2, codellama, mistral) | Yes | `smollm2:135m` |
| `timeout` | Timeout in seconds until server gets killed | No | `300` |

## Platform-Specific Notes

### Linux
- Runs natively using the official installer

### macOS
- Installs via Homebrew
- Supports both Intel and Apple Silicon

### Windows
- Uses the latest release from GitHub
- Custom installation path at C:\ollama

## Example for a workflow

```yaml
jobs:
  serve-model:
    runs-on: ubuntu-latest
    steps:
      - name: Start Ollama Server
        uses: phil65/ollama-github-action@v1
        with:
          model: "smollm2:135m"
          timeout: 3600  # 1 hour timeout
```

## Troubleshooting

### Common Issues

1. **Model Download Timeout**
   - Increase the `timeout` parameter
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
