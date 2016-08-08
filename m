From: kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
Subject: [PATCH 1/2] ACPI / APD: Add device HID for Vulcan SPI controller
Date: Mon,  8 Aug 2016 17:48:27 +0530
Message-ID: <1470658708-8203-1-git-send-email-kamlakant.patel@broadcom.com>
Cc: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

Add device HID for SPI controller on Broadcom Vulcan ARM64.
The default frequency for SPI on Vulcan is 133MHz.

Signed-off-by: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
 drivers/acpi/acpi_apd.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 1daf9c4..c80c8f8 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -87,6 +87,11 @@ static struct apd_device_desc xgene_i2c_desc = {
 	.setup = acpi_apd_setup,
 	.fixed_clk_rate = 100000000,
 };
+
+static struct apd_device_desc vulcan_spi_desc = {
+	.setup = acpi_apd_setup,
+	.fixed_clk_rate = 133000000,
+};
 #endif
 
 #else
@@ -149,6 +154,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
 #endif
 #ifdef CONFIG_ARM64
 	{ "APMC0D0F", APD_ADDR(xgene_i2c_desc) },
+	{ "BRCM900D", APD_ADDR(vulcan_spi_desc) },
 #endif
 	{ }
 };
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
