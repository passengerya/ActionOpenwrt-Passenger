#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >>feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >>feeds.conf.default


# UA2F相关插件
git clone https://github.com/Zxilly/UA2F.git package/UA2F
git clone https://github.com/CHN-beta/rkp-ipid package/rkp-ipid

# BitSrunLoginGo_Openwrt
git clone -b v2.7 https://github.com/Mmx233/BitSrunLoginGo_Openwrt package/BitSrunLoginGo_Openwrt
# 克隆老竭力的argon主题
# git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/argon
# 克隆rosy主题
https://github.com/rosywrt/luci-theme-rosy.git package/rosy
# 拉取easyupgrade插件（利用ActionOpenwrt在线编译来在线升级）
svn co https://github.com/sundaqiang/openwrt-packages/trunk/luci-app-easyupdate package/easyupgrade
