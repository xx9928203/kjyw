yum install -y  gcc zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel

yum install -y  libffi-devel

cd /opt/
##wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tar.xz
wget https://www.python.org/ftp/python/3.9.4/Python-3.9.4.tar.xz
tar -xvJf  Python-3.9.4.tar.xz

mkdir -p /usr/local/python3
cd Python-3.9.4
export LD_LIBRARY_PATH=/usr/local/openssl/lib:$LD_LIBRARY_PATH
export CPPFLAGS="-I/usr/local/openssl/include"
export LDFLAGS="-L/usr/local/openssl/lib"
./configure \
  --enable-optimizations \
  --with-ensurepip=install \
  --with-openssl=/usr/local/openssl \
  --enable-shared \
  --enable-loadable-sqlite-extensions \
  --with-system-ffi \
  --with-computed-gotos \
  --prefix=/usr/local/python3.9
make && make install

ln -s /usr/local/python3/bin/python3 /usr/local/bin/python3
ln -s /usr/local/python3/bin/pip3 /usr/local/bin/pip3

python3 -V
pip3 -V
