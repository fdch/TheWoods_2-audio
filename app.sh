#!/bin/sh
#
# version number


VERSION=1.1
MACAPPNAME=TheWoods

# exclude from the deploy
EXCLUDE=(app app.sh backup backup.sh bak .gitignore)
DEVDIR=~/Development
DIR=$(pwd)
APPNAME=${MACAPPNAME}-${VERSION}.app
APP=${DIR}/${APPNAME} # app bundle
ZIP=${APP//.app/}-macos.zip
PATCHDIR=${APP}/Contents/Resources/patch/ # 'patch' dir inside bundle

for i in ${EXCLUDE[@]}; do EX+="--exclude=$i "; done

run() {
	if [[ "$1" == "test" ]] || [[ $1 == "t" ]]; then
		echo "Opening App"
		open ${APP}
	else
		echo "Creating App"
		# place everything inside the patch directory
		rsync -qaP ${EX} ${DIR}/bin/* ${PATCHDIR}
		
		# while read d; do
		# 	# this should dowlonad w/ deken
		# 	rsync -qaP ${EXTDIR}/$d "${PATCHDIR}/lib/"
		# done < dependencies.txt

		# remove previous zip file if it exists 
		if [[ -f ${ZIP} ]]; then
			rm -rf ${ZIP}
		fi
		# create a new zip file
		cd ${DIR} && zip -r ${ZIP} ./*.app && cd - 
		zip ${ZIP} README.md *.txt
		echo "--- ${APPNAME} created."
	fi
}

if [[ $# -gt 1 ]]; then
	echo "Ignoring extra arguments after $1"
	run $1
elif [[ $# -eq 1 ]]; then
	run $1
else
	echo "No arguments passed."
	echo "--- Usage: ./app [t|d|b]"
	printf "%6s\t(%s)%s\n"  "test"   "t" "ests the app bundle"
	printf "%6s\t(%s)%s\n"  "deploy" "d" "eploys & zips patch in app bundle"
fi
