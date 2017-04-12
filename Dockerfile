FROM debian:8.7

# add labels
LABEL version="0.01" \
	maintainer="dndln"

# add anaconda to path
ENV PATH=/miniconda/bin:$PATH

ENV DEBIAN_FRONTEND noninteractive

# install packages
RUN apt-get update && apt-get install -y wget vim nano locales curl unzip wget openssl bzip2 \
	&& apt-get autoremove

# install miniconda
RUN wget http://repo.continuum.io/miniconda/Miniconda3-4.3.11-Linux-x86_64.sh -O miniconda.sh \
    && bash miniconda.sh -p /miniconda -b \
    && conda install scipy numpy scikit-learn nose readline pandas matplotlib seaborn \ 
       python-dateutil jupyter nltk pip psycopg2 cython hdf5 pytables ipywidgets \
    && conda clean -i -l -t -y \
    && rm miniconda.sh

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8

CMD jupyter notebook --allow-root --ip=0.0.0.0
