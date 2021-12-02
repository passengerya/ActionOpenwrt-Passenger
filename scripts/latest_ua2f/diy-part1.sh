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

# 自定义添加插件
git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
