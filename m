From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/4] spi: davinci: Improve prescaler limit support
Date: Tue, 14 Jul 2015 14:45:23 -0500
Message-ID: <1436903127-6777-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Currently the prescale limit is treated as a one size fits all value even
though their are differences depending on the SOC. This patchset insures
that the proper prescale limit is used for each platform/SOC.

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
