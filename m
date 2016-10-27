From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 07/09] spi: fsl-espi: extend and improve transfer error
 handling
Date: Thu, 27 Oct 2016 21:28:02 +0200
Message-ID: <688b735d-1757-fedc-2ba1-6f1db4f63b6a@gmail.com>
References: <5b98be38-17a2-79a2-14da-fb2bb6f8820f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5b98be38-17a2-79a2-14da-fb2bb6f8820f-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Extend and improve transfer error handling
- in case of timeout report also number of remaining rx bytes
- in case of timeout return ETIMEDOUT instead of EMSGSIZE
- add sanity checks after all bytes have been sent / read:
 - check that HW has flag SPIE_DON set
 - check that RX / TX FIFO are empty

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2:
- rebased
---
 drivers/spi/spi-fsl-espi.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 06fb185..2f95b19 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -312,13 +312,13 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	ret = wait_for_completion_timeout(&mpc8xxx_spi->done, 2 * HZ);
 	if (ret == 0)
 		dev_err(mpc8xxx_spi->dev,
-			"Transaction hanging up (left %u bytes)\n",
-			mpc8xxx_spi->tx_len);
+			"Transaction hanging up (left %u tx bytes, %u rx bytes)\n",
+			mpc8xxx_spi->tx_len, mpc8xxx_spi->rx_len);
 
 	/* disable rx ints */
 	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPIM, 0);
 
-	return mpc8xxx_spi->tx_len > 0 ? -EMSGSIZE : 0;
+	return ret == 0 ? -ETIMEDOUT : 0;
 }
 
 static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
@@ -447,8 +447,20 @@ static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 	if (mspi->tx_len)
 		fsl_espi_fill_tx_fifo(mspi, events);
 
-	if (!mspi->tx_len && !mspi->rx_len)
-		complete(&mspi->done);
+	if (mspi->tx_len || mspi->rx_len)
+		return;
+
+	/* we're done, but check for errors before returning */
+	events = fsl_espi_read_reg(mspi, ESPI_SPIE);
+
+	if (!(events & SPIE_DON))
+		dev_err(mspi->dev,
+			"Transfer done but SPIE_DON isn't set!\n");
+
+	if (SPIE_RXCNT(events) || SPIE_TXCNT(events) != FSL_ESPI_FIFO_SIZE)
+		dev_err(mspi->dev, "Transfer done but rx/tx fifo's aren't empty!\n");
+
+	complete(&mspi->done);
 }
 
 static irqreturn_t fsl_espi_irq(s32 irq, void *context_data)
-- 
2.10.1


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
