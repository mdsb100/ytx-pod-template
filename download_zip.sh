PROJECT_NAME=${PWD##*/}
URL=$1

if [[ -f $PROJECT_NAME/lib/lib$PROJECT_NAME.a ]]; then
	echo "$PROJECT_NAME/lib/lib$PROJECT_NAME.a Exist"
	exit 0
fi

if [[ ! $URL ]]; then
	URL_KEY="ytx_zipURL="
	URL=$(cat $PROJECT_NAME.podspec | grep "$URL_KEY" | sed -e "s/$URL_KEY//g" | sed -e "s/\'//g")
fi

if [[ ! -d ytxtemp ]]; then
	mkdir ytxtemp
fi
cd ytxtemp
curl -O -v $URL

if [[ -f $PROJECT_NAME.zip ]]; then
	unzip $PROJECT_NAME.zip
	cp -fr $PROJECT_NAME/lib ../$PROJECT_NAME/
fi

cd ..
rm -fr ytxtemp