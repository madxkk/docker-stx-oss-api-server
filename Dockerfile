# to re-build this container use following command:
# cd this dir in terminal
# docker build --rm -f "Dockerfile" -t madxkk/stx-oss-api-server:year-month-date -t madxkk/stx-oss-api-server:latest .
# container tags can be your own, when you builded this container update container name in ../Dockerfile (you can just use latest tag if you want)
FROM debian:latest
LABEL maintainer="madxkk@xaked.com"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

# installing apt packages
RUN apt-get update --fix-missing && \
  apt-get install -y \
  wget bzip2 ca-certificates git curl grep sed dpkg \
  libglib2.0-0 libxext6 libsm6 libxrender1 \
  software-properties-common libsqlite3-dev autoconf \
  dirmngr apt-transport-https build-essential cron \
  libfontconfig1 libxrender1 libpq-dev python3-dev time nginx && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# installing conda - Python/R Data Science Platform
RUN time curl "https://repo.anaconda.com/archive/Anaconda3-5.3.1-Linux-x86_64.sh" -O && \
  mv Anaconda3-5.3.1-Linux-x86_64.sh ~/anaconda.sh && \
  /bin/bash ~/anaconda.sh -b -p /opt/conda && \
  rm ~/anaconda.sh && \
  ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
  echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc

# COPY spec-file.txt spec-file.txt
# RUN conda create --name my-rdkit-env --file spec-file.txt

# installing rdkit - Open source toolkit for cheminformatics
# installing python dependencies
RUN conda install -c rdkit -c conda-forge -f -y -n base \
  pip=10.0.1 \
  pandas=0.23.3 \
  psycopg2=2.7.5 \
  flask-cors=3.0.6 \
  rdkit=2017.03.2 \
  _libgcc_mutex=0.1 \
  blas=1.0 \
  ca-certificates=2019.5.15-0 \
  intel-openmp=2019.4 \
  libgfortran-ng=7.3.0 \
  libstdcxx-ng=8.2.0 \
  ncurses=6.0.0 \
  libgcc-ng=9.1.0 \
  mkl=2018.0.3 \
  bzip2=1.0.6 \
  icu=58.2 \
  jpeg=9b \
  libedit=3.1 \
  libffi=3.2.1 \
  libuuid=1.0.3 \
  libxcb=1.13 \
  openssl=1.0.2s \
  pcre=8.43 \
  pixman=0.38.0 \
  readline=7.0 \
  xz=5.2.4 \
  zlib=1.2.11 \
  glib=2.56.2 \
  libboost=1.67.0 \
  libpng=1.6.37 \
  libxml2=2.9.9 \
  sqlite=3.23.1 \
  tk=8.6.8 \
  zstd=1.3.7 \
  boost-cpp=1.67.0 \
  freetype=2.9.1 \
  krb5=1.16 \
  libtiff=4.0.10 \
  libxslt=1.1.33 \
  python=3.5.5 \
  backcall=0.1.0 \
  boost=1.56.0 \
  certifi=2018.8.24 \
  click=6.7 \
  decorator=4.4.0 \
  fontconfig=2.13.0 \
  ipython_genutils=0.2.0 \
  itsdangerous=0.24 \
  libpq=10.3 \
  markupsafe=1.0 \
  numpy=1.11.3 \
  numpy-base=1.11.3 \
  olefile=0.46 \
  parso=0.5.0 \
  pickleshare=0.7.4 \
  ptyprocess=0.6.0 \
  pytz=2019.1 \
  simplegeneric=0.8.1 \
  six=1.11.0 \
  wcwidth=0.1.7 \
  werkzeug=0.15.4 \
  cairo=1.14.12 \
  jedi=0.12.1 \
  mkl_fft=1.0.6 \
  pexpect=4.6.0 \
  pillow=5.2.0 \
  py-boost=1.67.0 \
  python-dateutil=2.7.3 \
  setuptools=40.2.0 \
  traitlets=4.3.2 \
  jinja2=2.10 \
  pygments=2.4.2 \
  rdkit-postgresql=2018.09.1.0 \
  wheel=0.31.1 \
  flask=1.1.1 \
  prompt_toolkit=1.0.15 \
  ipython=6.5.0 \
  uwsgi=2.0.15

RUN pip install --upgrade \
  pip==19.3.1 \
  flask-restful==0.3.7 \
  flask-jwt==0.3.2 \
  flask-jwt-extended==3.23.0 \
  flask-sqlalchemy==2.4.0 \
  passlib==1.7.1 \
  PyJWT==1.7.1 \
  simplejson==3.16.0 \
  Flask-Mail==0.9.1 \
  scipy==1.3.1 \
  xlrd==1.2.0 \
  requests==2.22.0 \
  python-dotenv==0.10.3 \
  pytest==5.3.1

WORKDIR /code
