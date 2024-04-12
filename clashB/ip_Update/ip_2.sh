#!/bin/bash

# 设置脚本标题
echo -ne "\033]0;云端更新最新配置\007"

# 跳转到脚本所在的目录
cd "$(dirname "$0")"

# 尝试下载配置的函数
download_config() {
    curl -k -O -L "$1"
    if [[ -f "1302338.md" ]]; then
        start_copy
        exit 0
    fi
}

# 备份并替换配置的函数
start_copy() {
    rm -f "../config.yaml_backup"
    [ -f "../config.yaml" ] && mv "../config.yaml" "../config.yaml_backup"
    mv -f "1302338.md" "../config.yaml"
    echo -e "\n已更新完成最新配置,请按回车键或空格键启动程序！"
    read -n 1 -s -r
}

# 尝试从第一个URL下载配置
download_config "https://www.githubip.xyz/jsvpn/jsproxy/dev/baitai/20200329/1302338.md"

# 尝试从第二个URL下载配置
download_config "https://fastly.jsdelivr.net/gh/jsvpn/jsproxy@dev/baitai/20200329/1302338.md"

echo "ip更新失败，请试试其它ip更新"
read -p "按任意键继续..."
exit 1
