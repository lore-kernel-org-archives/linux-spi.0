From: Jorge Ventura <jorge.araujo.ventura-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/1] spi: Fix the spi task hangs waiting dma_rx
Date: Sat,  9 Aug 2014 16:06:58 -0500
Message-ID: <1407618418-5427-1-git-send-email-jorge.araujo.ventura@gmail.com>
Cc: "Jorge A. Ventura" <jorge.araujo.ventura-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: "Jorge A. Ventura" <jorge.araujo.ventura-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

The spi hangs waiting the completion of omap2_mcspi_rx_callback.

Signed-off-by: Jorge A. Ventura <jorge.araujo.ventura-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 68441fa..352eed7 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -329,7 +329,8 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
 disable_fifo:
 	if (t->rx_buf != NULL)
 		chconf &= ~OMAP2_MCSPI_CHCONF_FFER;
-	else
+
+	if (t->tx_buf != NULL)
 		chconf &= ~OMAP2_MCSPI_CHCONF_FFET;
 
 	mcspi_write_chconf0(spi, chconf);
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
