From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] spi: rspi: Remove obsolete rspi-rz platform_device_id entry
Date: Tue, 23 Jun 2015 15:02:06 +0200
Message-ID: <1435064527-11786-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Since commit 05104c266ae9a167 ("ARM: shmobile: r7s72100: genmai: Remove
legacy board file"), r7s72100 is only supported in generic DT-only ARM
multi-platform builds.  The driver doesn't need to match platform
devices by name anymore, hence remove the corresponding
platform_device_id entry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index f9189a0c8cec81f2..56216b205e0f2c34 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1295,7 +1295,6 @@ error1:
 
 static const struct platform_device_id spi_driver_ids[] = {
 	{ "rspi",	(kernel_ulong_t)&rspi_ops },
-	{ "rspi-rz",	(kernel_ulong_t)&rspi_rz_ops },
 	{ "qspi",	(kernel_ulong_t)&qspi_ops },
 	{},
 };
-- 
1.9.1

