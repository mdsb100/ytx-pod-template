PROJECT_NAME=${PWD##*/}

POD_NAME=$1

if [[ ! $POD_NAME ]]; then
	echo "pod cache clean --all"
	cd Example
	rm -rf Pods
	pod cache clean --all
	echo "pod install"
	pod install
else
	cd Example/Pods
	DIRNAME=$(ls -l | grep ^d | grep -o ${POD_NAME})
	if [[ ! $DIRNAME ]]; then
		echo "Pod name is error, Please re operate！"
 		exit 0
	else
		echo "pod cache clean -$POD_NAME"
		rm -rf '$POD_NAME'
 	    rm -rf Pods.xcodeproj 
 	    cd ..
 	    pod cache clean -$POD_NAME
 	    echo "pod install"
 	    pod install	
	fi
fi