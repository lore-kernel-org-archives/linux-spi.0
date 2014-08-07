From: Nick Krause <xerofoiify-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: Initialize variable to prevent uninitialized warning
Date: Thu,  7 Aug 2014 06:51:00 +0200
Message-ID: <1407387060-28992-1-git-send-email-xerofoiify@gmail.com>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list:SPI SUBSYSTEM),
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list)
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

While compiling we see the following waring

drivers/spi/spi-bfin5xx.c: In function 'bfin_spi_pump_transfers':
drivers/spi/spi-bfin5xx.c:695:6: warning: 'cr_width' may be used uninitialized
in this function [-Wuninitialized]

Initialize it to prevent the above warning

Signed-off-by: Nick Krause <xerofoify-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-bfin5xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bfin5xx.c b/drivers/spi/spi-bfin5xx.c
index ebf720b..f268bf4 100644
--- a/drivers/spi/spi-bfin5xx.c
+++ b/drivers/spi/spi-bfin5xx.c
@@ -559,7 +559,7 @@ static void bfin_spi_pump_transfers(unsigned long data)
 	struct spi_transfer *previous = NULL;
 	struct bfin_spi_slave_data *chip = NULL;
 	unsigned int bits_per_word;
-	u16 cr, cr_width, dma_width, dma_config;
+	u16 cr, cr_width = 0, dma_width, dma_config;
 	u32 tranf_success = 1;
 	u8 full_duplex = 0;
 
@@ -648,7 +648,6 @@ static void bfin_spi_pump_transfers(unsigned long data)
 	} else if (bits_per_word == 8) {
 		drv_data->n_bytes = bits_per_word/8;
 		drv_data->len = transfer->len;
-		cr_width = 0;
 		drv_data->ops = &bfin_bfin_spi_transfer_ops_u8;
 	}
 	cr = bfin_read(&drv_data->regs->ctl) & ~(BIT_CTL_TIMOD | BIT_CTL_WORDSIZE);
-- 
2.0.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
