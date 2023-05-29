FROM jeksterslab/template:latest@sha256:8ebf7557dcdd190733acc13822eeae1fd70f5ab3b97308e821d53138b4222964

RUN R -e "install.packages(                                      \
      c(                                                         \
        'MASS',                                                  \
        'mice',                                                  \
        'ggplot2',                                               \
        'microbenchmark',                                        \
        'DT',                                                    \
        'lavaan',                                                \
        'party',                                                 \
        'semmcci'                                                \
      ),                                                         \
      repos = 'https://packagemanager.rstudio.com/all/latest'    \
    )"                                                        && \
    R -e "remotes::install_github('jeksterslab/semmcci')"     && \
    R -e "remotes::install_version(                              \
      package = 'MASS',                                          \
      version = '7.3-58.1',                                      \
      repos = 'https://packagemanager.rstudio.com/all/latest'    \
    )"                                                        && \
    R -e "remotes::install_version(                              \
      package = 'mice',                                          \
      version = '3.14.0',                                        \
      repos = 'https://packagemanager.rstudio.com/all/latest'    \
    )"                                                        && \
    R -e "remotes::install_version(                              \
      package = 'party',                                         \
      version = '1.3-10',                                        \
      repos = 'https://packagemanager.rstudio.com/all/latest'    \
    )"                                                        && \
    wget https://www.statmodel.com/download/install_mpluslinux_demo64.bin && \
      sh install_mpluslinux_demo64.bin -i silent                          && \
      ln -s /opt/mplusdemo/mpdemo /usr/local/bin/                         && \
      rm -rf install_mpluslinux_demo64.bin

# manMCMedMiss
ADD manMCMedMiss_0.9.1.tar.gz /usr/src/local
RUN R CMD INSTALL /usr/src/local/manMCMedMiss && \
    rm -rf /usr/src/local/manMCMedMiss

# author
MAINTAINER "Ivan Jacob Agaloos Pesigan <r.jeksterslab@gmail.com>"

# extra metadata
LABEL version="0.9.1"
LABEL description="manMCMedMiss_0.9.1 archlinux container."
