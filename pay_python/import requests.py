import requests
import time
import hashlib
import xml.etree.ElementTree as ET

class WeChatPay:
    def __init__(self, appid, mch_id, api_key):
        self.appid = appid
        self.mch_id = mch_id
        self.api_key = api_key
        self.url = "https://api.mch.weixin.qq.com/pay/unifiedorder"

    def generate_nonce_str(self):
        return hashlib.md5(str(time.time()).encode('utf-8')).hexdigest()

    def sign(self, params):
        stringA = '&'.join([f"{k}={v}" for k, v in sorted(params.items()) if v])
        stringSignTemp = f"{stringA}&key={self.api_key}"
        return hashlib.md5(stringSignTemp.encode('utf-8')).hexdigest().upper()

    def dict_to_xml(self, params):
        xml = ["<xml>"]
        for k, v in params.items():
            xml.append(f"<{k}>{v}</{k}>")
        xml.append("</xml>")
        return ''.join(xml)

    def xml_to_dict(self, xml):
        root = ET.fromstring(xml)
        return {child.tag: child.text for child in root}

    def create_order(self, body, out_trade_no, total_fee, spbill_create_ip, notify_url, trade_type="APP"):
        params = {
            "appid": self.appid,
            "mch_id": self.mch_id,
            "nonce_str": self.generate_nonce_str(),
            "body": body,
            "out_trade_no": out_trade_no,
            "total_fee": total_fee,
            "spbill_create_ip": spbill_create_ip,
            "notify_url": notify_url,
            "trade_type": trade_type,
        }
        params["sign"] = self.sign(params)
        xml = self.dict_to_xml(params)
        response = requests.post(self.url, data=xml)
        return self.xml_to_dict(response.content)

# Example usage
wechat_pay = WeChatPay(appid="your_appid", mch_id="your_mch_id", api_key="your_api_key")
order = wechat_pay.create_order(
    body="Test Order",
    out_trade_no="1234567890",
    total_fee=1,  # Amount in cents
    spbill_create_ip="123.12.12.123",
    notify_url="https://your_notify_url.com"
)
print(order)