manmcmedmiss.sif: Dockerfile apptainer.sh manMCMedMiss_0.9.1.tar.gz
	sudo docker build -t manmcmedmiss .
	sudo -E bash apptainer.sh
