# SPDX-License-Identifier: GPL-3.0-only
# luci-app-hermes — OpenWrt LuCI plugin for Hermes Agent (Python AI Gateway)

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-hermes-agent
LUCI_TITLE:=Hermes AI Agent Gateway
LUCI_DESCRIPTION:=Python-based AI Agent Gateway for OpenWrt: web UI, API proxy, and config terminal.
LUCI_DEPENDS:=+luci-base +python3
LUCI_PKGARCH:=all
PKG_VERSION:=2026.05.10
PKG_RELEASE:=2

# Disable JS minification — complex regex/template literals break with jsmin
LUCI_MINIFY_JS:=0

include $(TOPDIR)/feeds/luci/luci.mk

define Package/luci-app-hermes-agent/conffiles
/etc/config/hermes_agent
endef

define Package/luci-app-hermes-agent/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	rm -f /tmp/luci-indexcache /tmp/luci-modulecache/* 2>/dev/null
	exit 0
}
endef

# call BuildPackage - OpenWrt buildroot signature
