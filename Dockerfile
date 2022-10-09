# jeksterslab/template

FROM archlinux

# set time zone
RUN ln -s /usr/share/zoneinfo/UTC /etc/localtime

# set locale
RUN echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen
RUN locale-gen
RUN echo 'LANG=en_US.UTF-8' > /etc/locale.conf

# install packages
RUN --mount=type=cache,sharing=locked,target=/var/cache/pacman \
    pacman -Syu --noconfirm --needed                           \
            base                                               \
            base-devel                                         \
            wget                                               \
            xz                                                 \
            pandoc                                             \
            git                                                \
            parallel                                           \
            vim                                                \
            gcc-fortran                                        \
            openblas                                           \
            r

# install R packages
# development packages
RUN R -e "install.packages(                                   \
      c(                                                      \
        'covr',                                               \
        'devtools',                                           \
        'ggplot2',                                            \
        'knitr',                                              \
        'lintr',                                              \
        'magick',                                             \
        'microbenchmark',                                     \
        'pdftools',                                           \
        'pkgdown',                                            \
        'remotes',                                            \
        'rmarkdown',                                          \
        'rprojroot',                                          \
        'styler',                                             \
        'testthat',                                           \
        'tidyverse',                                          \
        'qpdf'                                                \
      ),                                                      \
      repos = 'https://packagemanager.rstudio.com/all/latest' \
    )"

RUN R -e "remotes::install_github( \
      c(                           \
        'rstudio/tinytex',         \
        'r-lib/cli',               \
        'r-lib/devtools',          \
        'r-hub/rhub'               \
      )                            \
    )"

RUN R -e "tinytex::install_tinytex( \
      bundle = 'TinyTeX-2',         \
      force = TRUE,                 \
      dir = '/opt'        \
    )"

ENV PATH="/opt/bin/x86_64-linux:${PATH}"

# remove the packages downloaded to image's pacman cache dir.
RUN pacman -Sy --noconfirm pacman-contrib
RUN paccache -r -k0

# docker-manmcmedmiss.sif

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
