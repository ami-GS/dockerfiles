FROM centos

ENV ICP_ROOT=/QAT/QAT1.6
ENV ICP_BUILD_OUTPUT=$ICP_ROOT/build
ENV OPENSSL_ROOT=/openssl
ENV OPENSSL_LIB=$OPENSSL_ROOT/.openssl
ENV LD_LIBRARY_PATH=$OPENSSL_ROOT/.openssl/lib
ENV OPENSSL_ENGINES=$OPENSSL_LIB/lib/engines-1.1
ENV NGINX_INSTALL_DIR=/usr/local/nginx
ENV HOME /

RUN yum install -y \
    epel-release \
    centos-release-scl \
    kernel-devel-`uname -r` \
    kernel-`uname -r` \
    pciutils \
    openssl-devel \
    zlib-devel \
    git \
    devtoolset-7 \
    make \
    gcc \
    wget
RUN git clone --branch OpenSSL_1_1_0f https://github.com/openssl/openssl.git \
    && wget https://01.org/sites/default/files/page/qatmux.l.2.6.0-60.tgz \
    && git clone --branch v0.5.30 https://github.com/01org/QAT_Engine.git \
    && git clone https://github.com/intel/asynch_mode_nginx
RUN mkdir /openssl/.openssl \
    && mkdir /nginx_install \
    && mkdir /QAT \
    && mv qatmux.l.2.6.0-60.tgz /QAT \
    && cd QAT && tar -xvzf qatmux.l.2.6.0-60.tgz \
    && echo 'Y' | ./installer.sh install
RUN cd openssl \
    && ./config --prefix=/openssl/.openssl \
    && make -j \
    && make install
RUN cd QAT_Engine/qat_contig_mem \
    && make -j \
    && cd /QAT_Engine \
    && ./configure --with-qat_dir=$ICP_ROOT --with-openssl_dir=$OPENSSL_ROOT --with-openssl_install_dir=$OPENSSL_LIB \
    && make -j \
    && make install \
    && echo $ICP_ROOT $OPENSSL_ROOT $OPENSSL_LIB
RUN cd asynch_mode_nginx \
    && ./configure \
    --prefix=$NGINX_INSTALL_DIR \
    --with-http_ssl_module \
    --with-cc-opt="-DNGX_SECURE_MEM -I$OPENSSL_LIB/include \
    -Wno-error=deprecated-declarations" \
    --with-ld-opt="-Wl,-rpath=$OPENSSL_LIB/lib -L$OPENSSL_LIB/lib" \
    && make -j && make install \
    && mkdir /usr/local/nginx/ssl \
    && $OPENSSL_LIB/bin/openssl req -new -newkey rsa:2048 \
    -days 365 -nodes -x509 -subj "/C=US/ST=FL/L=Ocala/O=Home/CN=example.com" \
    -keyout $NGINX_INSTALL_DIR/ssl/nginx.key -out $NGINX_INSTALL_DIR/ssl/nginx.cert

ADD openssl.cnf $OPENSSL_LIB/ssl/
ADD dh895xcc_qa_dev0.conf /etc/
ADD nginx.conf $NGINX_INSTALL_DIR/conf/
ADD insmod.sh $HOME

CMD [ "/sbin/init" ]

