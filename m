From: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: [PATCH v3 6/7] ARM: at91/defconfig: enable MMC_SDHCI_OF_AT91 and MICROCHIP_PIT64B
Date: Tue, 14 Jan 2020 12:23:16 +0200
Message-ID: <1578997397-23165-7-git-send-email-claudiu.beznea@microchip.com>
References: <1578997397-23165-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-rtc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
To: <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        <mark.rutland-5wv7dgnIgG8@public.gmane.org>, <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        <radu_nicolae.pirea-8LCfxC+Vs8U@public.gmane.org>, <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1578997397-23165-1-git-send-email-claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Enable MMC_SDHCI_OF_AT91 and MICROCHIP_PIT64B. These are necessary
for SAM9X60.

Signed-off-by: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
---
 arch/arm/configs/at91_dt_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 5c5df8bc0074..f66bb98a5cce 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -160,6 +160,9 @@ CONFIG_USB_AT91=y
 CONFIG_USB_ATMEL_USBA=y
 CONFIG_USB_G_SERIAL=y
 CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_OF_AT91=y
 CONFIG_MMC_ATMELMCI=y
 CONFIG_MMC_SPI=y
 CONFIG_NEW_LEDS=y
@@ -177,6 +180,7 @@ CONFIG_RTC_DRV_AT91SAM9=y
 CONFIG_DMADEVICES=y
 CONFIG_AT_HDMAC=y
 CONFIG_AT_XDMAC=y
+CONFIG_MICROCHIP_PIT64B=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_IIO=y
 CONFIG_AT91_ADC=y
-- 
2.7.4
