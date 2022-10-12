#! /usr/bin/bash

git clone git@github.com:jeksterslab/docker-manmcmedmiss.git
rm -rf "$PWD.git"
mv docker-manmcmedmiss/.git $PWD
rm -rf docker-manmcmedmiss
