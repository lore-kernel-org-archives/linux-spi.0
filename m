From: kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
Subject: [PATCH] spi: xlp: Enable SPI driver for Broadcom Vulcan ARM64
Date: Tue, 22 Mar 2016 18:38:14 +0530
Message-ID: <1458652094-4484-1-git-send-email-kamlakant.patel@broadcom.com>
Cc: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

- Vulcan spi controller is compatible with netlogic,xlp832-spi.
- Add depends on ARCH_VULCAN to Kconfig to enable spi controller
  driver for Broadcom Vulcan ARM64 SoCs.

Signed-off-by: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 7706416..4bdf441 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -620,7 +620,7 @@ config SPI_XILINX
 
 config SPI_XLP
 	tristate "Netlogic XLP SPI controller driver"
-	depends on CPU_XLP || COMPILE_TEST
+	depends on CPU_XLP || ARCH_VULCAN || COMPILE_TEST
 	help
 	  Enable support for the SPI controller on the Netlogic XLP SoCs.
 	  Currently supported XLP variants are XLP8XX, XLP3XX, XLP2XX, XLP9XX
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
