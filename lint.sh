SOURCES='http://gitlab.baidao.com/ios/ytx-pod-specs.git,master'
pod cache clean --all
IS_SOURCE=1 pod lib lint --sources=$SOURCES --verbose --fail-fast
pod cache clean --all
pod lib lint --sources=$SOURCES --verbose --use-libraries --fail-fast