#!/bin/bash
clear
# 跳转到脚本所在的目录
cd "$(dirname "$0")"

echo "是否执行IP更新？IP更新从云端更新IP配置以解决封锁问题！第一次使用务必先更新IP."
echo "按5跳过，按1选择ip1更新，若ip1不好用再选ip2更新，如果更新后都用不了，请发邮件到 freeman105@gmail.com 进行反馈！"
read -p "1、ip1更新  2、ip2更新  3、跳过: " choice

case $choice in
    1) 
    bash "$(dirname "$0")/naiveproxy/ip_Update/ip_1.sh"
        ;;
    2) 
    bash "$(dirname "$0")/naiveproxy/ip_Update/ip_2.sh"
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
    /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --user-data-dir="chrome-user-data" --proxy-server="socks5://127.0.0.1:1080"  "https://www.bannedbook.org/bnews/fq/?utm_source=chgo-naive-mac" &
else
    echo "Chrome浏览器不存在或没有正确安装，请尝试重新安装Chrome浏览器"
	echo "按任意键关闭..."
	read -n 1 -s -r
	exit 0
fi

if [ "$ARCH" == "arm64" ]; then
    # M1 芯片
    naiveproxy/naive-arm64 naiveproxy/config.json
else
    # 假设其他的都是 amd64 架构
    naiveproxy/naive-amd64 naiveproxy/config.json
fi
