From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: [PATCH 1/6] spi: bcm2835: remove dependency on handle_err which is
Date: Sun, 29 Mar 2015 16:03:22 +0200
Message-ID: <72441EEF-C509-433B-9DBA-53A936ED5BDB@martin.sperl.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

 in spi-for-next

Remove the implementation of handle_err, the function of which was introduced to
spi-for-next with patch b716c4ff 

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Tested-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c |    7 -------
 1 file changed, 7 deletions(-)

Applies against spi - topic/bcm2835

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 0dbe544..552a633 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -216,12 +216,6 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 	return 1;
 }
 
-static void bcm2835_spi_handle_err(struct spi_master *master,
-				   struct spi_message *msg)
-{
-	bcm2835_spi_reset_hw(master);
-}
-
 static void bcm2835_spi_set_cs(struct spi_device *spi, bool gpio_level)
 {
 	/*
@@ -315,7 +309,6 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	master->setup = bcm2835_spi_setup;
 	master->set_cs = bcm2835_spi_set_cs;
 	master->transfer_one = bcm2835_spi_transfer_one;
-	master->handle_err = bcm2835_spi_handle_err;
 	master->dev.of_node = pdev->dev.of_node;
 
 	bs = spi_master_get_devdata(master);
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
