From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH] spi: imx: Gracefully handle NULL master->cs_gpios
Date: Mon, 26 Sep 2016 14:14:53 +0200
Message-ID: <20160926121453.8380-1-marex@denx.de>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Martin Kaiser <martin-XxZfDwE/svGeZLLa646FqQ@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

It is possible that master->cs_gpios is NULL after spi_bitbang_start(),
this happens if the master has no CS GPIOs specified in DT. Check for
this case after spi_bitbang_start() to prevent NULL pointer dereference
in the subsequent for loop, which accesses the master->cs_gpios field.

Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Martin Kaiser <martin-XxZfDwE/svGeZLLa646FqQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-imx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 53e7a32..1ef5429 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1268,6 +1268,11 @@ static int spi_imx_probe(struct platform_device *pdev)
 		goto out_clk_put;
 	}
 
+	if (!master->cs_gpios) {
+		dev_err(&pdev->dev, "No CS GPIOs available\n");
+		goto out_clk_put;
+	}
+
 	for (i = 0; i < master->num_chipselect; i++) {
 		if (!gpio_is_valid(master->cs_gpios[i]))
 			continue;
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
