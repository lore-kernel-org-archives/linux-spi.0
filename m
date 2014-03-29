From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: omap-100k: Fix memory leak
Date: Sat, 29 Mar 2014 15:03:37 +0800
Message-ID: <1396076617.1937.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Fabrice Crohas <fcrohas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The memory allocated for cs is not freed anywhere.
Convert to use devm_kzalloc to fix the memory leak.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-omap-100k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index c9e2282..e7ffcde 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -283,7 +283,7 @@ static int omap1_spi100k_setup(struct spi_device *spi)
 	spi100k = spi_master_get_devdata(spi->master);
 
 	if (!cs) {
-		cs = kzalloc(sizeof(*cs), GFP_KERNEL);
+		cs = devm_kzalloc(&spi->dev, sizeof(*cs), GFP_KERNEL);
 		if (!cs)
 			return -ENOMEM;
 		cs->base = spi100k->base + spi->chip_select * 0x14;
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
