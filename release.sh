#!/bin/bash

build_project () {
	echo "Building project $1"
	cd $1
    xcodebuild -project $1.xcodeproj -scheme $1Release -quiet clean build > /dev/null 2> ./build_errors.log
    if (( $? )); then
      echo "Failure building ${PROJECT_NAME}.xcodeproj" >&2
      return 1
    else
      echo "Success"
	  cd ..
	  return 0
    fi
}

err_log() {
	echo -e "\033[1;31m$1\033[0m"
}

create_archives () {
	cp LICENSE.md Binary
	cd Binary
	mv LICENSE.md LICENSE
	zip -r AccedoOneiOS.zip LICENSE AccedoOneiOS.framework
	zip -r AccedoOnetvOS.zip LICENSE AccedoOnetvOS.framework
	cd ..
}

create_release () {

	if ! [ -d "Release/$1" ]; then
		mkdir "Release/$1"
	fi

	cp -r Binary/AccedoOneiOS.framework "Release/$1"
	cp -r Binary/AccedoOnetvOS.framework "Release/$1"
	cp Binary/AccedoOneiOS.zip "Release/$1"
	cp Binary/AccedoOnetvOS.zip "Release/$1"
}

generate_podspecs () {
	./podgenerator ./Templates/AccedoOneiOS.podspec.local $1 ./AccedoOneiOS.podspec
	./podgenerator ./Templates/AccedoOnetvOS.podspec.local $1 ./AccedoOnetvOS.podspec
	./podgenerator ./Templates/AccedoOneiOS.podspec $1 ./Release/$1/AccedoOneiOS.podspec
	./podgenerator ./Templates/AccedoOnetvOS.podspec $1 ./Release/$1/AccedoOnetvOS.podspec
}

main () {
	if [ -z "$*" ]; then
		err_log "usage: ./release.sh version (ex: ./release.sh 1.0.0 )";
		exit 0
	fi

	echo "$1"

	read -p "Continue (y/n)?" CONT
	if [ "$CONT" = "y" ]; then
		rm -rf ./Binary/*

		if build_project AccedoOneiOS; then
			if build_project AccedoOnetvOS; then
				create_archives
				create_release $1
				generate_podspecs $1
			fi
		fi
		echo "remember: pod trunk push !!!!"
		exit 0
	else
		exit 1
	fi
}

main $1




