#! /usr/bin/bash

git clone git@github.com:jeksterslab/docker-manmcmedmiss.sif.git
rm -rf "$PWD.git"
mv docker-manmcmedmiss.sif/.git $PWD
rm -rf docker-manmcmedmiss.sif
