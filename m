From: Joakim Tjernlund <joakim.tjernlund-27rvihrghlNWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] spi: spi-fsl-spi: Add OF bus-num property
Date: Mon, 19 Dec 2016 13:09:42 +0100
Message-ID: <20161219120942.29022-1-joakim.tjernlund@infinera.com>
Cc: Joakim Tjernlund <joakim.tjernlund-27rvihrghlNWk0Htik3J/w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Allow OF to specify bus enumeration. This uses the same property
as spi-fsl-dspi.

Signed-off-by: Joakim Tjernlund <joakim.tjernlund-27rvihrghlNWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/spi-fsl-lib.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lib.c b/drivers/spi/spi-fsl-lib.c
index cb35d2f..3b06513 100644
--- a/drivers/spi/spi-fsl-lib.c
+++ b/drivers/spi/spi-fsl-lib.c
@@ -140,7 +140,7 @@ int of_mpc8xxx_spi_probe(struct platform_device *ofdev)
 	struct mpc8xxx_spi_probe_info *pinfo;
 	struct fsl_spi_platform_data *pdata;
 	const void *prop;
-	int ret = -ENOMEM;
+	int ret = -ENOMEM, bus_num;
 
 	pinfo = devm_kzalloc(&ofdev->dev, sizeof(*pinfo), GFP_KERNEL);
 	if (!pinfo)
@@ -151,7 +151,9 @@ int of_mpc8xxx_spi_probe(struct platform_device *ofdev)
 
 	/* Allocate bus num dynamically. */
 	pdata->bus_num = -1;
-
+	ret = of_property_read_u32(np, "bus-num", &bus_num);
+	if (ret >= 0)
+		pdata->bus_num = bus_num;
 #ifdef CONFIG_FSL_SOC
 	/* SPI controller is either clocked from QE or SoC clock. */
 	pdata->sysclk = get_brgfreq();
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
