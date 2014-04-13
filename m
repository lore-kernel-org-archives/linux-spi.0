From: Alexander Stein <alexanders83-S0/GAf8tV78@public.gmane.org>
Subject: [PATCH] spi: atmel: Fix scheduling while atomic bug
Date: Sun, 13 Apr 2014 12:45:10 +0200
Message-ID: <1397385910-28368-1-git-send-email-alexanders83@web.de>
References: <20140411214815.GI28800@sirena.org.uk>
Cc: Alexander Stein <alexanders83-S0/GAf8tV78@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140411214815.GI28800-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

atmel_spi_lock does a spin_lock_irqsave, so we need to renable the
interrupts when we want to schedule.

Signed-off-by: Alexander Stein <alexanders83-S0/GAf8tV78@public.gmane.org>
---
I'm not sure what the lock is actually good for, so I kept it and release
it when we are about to schedule, thus reenabling interrupts.

 drivers/spi/spi-atmel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 5d7b07f..ae22f3d 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1130,8 +1130,11 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 			atmel_spi_next_xfer_pio(master, xfer);
 		}
 
+		/* interrupts are disabled, so free the lock for schedule */
+		atmel_spi_unlock(as);
 		ret = wait_for_completion_timeout(&as->xfer_completion,
 							SPI_DMA_TIMEOUT);
+		atmel_spi_lock(as);
 		if (WARN_ON(ret == 0)) {
 			dev_err(&spi->dev,
 				"spi trasfer timeout, err %d\n", ret);
-- 
1.9.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
