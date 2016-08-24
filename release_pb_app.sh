PROJECT_NAME=${PWD##*/}

APP_NAME="PBApp"

APP_PATH="$APP_NAME/workspace/Podfile"

NOW_BRANCH=$(git branch)

echo "The branch of $APP_NAME is '$NOW_BRANCH'. It will update app podfile at same branch"

if [ ! -d "$APP_NAME" ]; then
  git clone http://gitlab.baidao.com/pb/PBApp.git
fi

CURRENT_POD_VERSION=$(cat $PROJECT_NAME.podspec | grep -o '[0-9]*\.[0-9]*\.[0-9]*')

echo "This current version is $CURRENT_POD_VERSION"

ORIGIN_POD_VALUE=$(cat $APP_PATH | grep $PROJECT_NAME)
NEW_POD_VALUE="    pod '$PROJECT_NAME', '$CURRENT_POD_VERSION'"

echo "s/$ORIGIN_POD_VALUE/$NEW_POD_VALUE/g"

sed -i "" "s/$ORIGIN_POD_VALUE/$NEW_POD_VALUE/g" $APP_PATH

cat $APP_PATH

cd PBApp/workspace

git checkout master

pod repo update baidao-ios-ytx-pod-specs

if [[ $(which podh) ]]; then
	echo 'podh install'
	podh install
else
	echo 'pod install'
	pod install
fi

git commit -am "Update podfile by CI: $ORIGIN_POD_VALUE ---> $NEW_POD_VALUE"
git push

cd ../..
