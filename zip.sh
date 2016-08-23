PROJECT_NAME=${PWD##*/}

if [ -f $PROJECT_NAME.zip ]; then
	rm -fr $PROJECT_NAME.zip
fi

zip -r ./$PROJECT_NAME.zip ./Pod/*

if [ "$?" -eq "0" ];then
	echo "pack file $CUR_FILE into $PROJECT_NAME.zip file ok~!"
else
	echo "Error:Pack file into $PROJECT_NAME.zip failed~!"
	exit 1
fi

# # 上传到服务器
expect zip.ep $PROJECT_NAME

