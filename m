From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: spidev: Fix typo
Date: Wed, 15 Jul 2015 14:22:33 -0300
Message-ID: <1436980953-14741-1-git-send-email-festevam@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Fix the typo in "compatible".

Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/spi/spidev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index c7de641..a902cc2 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -709,7 +709,7 @@ static int spidev_probe(struct spi_device *spi)
 
 	/*
 	 * spidev should never be referenced in DT without a specific
-	 * compatbile string, it is a Linux implementation thing
+	 * compatible string, it is a Linux implementation thing
 	 * rather than a description of the hardware.
 	 */
 	if (spi->dev.of_node && !of_match_device(spidev_dt_ids, &spi->dev)) {
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
