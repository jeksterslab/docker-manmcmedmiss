FROM jeksterslab/template

# project packages
RUN R -e "install.packages(                                   \
      c(                                                      \
        'MASS',                                               \
        'mice',                                               \
        'ggplot2',                                            \
        'microbenchmark',                                     \
        'DT',                                                 \
        'lavaan',                                             \
        'party'                                               \
      ),                                                      \
      repos = 'https://packagemanager.rstudio.com/all/latest' \
    )"

# install mplus demo
RUN wget https://www.statmodel.com/download/install_mpluslinux_demo64.bin \
    && sh install_mpluslinux_demo64.bin -i silent \
    && ln -s /opt/mplusdemo/mpdemo /usr/local/bin/ \
    && rm -rf install_mpluslinux_demo64.bin

# manMCMedMiss
ADD manMCMedMiss_0.9.1.tar.gz /usr/src/local
RUN R CMD INSTALL /usr/src/local/manMCMedMiss \
    && rm -rf /usr/src/local/manMCMedMiss

# author
MAINTAINER "Ivan Jacob Agaloos Pesigan <r.jeksterslab@gmail.com>"

# extra metadata
LABEL version="0.9.1"
LABEL description="manMCMedMiss_0.9.1 archlinux container."
