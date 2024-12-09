#!/bin/bash

# 更新系统包
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# 安装vim
echo "Installing vim"
sudo apt install -y vim

# 安装C++开发工具
echo "Installing C++ development tools..."
sudo apt install -y g++ cmake gdb libboost-all-dev libssl-dev libpthread-stubs0-dev

# 安装Go开发环境
echo "Installing Go..."
sudo apt install -y golang

# 设置Go环境变量
echo "Setting up Go environment..."
if ! grep -q GOPATH ~/.bashrc; then
    echo 'export GOPATH=$HOME/go' >> ~/.bashrc
    echo 'export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin' >> ~/.bashrc
    source ~/.bashrc
fi

# 安装Git版本控制
echo "Installing Git..."
sudo apt install -y git

# 安装网络调试工具
echo "Installing network tools..."
sudo apt install -y curl net-tools

# 安装Docker（可选）
echo "Installing Docker..."
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER


# 安装常用软件
echo "Installing normal sofeware"
sudo apt install -y wget curl python3 python3-pip python3-venv python3-dev
sudo apt-get install build-essential libcurl4-gnutls-dev libexpat1-dev gettext unzip autoconf libreadline-dev

# 安装Nginx（可选）
echo "Installing Nginx..."
sudo apt install -y nginx

# 安装VSCode（可选）
echo "Installing Visual Studio Code..."
#sudo snap install --classic code

# 安装数据库（可选）
echo "Installing MySQL and PostgreSQL..."
sudo apt install -y mysql-server #不安装 postgresql

# 安装常用工具
echo "Installing htop..."
sudo apt install -y htop

# 清理不再需要的包
echo "Cleaning up..."
sudo apt autoremove -y

echo "Development environment setup completed!"