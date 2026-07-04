alias buuu='shutdown now'
alias seya='sudo systemd-run --on-active="60m" systemctl poweroff --force'

alias nixtest='sudo nixos-rebuild test'
alias nixupgr='sudo nixos-rebuild switch --upgrade'
nixone() {
	cd /etc/nixos/nixone
	git pull
	echo '> git add . && git commit -m "Update" && git push'
	echo '> nixtest (aka: sudo nixos-rebuild test)'
	echo '> nixupgr (aka: sudo nixos-rebuild switch --upgrade)'
}
# region Docker
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias ddrop='docker system prune -a --volumes'
dls() {
	echo "Images:"
	docker image ls
	echo -e "\n\nContainers:"
	docker container ls
	echo -e "\n\nVolumes: "
	docker volume ls
}
dtmprun() {
	docker build -t temp-image .
	if [ -z "$1" ]; then
		docker run --rm temp-image
	else
		docker run --rm -p $1:$1 temp-image
	fi
	echo "> docker rmi temp-image"
}
# endregion
# region Java
javarun() {
	if [ -z "$1" ]; then profile='dev'; else profile=$1; fi
	echo "run app.jar profiles=$profile"
	java -jar target/app.jar --spring.profiles.active=$profile
}
mvnrun() {
	if [ -z "$1" ]; then profile='dev'; else profile=$1; fi
	echo "clean run profiles=$profile"
	mvn clean spring-boot:run -Dspring-boot.run.profiles=$profile
}
# endregion
# region NordVPN
alias nn='nordvpn';
alias nns='nordvpn status';
alias nnc='nordvpn connect Switzerland';
# endregion
# region Utils
alias ping='ping -c 4';
alias http='http -v';
alias echoPATH="echo $PATH | tr ':' '\n'"
fitx() {
	if [ $# -eq 1 ]; then
		rg -i --regexp "$1" .
	elif [ $# -eq 2 ]; then
		rg -i --regexp "$1" $2
	elif [ $# -eq 3 ]; then
		rg --type $3 -i --regexp "$1" $2
	else
		echo "fitx REGEX_PATTERN [PATH] [FILE_TYPE]"
	fi
}
# endregion