import requests
import json
import decimal

from_addr = input('请输入要归集的地址: ')

url = "http://127.0.0.1:3001"
precision = 24
gas_fee = decimal.Decimal("0.000835")
to_addr='386c181ce6ac75e9b133ef61e36f1c023b63ee56ef6681fb89adf625519d81b5'

print("gas_fee",gas_fee)

payload = {
	"id":1,
	"jsonrpc":"2.0",
	"method":"getbalance",
	"params":[ from_addr ]
}
headers = {
    'Content-Type': 'application/json'
}

response = requests.post(url, headers=headers, data=json.dumps(payload))
res_json = response.json()

#res_json = json.loads('{"jsonrpc":"2.0","id":1,"result":{"total":"3500000000000000000000000","stateStaked":"1820000000000000000000","staked":"0","available":"3498180000000000000000000"}}')

print("response===>",res_json)

result = res_json['result']
bigint_balance = decimal.Decimal(result['available'])   #将字符串转为bigint类型
balance = bigint_balance / pow(10,precision) 
print("balance ==>",balance)

##计算归集金额 = 余额 - 归集手续费
collect_amt = balance - gas_fee 
collect_amt_big = int(collect_amt * pow(10,precision))

print("colletion_amt==>" , collect_amt , " collect_amt_big===>",collect_amt_big)

with open('wallet/mainnet/' + from_addr + '.json', 'r') as key_file:
    key_data = json.load(key_file)
    #print(key_data)
private_key = key_data['privateKey']
print("privateKey===>", private_key)

tx_params =  {
	"id":1,
	"jsonrpc":"2.0",
	"method":"sendtransaction",
	"params":[{
		"from" : from_addr,
		"to": to_addr,
		"value": str(collect_amt_big),
		"privateKey": private_key
	}]
}

print("tx_params===>",tx_params)

collect_res =requests.post(url, headers=headers, data=json.dumps(tx_params))

print("归集结果==>",collect_res.text)
