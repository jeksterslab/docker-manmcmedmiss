manmcmedmiss.sif: Dockerfile apptainer/apptainer.sh
	docker build -t manmcmedmiss .
	sudo -E bash apptainer.sh
