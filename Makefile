# LuCI PeDitX Theme
# Copyright 2024 PeDitX <pedram.ale@me.com>
#
# Licensed under the Apache License v2.0
# http://www.apache.org/licenses/LICENSE-2.0

include $(TOPDIR)/rules.mk

THEME_NAME:=peditx
THEME_TITLE:=PeDitX

PKG_NAME:=luci-theme-$(THEME_NAME)
PKG_VERSION:=1.0.1
PKK_RELEASE:=4

include $(INCLUDE_DIR)/package.mk

define Package/luci-theme-$(THEME_NAME)
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=9. Themes
  DEPENDS:=+libc
  TITLE:=LuCI Theme For OpenWrt - $(THEME_TITLE)
  URL:=http://t.me/peditx
  PKGARCH:=all
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-theme-$(THEME_NAME)/install
	# Copy theme files to /usr/lib/lua/luci/view/themes
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/themes/$(THEME_NAME)
	$(CP) -a ./luasrc/view/themes/$(THEME_NAME)/* $(1)/usr/lib/lua/luci/view/themes/$(THEME_NAME)/

	# Copy UCI Defaults script to /etc/uci-defaults
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(CP) ./root/etc/uci-defaults/30-luci-theme-$(THEME_NAME) $(1)/etc/uci-defaults/

	# Ensure static theme files are in the correct www path
	$(INSTALL_DIR) $(1)/www/luci-static/$(THEME_NAME)
	$(CP) -a ./js/* $(1)/www/luci-static/$(THEME_NAME)/ 2>/dev/null || true
endef

define Package/luci-theme-$(THEME_NAME)/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	. /etc/uci-defaults/30-luci-theme-$(THEME_NAME)
}
endef

$(eval $(call BuildPackage,luci-theme-$(THEME_NAME)))
