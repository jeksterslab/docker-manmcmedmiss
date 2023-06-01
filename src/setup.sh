#!/bin/bash

set -e

R -e "install.packages(                                        \
    c(                                                         \
        'MASS',                                                \
        'mice',                                                \
        'ggplot2',                                             \
        'microbenchmark',                                      \
        'DT',                                                  \
        'lavaan',                                              \
        'party',                                               \
        'semmcci'                                              \
    ),                                                         \
    repos = 'https://packagemanager.rstudio.com/all/latest'    \
)"

R -e "remotes::install_github('jeksterslab/semmcci')"

R -e "remotes::install_version(                                \
    package = 'MASS',                                          \
    version = '7.3-58.1',                                      \
    repos = 'https://packagemanager.rstudio.com/all/latest'    \
)"

R -e "remotes::install_version(                                \
    package = 'mice',                                          \
    version = '3.14.0',                                        \
    repos = 'https://packagemanager.rstudio.com/all/latest'    \
)"

R -e "remotes::install_version(                                \
    package = 'party',                                         \
    version = '1.3-10',                                        \
    repos = 'https://packagemanager.rstudio.com/all/latest'    \
)"

R CMD INSTALL /usr/src/local/src/manMCMedMiss_0.9.1.tar.gz

wget https://www.statmodel.com/download/install_mpluslinux_demo64.bin
sh install_mpluslinux_demo64.bin -i silent
ln -s /opt/mplusdemo/mpdemo /usr/local/bin/
rm -rf install_mpluslinux_demo64.bin

# Clean up
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/*

# Installation information
echo -e "Session information...\n"
R -q -e "sessionInfo()"

# Check manMCMedMiss
echo -e "Check the manMCMedMiss package...\n"
R -q -e "library(manMCMedMiss)"
echo -e "\nInstall manMCMedMiss package, done!"
