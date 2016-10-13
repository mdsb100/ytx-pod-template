SOURCES='http://gitlab.baidao.com/ios/ytx-pod-specs.git,master'
IS_SOURCE=1 pod lib lint --sources=$SOURCES --verbose --fail-fast --use-libraries