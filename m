From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH] spi: xilinx: Use pdev->id instead of pdev->dev.id for the SPI bus number
Date: Thu, 10 Jul 2014 10:30:20 +0200
Message-ID: <1404981020-22640-1-git-send-email-lars@metafoo.de>
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The Xilinx SPI driver initializes the bus_num field of the SPI master to
pdev->dev.id. pdev->dev.id is always 0 for platform devices which causes bus
number conflicts for the SPI controller when creating multiple device instances
of the driver. Instead use pdev->id which will have the assignt platform device
id. If the device is instantiated via devicetree pdev->id is -1 which will cause
the SPI core to dynamically assign a id (or use the id defined via a alias in
the devicetree).

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 drivers/spi/spi-xilinx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index a3b0b99..4d8efb1 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -369,7 +369,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 		goto put_master;
 	}
 
-	master->bus_num = pdev->dev.id;
+	master->bus_num = pdev->id;
 	master->num_chipselect = num_cs;
 	master->dev.of_node = pdev->dev.of_node;
 
-- 
1.8.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
