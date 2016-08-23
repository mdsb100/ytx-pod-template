
#获得当前目录的名字，一般是YTXChartSocket这种
PROJECT_NAME=${PWD##*/}

IS_SOURCE=1 pod package ${PROJECT_NAME}.podspec --exclude-deps --no-mangle --library --spec-sources=http://gitlab.baidao.com/ios/ytx-pod-specs.git,https://github.com/CocoaPods/Specs.git

BINARY_DIR=$(ls -l | grep ^d | grep -o "${PROJECT_NAME}-.*")
cp -rp $BINARY_DIR/ios/ $PROJECT_NAME/lib

rm -rf $BINARY_DIR

# 去除.a armv7s i386的架构
cd $PROJECT_NAME/lib

lipo "lib${PROJECT_NAME}.a" -remove armv7s -remove i386 -output "lib${PROJECT_NAME}.a"

lipo -info "lib${PROJECT_NAME}.a"
echo "copy Success"