From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi: fix parent-device reference leak
Date: Mon, 14 Dec 2015 16:16:19 +0100
Message-ID: <1450106179-27623-1-git-send-email-johan@kernel.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Fix parent-device reference leak due to SPI-core taking an unnecessary
reference to the parent when allocating the master structure, a
reference that was never released.

Note that driver core takes its own reference to the parent when the
master device is registered.

Fixes: 49dce689ad4e ("spi doesn't need class_device")
Cc: stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>	# v2.6.24
Signed-off-by: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2b0a8ec3affb..dee1cb87d24f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1705,7 +1705,7 @@ struct spi_master *spi_alloc_master(struct device *dev, unsigned size)
 	master->bus_num = -1;
 	master->num_chipselect = 1;
 	master->dev.class = &spi_master_class;
-	master->dev.parent = get_device(dev);
+	master->dev.parent = dev;
 	spi_master_set_devdata(master, &master[1]);
 
 	return master;
-- 
2.4.10

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
