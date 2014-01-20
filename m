From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: nuc900: Set SPI_LSB_FIRST for master->mode_bits if
 hw->pdata->lsb is true
Date: Mon, 20 Jan 2014 23:22:07 +0800
Message-ID: <1390231327.11756.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Otherwise, spi_setup() fails with unsupported mode bits message.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-nuc900.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-nuc900.c b/drivers/spi/spi-nuc900.c
index 5040630..bae97ff 100644
--- a/drivers/spi/spi-nuc900.c
+++ b/drivers/spi/spi-nuc900.c
@@ -361,6 +361,8 @@ static int nuc900_spi_probe(struct platform_device *pdev)
 	init_completion(&hw->done);
 
 	master->mode_bits          = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	if (hw->pdata->lsb)
+		master->mode_bits |= SPI_LSB_FIRST;
 	master->num_chipselect     = hw->pdata->num_cs;
 	master->bus_num            = hw->pdata->bus_num;
 	hw->bitbang.master         = hw->master;
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
