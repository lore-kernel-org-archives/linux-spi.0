From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH for-next] spi: bcm53xx: set of_node to let DT specify device(s)
Date: Thu, 29 Dec 2016 17:27:55 +0100
Message-ID: <20161229162755.9029-1-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Rafał Miłecki <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>

Setting of_node of master's dev seems to be a common way of letting it
work nicely with DT. This allows specifying device there instead of
hardcoding one in the driver code.

This was successfully tested with commit 1b47b98acce2 ("ARM: BCM5301X:
Add DT entry for SPI controller and NOR flash")

Signed-off-by: Rafał Miłecki <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
---
 drivers/spi/spi-bcm53xx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spi-bcm53xx.c b/drivers/spi/spi-bcm53xx.c
index afb5169..0c61ad4 100644
--- a/drivers/spi/spi-bcm53xx.c
+++ b/drivers/spi/spi-bcm53xx.c
@@ -275,10 +275,6 @@ static int bcm53xxspi_flash_read(struct spi_device *spi,
  * BCMA
  **************************************************/
 
-static struct spi_board_info bcm53xx_info = {
-	.modalias	= "bcm53xxspiflash",
-};
-
 static const struct bcma_device_id bcm53xxspi_bcma_tbl[] = {
 	BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_NS_QSPI, BCMA_ANY_REV, BCMA_ANY_CLASS),
 	{},
@@ -311,6 +307,7 @@ static int bcm53xxspi_bcma_probe(struct bcma_device *core)
 	b53spi->bspi = true;
 	bcm53xxspi_disable_bspi(b53spi);
 
+	master->dev.of_node = dev->of_node;
 	master->transfer_one = bcm53xxspi_transfer_one;
 	if (b53spi->mmio_base)
 		master->spi_flash_read = bcm53xxspi_flash_read;
@@ -324,9 +321,6 @@ static int bcm53xxspi_bcma_probe(struct bcma_device *core)
 		return err;
 	}
 
-	/* Broadcom SoCs (at least with the CC rev 42) use SPI for flash only */
-	spi_new_device(master, &bcm53xx_info);
-
 	return 0;
 }
 
-- 
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
