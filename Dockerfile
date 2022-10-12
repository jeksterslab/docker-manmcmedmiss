FROM jeksterslab/template:latest@sha256:2c793858d74565af3b5ce77ad3e05da64f22683128c401d4afe26429e3c4cd2b

# project packages
RUN R -e "install.packages(                                   \
      c(                                                      \
        'MASS',                                               \
        'mice',                                               \
        'ggplot2',                                            \
        'microbenchmark',                                     \
        'DT',                                                 \
        'lavaan',                                             \
        'party',                                              \
        'semmcci'                                             \
      ),                                                      \
      repos = 'https://packagemanager.rstudio.com/all/latest' \
    )"

RUN R -e "remotes::install_github('jeksterslab/semmcci')"

# install mplus demo
RUN wget https://www.statmodel.com/download/install_mpluslinux_demo64.bin \
    && sh install_mpluslinux_demo64.bin -i silent                         \
    && ln -s /opt/mplusdemo/mpdemo /usr/local/bin/                        \
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
