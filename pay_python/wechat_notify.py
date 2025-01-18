from flask import Flask, request, jsonify
import xml.etree.ElementTree as ET

app = Flask(__name__)

@app.route('/wechat_notify', methods=['POST'])
def wechat_notify():
    xml_data = request.data
    root = ET.fromstring(xml_data)
    result = {child.tag: child.text for child in root}

    # 验证签名（这里省略签名验证的代码）
    # ...

    if result.get("return_code") == "SUCCESS":
        # 处理支付成功的逻辑
        # ...
        response = {
            "return_code": "SUCCESS",
            "return_msg": "OK"
        }
    else:
        # 处理支付失败的逻辑
        # ...
        response = {
            "return_code": "FAIL",
            "return_msg": "ERROR"
        }

    return jsonify(response)

if __name__ == '__main__':
    app.run(port=5000)