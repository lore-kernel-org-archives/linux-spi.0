From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: topcliff-pch: Convert to use master->max_speed_hz
Date: Mon, 10 Feb 2014 22:26:40 +0800
Message-ID: <1392042400.9602.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Set "master->max_speed_hz = PCH_MAX_BAUDRATE" then we can remove pch_spi_setup.
In additional, pspi->max_speed_hz will never be 0 because it's default value
will be set to master->max_speed_hz.

Also remove list_empty checking in pch_spi_transfer() because the checking is
done by spi core.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-topcliff-pch.c | 37 +------------------------------------
 1 file changed, 1 insertion(+), 36 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 2e7f38c..6304c91 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -464,20 +464,6 @@ static void pch_spi_reset(struct spi_master *master)
 	pch_spi_writereg(master, PCH_SRST, 0x0);
 }
 
-static int pch_spi_setup(struct spi_device *pspi)
-{
-	/* Check baud rate setting */
-	/* if baud rate of chip is greater than
-	   max we can support,return error */
-	if ((pspi->max_speed_hz) > PCH_MAX_BAUDRATE)
-		pspi->max_speed_hz = PCH_MAX_BAUDRATE;
-
-	dev_dbg(&pspi->dev, "%s MODE = %x\n", __func__,
-		(pspi->mode) & (SPI_CPOL | SPI_CPHA));
-
-	return 0;
-}
-
 static int pch_spi_transfer(struct spi_device *pspi, struct spi_message *pmsg)
 {
 
@@ -486,23 +472,6 @@ static int pch_spi_transfer(struct spi_device *pspi, struct spi_message *pmsg)
 	int retval;
 	unsigned long flags;
 
-	/* validate spi message and baud rate */
-	if (unlikely(list_empty(&pmsg->transfers) == 1)) {
-		dev_err(&pspi->dev, "%s list empty\n", __func__);
-		retval = -EINVAL;
-		goto err_out;
-	}
-
-	if (unlikely(pspi->max_speed_hz == 0)) {
-		dev_err(&pspi->dev, "%s pch_spi_transfer maxspeed=%d\n",
-			__func__, pspi->max_speed_hz);
-		retval = -EINVAL;
-		goto err_out;
-	}
-
-	dev_dbg(&pspi->dev,
-		"%s Transfer List not empty. Transfer Speed is set.\n", __func__);
-
 	spin_lock_irqsave(&data->lock, flags);
 	/* validate Tx/Rx buffers and Transfer length */
 	list_for_each_entry(transfer, &pmsg->transfers, transfer_list) {
@@ -523,10 +492,6 @@ static int pch_spi_transfer(struct spi_device *pspi, struct spi_message *pmsg)
 		dev_dbg(&pspi->dev,
 			"%s Tx/Rx buffer valid. Transfer length valid\n",
 			__func__);
-
-		/* if baud rate has been specified validate the same */
-		if (transfer->speed_hz > PCH_MAX_BAUDRATE)
-			transfer->speed_hz = PCH_MAX_BAUDRATE;
 	}
 	spin_unlock_irqrestore(&data->lock, flags);
 
@@ -1418,10 +1383,10 @@ static int pch_spi_pd_probe(struct platform_device *plat_dev)
 
 	/* initialize members of SPI master */
 	master->num_chipselect = PCH_MAX_CS;
-	master->setup = pch_spi_setup;
 	master->transfer = pch_spi_transfer;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
 	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
+	master->max_speed_hz = PCH_MAX_BAUDRATE;
 
 	data->board_dat = board_dat;
 	data->plat_dev = plat_dev;
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
