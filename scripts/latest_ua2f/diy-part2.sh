#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

####################################################################################################
####################################自定义配置#######################################################
####################################################################################################

# 修改默认IP(Modify default IP)
sed -i 's/192.168.1.1/192.168.100.1/g' package/base-files/files/bin/config_generate

# 修改NTP服务器(Modify default NTP server for campus_internet)
echo 'Modify default NTP server...'
sed -i 's/ntp.aliyun.com/ntp1.aliyun.com/g' package/base-files/files/bin/config_generate
sed -i 's/time1.cloud.tencent.com/time1.cloud.tencent.com/g' package/base-files/files/bin/config_generate
sed -i 's/time.ustc.edu.cn/stdtime.gov.hk/g' package/base-files/files/bin/config_generate
sed -i 's/cn.pool.ntp.org/pool.ntp.org/g' package/base-files/files/bin/config_generate

# 修改默认主题(Modify default theme)
echo 'Modify default theme...'
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 固件版本栏自定义用户名
#sed -i "s/Openwrt /passenger compiled in $(TZ=UTC-8 date "+%Y.%m.%d") @ Openwrt /g" $ZZZ
# 修改版本信息
date=`date +%Y.%m.%d`
sed -i 's/OpenWrt/OpenWrt Build '$date' By passenger/g' package/lean/default-settings/files/zzz-default-settings
sed -i 's/%D %V, %C/%D %V, '$date' By passenger/g' package/base-files/files/etc/banner

# 清除登录密码
#sed -i  's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g'  openwrt/package/lean/default-settings/files/zzz-default-settings
#设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings

#加入定时清理内存
sed -i "28a\echo \'*/60 * * * * sh /etc/memclean.sh\' > /etc/crontabs/root" package/lean/default-settings/files/zzz-default-settings
#赋予定时清理内存脚本权限
sed -i '56a\chmod 1777 /etc/memclean.sh' package/lean/default-settings/files/zzz-default-settings
sed -i '57a\chmod 1777 /sbin/shutdown' package/lean/default-settings/files/zzz-default-settings

# Replace openwrt.org in diagnostics with www.baidu.com
echo 'Replace openwrt.org in diagnostics.htm with www.baidu.com...'
sed -i "/exit 0/d" package/lean/default-settings/files/zzz-default-settings
cat <<EOF >>package/lean/default-settings/files/zzz-default-settings
uci set luci.diag.ping=www.baidu.com
uci set luci.diag.route=www.baidu.com
uci set luci.diag.dns=www.baidu.com
uci commit luci
exit 0
EOF
############################################################################################################
###############################UA2F#########################################################################
############################################################################################################

# 修改UA2F为开机自启
sed -i 's/option enabled '0'/option enabled '1'/g' package/UA2F/files/ua2f.config

# UA2F内核配置加入CONFIG_NETFILTER_NETLINK_GLUE_CT
target=$(grep "^CONFIG_TARGET" .config --max-count=1 | awk -F "=" '{print $1}' | awk -F "_" '{print $3}')
for configFile in $(ls target/linux/$target/config*)
do
    echo -e "\nCONFIG_NETFILTER_NETLINK_GLUE_CT=y" >> $configFile
done
