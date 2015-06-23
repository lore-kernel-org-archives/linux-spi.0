From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: sh-msiof: Remove obsolete spi_r8a779x_msiof platform_device_id entries
Date: Tue, 23 Jun 2015 15:02:44 +0200
Message-ID: <1435064564-11877-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Since commit a483dcbfa21f919c ("ARM: shmobile: lager: Remove legacy
board support"), R-Car Gen2 SoCs are only supported in generic DT-only
ARM multi-platform builds.  The driver doesn't need to match platform
devices by name anymore, hence remove the corresponding
platform_device_id entry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-msiof.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index d3370a612d8432cf..118c652d88b570a5 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1265,11 +1265,6 @@ static int sh_msiof_spi_remove(struct platform_device *pdev)
 
 static const struct platform_device_id spi_driver_ids[] = {
 	{ "spi_sh_msiof",	(kernel_ulong_t)&sh_data },
-	{ "spi_r8a7790_msiof",	(kernel_ulong_t)&r8a779x_data },
-	{ "spi_r8a7791_msiof",	(kernel_ulong_t)&r8a779x_data },
-	{ "spi_r8a7792_msiof",	(kernel_ulong_t)&r8a779x_data },
-	{ "spi_r8a7793_msiof",	(kernel_ulong_t)&r8a779x_data },
-	{ "spi_r8a7794_msiof",	(kernel_ulong_t)&r8a779x_data },
 	{},
 };
 MODULE_DEVICE_TABLE(platform, spi_driver_ids);
-- 
1.9.1

