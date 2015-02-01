From: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Subject: [PATCH] spi: atmel: cleanup wait_for_completion return handling
Date: Sun,  1 Feb 2015 06:42:11 -0500
Message-ID: <1422790931-4794-1-git-send-email-hofrat@osadl.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

return type of wait_for_completion_timeout is unsigned long not int, this
patch adds an appropriate variable and fixes up the assignment.
Further it removes the else branch as the only thing it was
doing is assigning ret to 0 - but ret is never used thereafter so that
is not needed. As the string in dev_err already states "timeout" there
is little point in printing the 0 here.

directly rather than adding a additional appropriately typed variable.

Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
---

This patch was only compile tested with at91_dt_defconfig
(implies CONFIG_SPI_ATMEL=y)

Patch is against 3.19.0-rc6 -next-20150130

 drivers/spi/spi-atmel.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 23d8f5f5..fd6744c 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1046,6 +1046,7 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 	struct atmel_spi_device	*asd;
 	int			timeout;
 	int			ret;
+	unsigned long		dma_timeout;
 
 	as = spi_master_get_devdata(master);
 
@@ -1103,16 +1104,14 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 
 		/* interrupts are disabled, so free the lock for schedule */
 		atmel_spi_unlock(as);
-		ret = wait_for_completion_timeout(&as->xfer_completion,
+		dma_timeout = wait_for_completion_timeout(&as->xfer_completion,
 							SPI_DMA_TIMEOUT);
 		atmel_spi_lock(as);
-		if (WARN_ON(ret == 0)) {
+		if (WARN_ON(dma_timeout == 0)) {
 			dev_err(&spi->dev,
-				"spi trasfer timeout, err %d\n", ret);
+				"spi trasfer timeout\n");
 			as->done_status = -EIO;
-		} else {
-			ret = 0;
-		}
+		}
 
 		if (as->done_status)
 			break;
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
