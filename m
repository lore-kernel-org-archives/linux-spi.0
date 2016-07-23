From: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Subject: [PATCH] spi: pic32: fixup wait_for_completion_timeout return handling
Date: Sat, 23 Jul 2016 21:31:20 +0200
Message-ID: <1469302280-32461-1-git-send-email-hofrat@osadl.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

wait_for_completion_timeout returns unsigned long not int so the check for
<= 0 should be == 0 here.

Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
---

API non-compliance was located by coccinelle

Compile tested with: pic32mzda_defconfig + CONFIG_SPI=y,
CONFIG_SPI_PIC32=m

Patch is against 4.7.0-rc7 (localversion-next -next-20160719)

 drivers/spi/spi-pic32.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 73db87f..fefb688 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -507,6 +507,7 @@ static int pic32_spi_one_transfer(struct spi_master *master,
 {
 	struct pic32_spi *pic32s;
 	bool dma_issued = false;
+	unsigned long timeout;
 	int ret;
 
 	pic32s = spi_master_get_devdata(master);
@@ -553,8 +554,8 @@ static int pic32_spi_one_transfer(struct spi_master *master,
 	}
 
 	/* wait for completion */
-	ret = wait_for_completion_timeout(&pic32s->xfer_done, 2 * HZ);
-	if (ret <= 0) {
+	timeout = wait_for_completion_timeout(&pic32s->xfer_done, 2 * HZ);
+	if (timeout == 0) {
 		dev_err(&spi->dev, "wait error/timedout\n");
 		if (dma_issued) {
 			dmaengine_terminate_all(master->dma_rx);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
