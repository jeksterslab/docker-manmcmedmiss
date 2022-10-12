.PHONY: clean

manmcmedmiss.sif: Dockerfile apptainer.sh manMCMedMiss_0.9.1.tar.gz
	sudo docker build -t manmcmedmiss .
	sudo -E bash apptainer.sh

clean:
	@rm -rf *.sif
	@docker system prune -a
	@docker rmi $(docker images -a -q)
	@docker stop $(docker ps -a -q)
	@docker rm $(docker ps -a -q)
