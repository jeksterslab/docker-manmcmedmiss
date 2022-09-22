manmcmedmiss.sif: Dockerfile apptainer.sh
	docker build -t manmcmedmiss .
	sudo -E bash apptainer.sh
