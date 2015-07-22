From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Subject: [RESEND][PATCH 0/4] spi: davinci: Improve prescaler limit support
Date: Wed, 22 Jul 2015 07:32:20 -0500
Message-ID: <1437568344-18889-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>,
	<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<pawel.moll-5wv7dgnIgG8@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<linux-arm-kernel-xBCQruHUn5ppWr+L1FloEB2eb7JE58TQ@public.gmane.org>,
	Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <nsekhar-l0cyMroinI0@public.gmane.org>, <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Currently the prescale limit is treated as one size fits all value even
though there are differences depending on the SOC. This patchset insures
that the proper prescale limit is used for each platform/SoC.

Franklin S Cooper Jr (4):
  spi: davinci: Set prescale value based on register value
  spi: davinci: Choose correct pre-scaler limit based on SOC
  ARM: davinci: Set proper SPI prescale limit value
  ARM: dts: keystone: Add ti,keystone-spi for SPI

 .../devicetree/bindings/spi/spi-davinci.txt        |  2 +
 arch/arm/boot/dts/keystone.dtsi                    |  6 +--
 arch/arm/mach-davinci/devices-da8xx.c              |  2 +
 arch/arm/mach-davinci/dm355.c                      |  1 +
 arch/arm/mach-davinci/dm365.c                      |  1 +
 drivers/spi/spi-davinci.c                          | 50 +++++++++++++++++-----
 include/linux/platform_data/spi-davinci.h          |  1 +
 7 files changed, 50 insertions(+), 13 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
