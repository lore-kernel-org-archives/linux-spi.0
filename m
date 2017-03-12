From: Jayachandran C <jnair-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH] spi: xlp: update for ARCH_VULCAN2
Date: Sun, 12 Mar 2017 11:11:43 +0000
Message-ID: <1489317103-5329-1-git-send-email-jnair@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jayachandran C <jnair-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kamlakant.Patel-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

ARCH_VULCAN arm64 platform (for Broadcom Vulcan ARM64 processors) has
been discontinued. Cavium's ThunderX2 CN99XX (ARCH_THUNDER2) will be
the next revision of the platform.

Update compile dependencies and ACPI ID to reflect this change. There
is not need to retain ARCH_VULCAN since the Vulcan processor was never
in production and ARCH_VULCAN will be deleted soon.

Signed-off-by: Jayachandran C <jnair-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
---
[ I am keeping both changes in the same patch hoping it will go in thru
 the SPI maintainer, but I can split this to 2 if needed]

 drivers/acpi/acpi_apd.c | 1 +
 drivers/spi/Kconfig     | 2 +-
 drivers/spi/spi-xlp.c   | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 26696b6..17a1eb1 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -169,6 +169,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
 #ifdef CONFIG_ARM64
 	{ "APMC0D0F", APD_ADDR(xgene_i2c_desc) },
 	{ "BRCM900D", APD_ADDR(vulcan_spi_desc) },
+	{ "CAV900D",  APD_ADDR(vulcan_spi_desc) },
 #endif
 	{ }
 };
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 25ae7f2e..1761c90 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -715,7 +715,7 @@ config SPI_XILINX
 
 config SPI_XLP
 	tristate "Netlogic XLP SPI controller driver"
-	depends on CPU_XLP || ARCH_VULCAN || COMPILE_TEST
+	depends on CPU_XLP || ARCH_THUNDER2 || COMPILE_TEST
 	help
 	  Enable support for the SPI controller on the Netlogic XLP SoCs.
 	  Currently supported XLP variants are XLP8XX, XLP3XX, XLP2XX, XLP9XX
diff --git a/drivers/spi/spi-xlp.c b/drivers/spi/spi-xlp.c
index bea7a93..80cb4d6 100644
--- a/drivers/spi/spi-xlp.c
+++ b/drivers/spi/spi-xlp.c
@@ -442,6 +442,7 @@ static int xlp_spi_probe(struct platform_device *pdev)
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id xlp_spi_acpi_match[] = {
 	{ "BRCM900D", 0 },
+	{ "CAV900D",  0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, xlp_spi_acpi_match);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
