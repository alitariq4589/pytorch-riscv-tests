#!/bin/bash
# Setup script for RISC-V runner with Python and PyTorch dependencies

set -e

echo "=== Updating system packages ==="
apt-get update
apt-get install -y \
    python3 \
    python3-pip \
    python3-dev \
    build-essential \
    git \
    wget \
    curl \
    cmake \
    ninja-build \
    libopenblas-dev \
    liblapack-dev \
    libgomp1

echo "=== Creating Python symlinks ==="
ln -sf /usr/bin/python3 /usr/bin/python || true
ln -sf /usr/bin/pip3 /usr/bin/pip || true

echo "=== Upgrading pip ==="
python3 -m pip install --upgrade pip setuptools wheel

echo "=== Installing PyTorch dependencies ==="
python3 -m pip install numpy pyyaml setuptools cffi typing-extensions

echo "=== Verifying Python installation ==="
python3 --version
python3 -c "import sys; print(f'Python path: {sys.executable}')"

echo "=== Setup complete ==="
echo "You can now run PyTorch tests on this RISC-V runner"
