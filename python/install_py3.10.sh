#!/bin/bash

# 1. 安装编译依赖
yum install -y gcc zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel libffi-devel

# 2. 创建工作目录
#mkdir -p /opt/python-build
#cd /opt/python-build

# 3. 下载Python源码
#wget https://www.python.org/ftp/python/3.10.11/Python-3.10.11.tar.xz
tar -xvJf Python-3.10.11.tar.xz

# 4. 创建安装目录
mkdir -p /usr/local/python3.10

# 5. 编译配置（修正了原始脚本中的路径问题）
cd Python-3.10.11
export LD_LIBRARY_PATH=/usr/local/openssl/lib:$LD_LIBRARY_PATH
export CPPFLAGS="-I/usr/local/openssl/include"
export LDFLAGS="-L/usr/local/openssl/lib -L/usr/local/sqlite/lib"

./configure \
  --enable-optimizations \
  --with-ensurepip=install \
  --with-openssl=/usr/local/openssl \
  --enable-shared \
  --enable-loadable-sqlite-extensions \
  --with-system-ffi \
  --with-computed-gotos \
  --prefix=/usr/local/python3.10

# 6. 编译安装
make && make install

# 7. 配置动态库路径
echo "/usr/local/python3.10/lib" > /etc/ld.so.conf.d/python3.10.conf
ldconfig

# 8. 创建软链接
ln -sf /usr/local/python3.10/bin/python3 /usr/local/bin/python3
ln -sf /usr/local/python3.10/bin/pip3 /usr/local/bin/pip3

# 9. 验证安装
python3 -V
pip3 -V
