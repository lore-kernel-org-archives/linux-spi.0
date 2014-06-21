From: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: [PATCH] SPI: spi-orion: check return value from
 clk_prepare()/clk_enable()
Date: Sat, 21 Jun 2014 11:32:23 +0100
Message-ID: <E1WyIat-0008KL-Ju@rmk-PC.arm.linux.org.uk>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

clk_prepare()/clk_enable() can fail, and it's return value should
be checked.  Add the proper checking, and while we're here, convert
to clk_prepare_enable().

Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
---
Patch generated against v3.15

 drivers/spi/spi-orion.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index d018a4aac3a1..24844984ef36 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -382,8 +382,10 @@ static int orion_spi_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	clk_prepare(spi->clk);
-	clk_enable(spi->clk);
+	status = clk_prepare_enable(spi->clk);
+	if (status)
+		goto out;
+
 	tclk_hz = clk_get_rate(spi->clk);
 	master->max_speed_hz = DIV_ROUND_UP(tclk_hz, 4);
 	master->min_speed_hz = DIV_ROUND_UP(tclk_hz, 30);
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
