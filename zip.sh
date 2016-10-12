PROJECT_NAME=${PWD##*/}

if [ -f $PROJECT_NAME.zip ]; then
	rm -fr $PROJECT_NAME.zip
fi

zip -r ./$PROJECT_NAME.zip ./$PROJECT_NAME/* ./LICENSE ./README.md

if [ "$?" -eq "0" ];then
	echo "pack file $CUR_FILE into $PROJECT_NAME.zip file ok~!"
else
	echo "Error:Pack file into $PROJECT_NAME.zip failed~!"
	exit 1
fi

# # 上传到服务器

if [[ ! $(which sshpass) ]]; then
	brew install https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb
fi

sshpass -p "111111" scp $PROJECT_NAME.zip binaryadmin@ios-pod.baidao.com:/opt/binaryfiles/

ret=$?

if [ "$ret" -ne "0" ];then
	exit 1
fi