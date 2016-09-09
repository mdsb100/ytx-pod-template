sh cleanBranch.sh

git merge master

PROJECT_NAME=${PWD##*/}

ORIGIN_BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [[ ! $(which gitlab) ]]; then
	sudo npm install -g gitlab
fi

JSON_RESULT=$(gitlab projects --filter "item.path=='$PROJECT_NAME'")
echo "var ret = $JSON_RESULT; console.log(ret[0].id);" > "p.js"
PROJECT_ID=$(node p.js)
rm "p.js"

URL=$(gitlab url)

if [ ${#URL} -le 0 ]
then 
	echo "请安装cli-gitlab，并填写gitlab地址"
	exit 1
fi

TOKEN=$(gitlab token)

if [ ${#TOKEN} -le 0 ]
then 
	echo "请填写gitlab token"
	exit 1
fi

echo "请输入merge信息"
read TITLE

TARGET_BRANCH='master'

echo "target branch is '$TARGET_BRANCH'"

CURRENT_POD_VERSION=$(cat $PROJECT_NAME.podspec | grep 's.version' | grep -o '[0-9]*\.[0-9]*\.[0-9]*')

BRANCH="FeatureNewVersion@$CURRENT_POD_VERSION"

echo $BRANCH

git checkout -b $BRANCH

git push --set-upstream origin $BRANCH

# MERGE_REQUEST_URL=${URL}"/api/v3/projects/$PROJECT_ID/merge_requests"

# MERGE_REQUEST_PARAM="-F id=$PROJECT_ID -F source_branch=$BRANCH -F target_branch=$TARGET_BRANCH -F assignee_id=9 -F title=$TITLE"

# curl -X POST -H "PRIVATE-TOKEN: ${TOKEN}" $MERGE_REQUEST_PARAM $MERGE_REQUEST_URL

gitlab addMergeRequest $PROJECT_ID $BRANCH $TARGET_BRANCH 9 $TITLE

git checkout $ORIGIN_BRANCH
