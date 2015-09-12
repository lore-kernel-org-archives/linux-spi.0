From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH V2 0/6] spi/bcm63xx: cleanup and decouple from arch code
Date: Sat, 12 Sep 2015 18:06:57 +0200
Message-ID: <1442074023-29840-1-git-send-email-jogo@openwrt.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patchset decouples spi-bcm63xx from any arch code to allow building
it for more than MIPS/BCM63XX as well as allow compile testing it on any
arch/platform.

Since the main target of this patch is the spi driver, it should
probably go through the spi tree.

Changes v1 -> v2:

* Use device name instead of register size for identifying core
  version.
* Since we now touch arch/mips, drop the rest as well.
* Fix big endian detection.
* Reorder the patches so the move of the register definitions is the
  last step.

Jonas Gorski (6):
  spi/bcm63xx: remove unused rx_tail variable
  spi/bcm63xx: always use a fixed number of CS
  spi/bcm63xx: hardcode busnum to 0
  spi/bcm63xx: replace custom io accessors with standard ones
  spi/bcm63xx: move message control word description to register offsets
  spi/bcm63xx: move register definitions into the driver

 arch/mips/bcm63xx/dev-spi.c                        |  42 +----
 .../include/asm/mach-bcm63xx/bcm63xx_dev_spi.h     |  44 -----
 drivers/spi/Kconfig                                |   2 +-
 drivers/spi/spi-bcm63xx.c                          | 210 ++++++++++++++++++---
 4 files changed, 188 insertions(+), 110 deletions(-)

-- 
2.1.4
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
