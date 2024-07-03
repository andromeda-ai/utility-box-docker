### Dockerfile Repository: `utility-box-docker`

This repository contains a Dockerfile to build a utility box image based on the latest Ubuntu distribution. The image includes various tools for monitoring, data transfer, and cloud service command-line interfaces (CLIs).

#### Tools Included:

- **Filesystem/Memory/Disk Tools:**
  - `htop`: Interactive process viewer
  - `iotop`: Monitor I/O usage by processes
  - `sysstat`: System performance monitoring tools
  - `ncdu`: Disk usage analyzer with an interactive interface

- **Data Transfer Tools:**
  - `rsync`: Efficient file transfer and synchronization tool

- **Session Management Tools:**
  - `tmux`: Terminal multiplexer
  - `screen`: Full-screen window manager

- **Cloud Service CLIs:**
  - **Google Cloud SDK:**
    - Includes dependencies and the Google Cloud CLI

  - **Azure CLI:**
    - Installed using the official script from Microsoft

#### Usage:

To build the Docker image, use the following command in the directory containing the Dockerfile:

```bash
docker build -t utility-box:latest .
```

To run a container using this image and enter the bash shell:

```bash
docker run -it utility-box:latest
```

#### Note:

- The image is based on the latest Ubuntu distribution.
- The default command (`CMD`) is set to launch the bash shell.

Feel free to customize the Dockerfile according to your specific requirements.

#### Contributing:

Contributions are welcome! Feel free to open issues or submit pull requests.
