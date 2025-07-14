# EDK II + OpenInterpreter Server

This project sets up a Dockerized environment for working with the EDK II firmware development kit and launches [OpenInterpreter](https://github.com/KillianLucas/open-interpreter) in server mode. The container includes support for AARCH64 cross-compilation, QEMU emulation, and common EDK II dependencies.

## Features

- Pre-configured EDK II environment with all required dependencies.
- OpenInterpreter running in server mode via FastAPI.
- Ready-to-use for UEFI development and firmware testing in QEMU.

## Usage

1. **Create an `.env` file** with your OpenAI API key:

    ```env
    OPENAI_API_KEY=sk-...
    ```

2. **Build the Docker image**:

    ```bash
    docker build -t edk2-interpreter .
    ```

3. **Run the container**:

    ```bash
    docker run -p 8000:8000 edk2-interpreter
    ```

4. **Access the server**:

    OpenInterpreter will be running at [http://localhost:8000](http://localhost:8000)

## Usage Example

You can send chat-style instructions to the interpreter server like this:

### With `curl`

```bash
curl -X POST http://localhost:8000/chat -H "Content-Type: application/json" -d '{
  "messages": [
    {"role": "user", "content": "Search the firmware source for the first DEBUG statement and insert a new line before it."}
  ]
}'
```

### With `Python`

```
import requests

response = requests.post(
    "http://localhost:8000/chat",
    json={
        "messages": [
            {"role": "user", "content": "Search the firmware source for the first DEBUG statement and insert a new line before it."}
        ]
    }
)

print(response.json())
```

## Included Tools

- EDK II + BaseTools
- edk2-platforms, edk2-non-osi, edk2-libc
- QEMU for AARCH64
- OpenInterpreter with FastAPI interface

## Notes

- The entrypoint script (`bootstrap.sh`) automatically:
  - Loads environment variables from `/root/.env`
  - Builds EDK II BaseTools
  - Configures environment variables
  - Starts the OpenInterpreter server

## License

MIT 