From: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v4 0/3] Fix for imx-spi CS GPIOs
Date: Mon,  6 Nov 2017 11:46:15 -0800
Message-ID: <20171106194618.9421-1-tpiepho@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Changes from V1:
 * Collected reviewed bys.
 * Minor change to coding style in one patch.

Changes from V2:
 * Reverted minor coding change from V2, it was right to begin with
 * Have imx-spi also honor "num-cs" property
 * Leak of spi_bitbang on failure needed to be fixed differently
 * Port to linux-next, which has other changes to spi-imx

Changes from V3:
 * Remove leak fix patch which was applied separately.
 * Add documentation about native CS to driver tree bindings document.

CC: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
CC: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
CC: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>,
CC: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Trent Piepho (3):
  spi: imx: GPIO chip select DT property should not be required
  spi: imx: Don't require platform data chipselect array
  ARM: imx: Update spi_imx platform data to reflect current state

 .../devicetree/bindings/spi/fsl-imx-cspi.txt       | 18 ++++++++----
 arch/arm/mach-imx/mach-mx31_3ds.c                  | 18 ++----------
 arch/arm/mach-imx/mach-mx31lilly.c                 | 12 ++------
 arch/arm/mach-imx/mach-mx31lite.c                  | 16 ++---------
 arch/arm/mach-imx/mach-mx31moboard.c               | 17 ++----------
 arch/arm/mach-imx/mach-pcm037_eet.c                |  5 +---
 drivers/spi/spi-imx.c                              | 32 ++++++++++++----------
 include/linux/platform_data/spi-imx.h              | 29 ++++++++++++--------
 8 files changed, 57 insertions(+), 90 deletions(-)

-- 
2.14.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
