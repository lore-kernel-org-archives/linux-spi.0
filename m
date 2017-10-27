From: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 0/4] Fix for imx-spi CS GPIOs
Date: Thu, 26 Oct 2017 18:08:37 -0700
Message-ID: <20171027010841.28624-1-tpiepho@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This fixes a bug where GPIO based chip selects must be specified in the OF
node for spi-imx when they should be optional.

Fixes a regression in the platform data of imx31moboard.

Clean up of some old platform data based spi-imx users.

Changes from V1:
 * Collected reviewed bys.
 * Minor change to coding style in one patch.

Trent Piepho (4):
  spi: imx: GPIO based chip selects should not be required
  spi: imx: Fix failure path leak on GPIO request error
  spi: imx: Don't require platform data chipselect array
  ARM: imx: Update spi_imx platform data to reflect current state

 arch/arm/mach-imx/mach-mx31_3ds.c     | 18 ++-------------
 arch/arm/mach-imx/mach-mx31lilly.c    | 12 ++--------
 arch/arm/mach-imx/mach-mx31lite.c     | 16 ++------------
 arch/arm/mach-imx/mach-mx31moboard.c  | 17 +++------------
 arch/arm/mach-imx/mach-pcm037_eet.c   |  5 +----
 drivers/spi/spi-imx.c                 | 41 ++++++++++++++++-------------------
 include/linux/platform_data/spi-imx.h | 29 +++++++++++++++----------
 7 files changed, 46 insertions(+), 92 deletions(-)

-- 
2.14.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
