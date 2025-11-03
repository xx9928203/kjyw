yum install -y  gcc zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel

yum install -y  libffi-devel

cd /opt/
wget https://www.python.org/ftp/python/3.10.11/Python-3.10.11.tar.xz
tar -xvJf  Python-3.10.11tar.xz

mkdir -p /usr/local/python3
cd Python-3.10.11
export LD_LIBRARY_PATH=/usr/local/openssl/lib:$LD_LIBRARY_PATH
export CPPFLAGS="-I/usr/local/openssl/include"
export LDFLAGS="-L/usr/local/openssl/lib"
./configure \
  --with-ensurepip=install \
  --with-openssl=/usr/local/openssl \
  --enable-shared \
  --enable-loadable-sqlite-extensions \
  --with-system-ffi \
  --prefix=/usr/local/python3.10

make && make install

echo "/usr/local/python3.10/lib" | sudo tee /etc/ld.so.conf.d/python3.10.conf
sudo ldconfig

ln -s /usr/local/python3.10/bin/python3 /usr/local/bin/python3
ln -s /usr/local/python3.10/bin/pip3 /usr/local/bin/pip3

python3 -V
pip3 -V