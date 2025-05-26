while true
do
docker login 172.16.141.246
if [[ $? -eq 0 ]]; then
break
else
echo "Login Failed, Please Relogin!"
fi
done