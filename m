From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 4/5] spi: img-spfi: Setup TRANSACTION register before CONTROL register
Date: Mon,  6 Apr 2015 14:29:06 -0700
Message-ID: <1428355747-16822-4-git-send-email-abrestic@chromium.org>
References: <1428355747-16822-1-git-send-email-abrestic@chromium.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>,
	Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1428355747-16822-1-git-send-email-abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

Setting the transfer length in the TRANSACTION register after the
CONTROL register is programmed causes intermittent timeout issues in
SPFI transfers when using the SPI framework to control the CS GPIO
lines.  To avoid this issue, set transfer length before programming
the CONTROL register.

Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/spi/spi-img-spfi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 30c89f9..adeaa2f 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -458,6 +458,9 @@ static void img_spfi_config(struct spi_master *master, struct spi_device *spi,
 	val |= div << SPFI_DEVICE_PARAMETER_BITCLK_SHIFT;
 	spfi_writel(spfi, val, SPFI_DEVICE_PARAMETER(spi->chip_select));
 
+	spfi_writel(spfi, xfer->len << SPFI_TRANSACTION_TSIZE_SHIFT,
+		    SPFI_TRANSACTION);
+
 	val = spfi_readl(spfi, SPFI_CONTROL);
 	val &= ~(SPFI_CONTROL_SEND_DMA | SPFI_CONTROL_GET_DMA);
 	if (xfer->tx_buf)
@@ -476,8 +479,6 @@ static void img_spfi_config(struct spi_master *master, struct spi_device *spi,
 					      &master->cur_msg->transfers))
 		val |= SPFI_CONTROL_CONTINUE;
 	spfi_writel(spfi, val, SPFI_CONTROL);
-	spfi_writel(spfi, xfer->len << SPFI_TRANSACTION_TSIZE_SHIFT,
-		    SPFI_TRANSACTION);
 }
 
 static int img_spfi_transfer_one(struct spi_master *master,
-- 
2.2.0.rc0.207.ga3a616c

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
