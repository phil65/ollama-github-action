# Ollama GitHub Action

[![Test Ollama Action](https://github.com/phil65/ollama-github-action/actions/workflows/test.yml/badge.svg)](https://github.com/phil65/ollama-github-action/actions/workflows/test.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A GitHub Action to easily install and run Ollama models in your workflow. Supports Linux, macOS, and Windows runners.

## Features

- 🚀 Cross-platform support (Linux, macOS, Windows)
- 🔄 Automatic installation and setup
- 🎯 Run specific models
- ⚡ Fast model pulling and execution

## Compatibility Matrix

| Runner OS | Architecture | Status |
|-----------|--------------|---------|
| Ubuntu 20.04+ | x86_64 | ✅ Fully Supported |
| macOS 11+ | x86_64, ARM64 | ✅ Fully Supported |
| Windows Server 2019+ | x86_64 | ✅ Fully Supported |


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
| `timeout` | Timeout in seconds for operations | No | `300` |

## Outputs

| Output | Description |
|--------|-------------|
| `server-url` | URL of the running Ollama server (http://localhost:11434) |
| `status` | Status of the Ollama server (running/failed) |

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
        id: ollama  # Required to reference outputs
        uses: phil65/ollama-github-action@v1
        with:
          model: "smollm2:135m"
          timeout: 300

      # Example: Use the Ollama server in subsequent steps
      - name: Use Ollama
        run: |
          echo "Server URL: ${{ steps.ollama.outputs.server-url }}"
          echo "Server Status: ${{ steps.ollama.outputs.status }}"

          # Example API call
          curl "${{ steps.ollama.outputs.server-url }}/api/generate" \
            -d '{
              "model": "smollm2:135m",
              "prompt": "What is GitHub Actions?"
            }'
```

## Server Lifecycle

The Ollama server will:
1. Start automatically when the action runs
2. Remain running for subsequent workflow steps
3. Be automatically cleaned up when the job completes

Note: If you need to stop the server manually in your workflow, you can use:
```yaml
- name: Stop Ollama Server
  if: always()  # Ensures cleanup even if previous steps fail
  run: |
    pkill ollama || true
```

## Environment Variables

The following environment variables are available during the workflow:
- `OLLAMA_HOST`: localhost
- `OLLAMA_PORT`: 11434

## API Examples

### Generate Text
```yaml
- name: Generate Text
  run: |
    curl "${{ steps.ollama.outputs.server-url }}/api/generate" \
      -d '{
        "model": "smollm2:135m",
        "prompt": "Write a hello world program",
        "stream": false
      }'
```

### List Models
```yaml
- name: List Models
  run: |
    curl "${{ steps.ollama.outputs.server-url }}/api/tags"
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

## Security Considerations

- The server is accessible only on localhost
- Model files are stored in the runner's temporary space
- Cleanup is automatic after workflow completion
- No sensitive data is persisted between runs

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

- 🐛 [Issue Tracker](https://github.com/phil65/ollama-github-action/issues)
