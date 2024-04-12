#!/bin/bash
clear
# 跳转到脚本所在的目录
cd "$(dirname "$0")"

echo "------注意注意注意，必读必读必读------"
echo "特别声明：本通道服务器来自网络免费分享，为方便网友而自动抓取，我们对其可靠性和安全性不做任何承诺。"
echo "启动后如果Chrome页面打不开，请耐心稍等几分钟等待软件自动测试选择翻墙服务器。"
echo "------注意注意注意，以上内容必读，请认真阅读------"
echo "是否执行IP更新？IP更新从云端更新IP配置以解决封锁问题！第一次使用务必先更新IP."
echo "按3跳过，按1选择ip1更新，若ip1不好用再选ip2更新，如果更新后都用不了，请发邮件到 freeman105@gmail.com 进行反馈！"
read -p "1、ip1更新  2、ip2更新  3、跳过: " choice

case $choice in
    1) 
    bash "$(dirname "$0")/v2rayB/ip_Update/ip_1.sh"
        ;;
    2) 
    bash "$(dirname "$0")/v2rayB/ip_Update/ip_2.sh"
        ;;
    3) 
    echo "跳过IP更新"
        ;;
    *) 
    echo "无效选择"
        ;;
esac

ARCH=$(uname -m)

if [ -d "/Applications/Google Chrome.app" ]; then
    /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --user-data-dir="chrome-user-data" --proxy-server="socks5://127.0.0.1:20808"   "https://www.bannedbook.org/bnews/fq/?utm_source=chgo-v2rayB-mac" &
else
    echo "Chrome浏览器不存在或没有正确安装，请尝试重新安装Chrome浏览器"
	echo "按任意键关闭..."
	read -n 1 -s -r
	exit 0
fi

if [ "$ARCH" == "arm64" ]; then
    # M1 芯片
    Xray/xray-arm64 -c Xray/config.json
else
    # 假设其他的都是 amd64 架构
    Xray/xray-amd64 -c Xray/config.json
fi


