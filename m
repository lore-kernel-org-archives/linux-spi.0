From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: sh-sci: Prevent NULL pointer dereference
Date: Thu, 13 Mar 2014 10:32:37 +0800
Message-ID: <1394677957.15733.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

If sp->info is NULL, we will hit NULL pointer dereference in probe() while
setting bus_num and num_chipselect for master:

        sp->bitbang.master->bus_num = sp->info->bus_num;
        sp->bitbang.master->num_chipselect = sp->info->num_chipselect;

Thus add NULL test for sp->info in probe() to prevent NULL pointer dereference.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-sh-sci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-sci.c b/drivers/spi/spi-sh-sci.c
index 85c2efd..8b44b71 100644
--- a/drivers/spi/spi-sh-sci.c
+++ b/drivers/spi/spi-sh-sci.c
@@ -108,7 +108,7 @@ static void sh_sci_spi_chipselect(struct spi_device *dev, int value)
 {
 	struct sh_sci_spi *sp = spi_master_get_devdata(dev->master);
 
-	if (sp->info && sp->info->chip_select)
+	if (sp->info->chip_select)
 		(sp->info->chip_select)(sp->info, dev->chip_select, value);
 }
 
@@ -130,6 +130,11 @@ static int sh_sci_spi_probe(struct platform_device *dev)
 
 	platform_set_drvdata(dev, sp);
 	sp->info = dev_get_platdata(&dev->dev);
+	if (!sp->info) {
+		dev_err(&dev->dev, "platform data is missing\n");
+		ret = -ENOENT;
+		goto err1;
+	}
 
 	/* setup spi bitbang adaptor */
 	sp->bitbang.master = master;
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
