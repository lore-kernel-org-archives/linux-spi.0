From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 0/6] spi/bcm63xx: cleanup and decouple from arch code
Date: Thu, 10 Sep 2015 16:11:38 +0200
Message-ID: <1441894304-22316-1-git-send-email-jogo@openwrt.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patchset decouples spi-bcm63xx from any arch code to allow building
it for more than MIPS/BCM63XX as well as allow compile testing it on any
arch/platform.

Based on for-next, obviously 4.4 material.

Jonas Gorski (6):
  spi/bcm63xx: remove unused rx_tail variable
  spi/bcm63xx: always use a fixed number of CS
  spi/bcm63xx: hardcode busnum to 0
  spi/bcm63xx: replace custom io accessors with standard ones
  spi/bcm63xx: move register definitions into the driver
  spi/bcm63xx: move message control word description to register offsets

 drivers/spi/Kconfig       |   2 +-
 drivers/spi/spi-bcm63xx.c | 195 +++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 176 insertions(+), 21 deletions(-)

-- 
2.1.4
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
