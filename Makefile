.PHONY: term clean

manmcmedmiss.sif: Dockerfile apptainer.sh src/manMCMedMiss_0.9.1.tar.gz src/setup.sh
	@if (( "$EUID" != 0 )); then sudo docker build -t manmcmedmiss . ; else docker build -t manmcmedmiss . ; fi
	@if (( "$EUID" != 0 )); then sudo -E bash apptainer.sh; else bash apptainer.sh; fi

clean:
	@rm -rf *.sif
	@if (( "$EUID" != 0 )); then sudo docker system prune -a; else docker system prune -a; fi
	@if (( "$EUID" != 0 )); then sudo docker rmi $(docker images -a -q); else docker rmi $(docker images -a -q); fi
	@if (( "$EUID" != 0 )); then sudo docker stop $(docker ps -a -q); else docker stop $(docker ps -a -q); fi
	@if (( "$EUID" != 0 )); then sudo docker rm $(docker ps -a -q); else docker rm $(docker ps -a -q); fi

# make term
# - for local build
# - not for git clone

term:
	@echo Building .bashrc and .vimrc...
	@(cd .setup/bash && make)
	@(cd .setup/vim && make)
	@echo Setting git...
	@(cd .setup/git && make)
	@echo Setting ssh keys...
	@(cd .setup/ssh && make)

