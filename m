From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] spi: rspi: Remove obsolete qspi platform_device_id entry
Date: Tue, 23 Jun 2015 15:02:07 +0200
Message-ID: <1435064527-11786-2-git-send-email-geert+renesas@glider.be>
References: <1435064527-11786-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1435064527-11786-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Since commit a483dcbfa21f919c ("ARM: shmobile: lager: Remove legacy
board support"), R-Car Gen2 SoCs are only supported in generic DT-only
ARM multi-platform builds.  The driver doesn't need to match platform
devices by name anymore, hence remove the corresponding
platform_device_id entry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 56216b205e0f2c34..3e82b84c9ed48b2f 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1295,7 +1295,6 @@ error1:
 
 static const struct platform_device_id spi_driver_ids[] = {
 	{ "rspi",	(kernel_ulong_t)&rspi_ops },
-	{ "qspi",	(kernel_ulong_t)&qspi_ops },
 	{},
 };
 
-- 
1.9.1

