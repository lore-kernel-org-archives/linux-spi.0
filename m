From: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Subject: [PATCH v2] spi: atmel: cleanup wait_for_completion return handling
Date: Mon,  2 Feb 2015 10:43:31 -0500
Message-ID: <1422891811-28541-1-git-send-email-hofrat@osadl.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

return type of wait_for_completion_timeout is unsigned long not int, this
patch adds an appropriate variable and fixes up the assignment. It removes 
the else branch as the only thing it was doing is assigning ret = 0; - but 
ret is never used thereafter so that is not needed. As the string in 
dev_err already states "timeout" there is little point in printing the 0. 
A typo in "trasfer" -> transfer is also fixed.

Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
---

v2: fixes commit message and whitespace damage reported by
    Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

This patch was only compile tested with at91_dt_defconfig
(implies CONFIG_SPI_ATMEL=y)

Patch is against 3.19.0-rc6 (localversion-next = -next-20150202)

 drivers/spi/spi-atmel.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 23d8f5f5..9af7841 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1046,6 +1046,7 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 	struct atmel_spi_device	*asd;
 	int			timeout;
 	int			ret;
+	unsigned long		dma_timeout;
 
 	as = spi_master_get_devdata(master);
 
@@ -1103,15 +1104,12 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 
 		/* interrupts are disabled, so free the lock for schedule */
 		atmel_spi_unlock(as);
-		ret = wait_for_completion_timeout(&as->xfer_completion,
-							SPI_DMA_TIMEOUT);
+		dma_timeout = wait_for_completion_timeout(&as->xfer_completion,
+							  SPI_DMA_TIMEOUT);
 		atmel_spi_lock(as);
-		if (WARN_ON(ret == 0)) {
-			dev_err(&spi->dev,
-				"spi trasfer timeout, err %d\n", ret);
+		if (WARN_ON(dma_timeout == 0)) {
+			dev_err(&spi->dev, "spi transfer timeout\n");
 			as->done_status = -EIO;
-		} else {
-			ret = 0;
 		}
 
 		if (as->done_status)
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
