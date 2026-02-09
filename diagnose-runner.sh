#!/bin/bash
# Diagnostic script for RISC-V runner setup

echo "======================================================================"
echo "RISC-V Runner Diagnostic Check"
echo "======================================================================"

echo ""
echo "1. Python Installation"
echo "---"
if command -v python3 &> /dev/null; then
    python3 --version
else
    echo "❌ Python3 NOT FOUND - Install with: sudo apt-get install -y python3"
    exit 1
fi

echo ""
echo "2. Git Installation"
echo "---"
if command -v git &> /dev/null; then
    git --version
else
    echo "❌ Git NOT FOUND - Install with: sudo apt-get install -y git"
    exit 1
fi

echo ""
echo "3. Docker Installation"
echo "---"
if command -v docker &> /dev/null; then
    docker --version
else
    echo "❌ Docker NOT FOUND - Install with: sudo apt-get install -y docker.io"
    exit 1
fi

echo ""
echo "4. Build Tools"
echo "---"
tools=("gcc" "g++" "make" "cmake" "ninja")
for tool in "${tools[@]}"; do
    if command -v "$tool" &> /dev/null; then
        echo "✓ $tool"
    else
        echo "⚠ $tool not found - may be needed for some builds"
    fi
done

echo ""
echo "5. Memory Check"
echo "---"
total_mem=$(free -h | awk '/^Mem:/ {print $2}')
echo "Total memory: $total_mem"

echo ""
echo "6. Disk Space Check"
echo "---"
available_space=$(df -h / | awk 'NR==2 {print $4}')
echo "Available disk space: $available_space"
echo "⚠ PyTorch build needs 20+ GB for artifacts"

echo ""
echo "7. Docker Status"
echo "---"
if systemctl is-active --quiet docker; then
    echo "✓ Docker daemon running"
else
    echo "❌ Docker daemon NOT running - Start with: sudo systemctl start docker"
fi

echo ""
echo "======================================================================"
echo "Setup Complete!"
echo ""
echo "Next steps:"
echo "1. Run: sudo apt-get install -y build-essential ninja-build"
echo "2. Run: python3 -m pip install --upgrade pip setuptools"
echo "3. Follow: https://github.com/pytorch/pytorch#from-source"
echo "======================================================================"
