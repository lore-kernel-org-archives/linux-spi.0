From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: mpc512x-psc: Remove redundant code to get bus_num from
 DT
Date: Sun, 16 Feb 2014 10:43:18 +0800
Message-ID: <1392518598.18192.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>, Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

For DT case, spi core will call of_alias_get_id() and set master->bus_num if it
was not set.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-mpc512x-psc.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 56cead9..3822eef 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -465,10 +465,8 @@ static void mpc512x_spi_cs_control(struct spi_device *spi, bool onoff)
 	gpio_set_value(spi->cs_gpio, onoff);
 }
 
-/* bus_num is used only for the case dev->platform_data == NULL */
 static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
-					      u32 size, unsigned int irq,
-					      s16 bus_num)
+					      u32 size, unsigned int irq)
 {
 	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
 	struct mpc512x_psc_spi *mps;
@@ -487,7 +485,6 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 
 	if (pdata == NULL) {
 		mps->cs_control = mpc512x_spi_cs_control;
-		master->bus_num = bus_num;
 	} else {
 		mps->cs_control = pdata->cs_control;
 		master->bus_num = pdata->bus_num;
@@ -573,7 +570,6 @@ static int mpc512x_psc_spi_of_probe(struct platform_device *op)
 {
 	const u32 *regaddr_p;
 	u64 regaddr64, size64;
-	s16 id = -1;
 
 	regaddr_p = of_get_address(op->dev.of_node, 0, &size64, NULL);
 	if (!regaddr_p) {
@@ -582,16 +578,8 @@ static int mpc512x_psc_spi_of_probe(struct platform_device *op)
 	}
 	regaddr64 = of_translate_address(op->dev.of_node, regaddr_p);
 
-	/* get PSC id (0..11, used by port_config) */
-	id = of_alias_get_id(op->dev.of_node, "spi");
-	if (id < 0) {
-		dev_err(&op->dev, "no alias id for %s\n",
-			op->dev.of_node->full_name);
-		return id;
-	}
-
 	return mpc512x_psc_spi_do_probe(&op->dev, (u32) regaddr64, (u32) size64,
-				irq_of_parse_and_map(op->dev.of_node, 0), id);
+				irq_of_parse_and_map(op->dev.of_node, 0));
 }
 
 static int mpc512x_psc_spi_of_remove(struct platform_device *op)
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
