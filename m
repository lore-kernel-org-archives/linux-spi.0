From: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: Stop selecting MTD_SPI_NOR for SPI_HISI_SFC_V3XX
Date: Thu, 12 Mar 2020 01:35:15 +0800
Message-ID: <1583948115-239907-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
        <linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>,
        <Tudor.Ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>,
        <chenxiang66-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

By selecting MTD_SPI_NOR for SPI_HISI_SFC_V3XX, we may introduce unmet
dependencies:

WARNING: unmet direct dependencies detected for MTD_SPI_NOR
  Depends on [m]: MTD [=m] && SPI_MASTER [=y]
  Selected by [y]:
  - SPI_HISI_SFC_V3XX [=y] && SPI [=y] && SPI_MASTER [=y] && (ARM64 && ACPI [=y] || COMPILE_TEST [=y]) && HAS_IOMEM [=y]

Since MTD_SPI_NOR is only selected by SPI_HISI_SFC_V3XX for practical
reasons - slave devices use the spi-nor driver, enabled by MTD_SPI_NOR -
just drop it.

Signed-off-by: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 66c6c0d77ea7..ad1a2547a414 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -299,7 +299,6 @@ config SPI_HISI_SFC_V3XX
 	tristate "HiSilicon SPI-NOR Flash Controller for Hi16XX chipsets"
 	depends on (ARM64 && ACPI) || COMPILE_TEST
 	depends on HAS_IOMEM
-	select MTD_SPI_NOR
 	help
 	  This enables support for HiSilicon v3xx SPI-NOR flash controller
 	  found in hi16xx chipsets.
-- 
2.17.1
