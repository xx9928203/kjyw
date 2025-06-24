cd /usr/local/src
wget https://www.openssl.org/source/openssl-1.1.1u.tar.gz
tar xf openssl-1.1.1u.tar.gz
cd openssl-1.1.1u
./config --prefix=/usr/local/openssl --openssldir=/usr/local/openssl shared zlib
make -j$(nproc)
sudo make install

echo "usr/local/openssl/lib/" | sudo tee /etc/ld.so.conf.d/openssl-1.1.1u.conf
sudo ldconfig
openssl version
