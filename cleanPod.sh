PROJECT_NAME=${PWD##*/}

POD_NAME=$1

if [[ ! $POD_NAME ]]; then
	cd Example
	rm -rf Pods
	echo "pod install"
	IS_SOURCE=1 pod install
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
 	    echo "pod install"
 	    IS_SOURCE=1 pod install	
	fi
fi