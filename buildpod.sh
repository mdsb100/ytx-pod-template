PROJECT_NAME=${PWD##*/}

pushd "$(dirname "$0")" > /dev/null
SCRIPT_DIR=$(pwd -L)
popd > /dev/null

echo "publish repo YTXRequest"
pod repo push baidao-ios-ytx-pod-specs $PROJECT_NAME.podspec --verbose --use-libraries

ret=$?

if [ "$ret" -ne "0" ];then
	exit 1
fi