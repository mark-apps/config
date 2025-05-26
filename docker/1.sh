cd /ebank/spdb-cli-mobcli/gitlab-ci/;
tmp_ans=$(echo $Image_Version|tr [a-z] [A-Z])   ##将输入全部转成大写
if [[ -z $Image_Version ]] ; then
Image_Version=SIT-`date +%Y%m%d-%H%M`
elif [[ $tmp_ans == "SIT" ]] || [[ $tmp_ans == "UAT" ]] || [[ $tmp_ans == "REL" ]] || [[ $tmp_ans == "YACE" ]]; then
Image_Version=$tmp_ans-`date +%Y%m%d-%H%M`
fi
IMAGE_URI=${Image_Ip}/${Image_Namespace}/${Image_Name}${Image_Extends}:${Image_Version};
docker build . -t $IMAGE_URI;
docker login ${Image_Ip} -u ${Image_User} -p ${Image_Pwd};
docker push $IMAGE_URI;
echo "打包成功，请登录Caas平台更新镜像。镜像名称： ${IMAGE_URI}"