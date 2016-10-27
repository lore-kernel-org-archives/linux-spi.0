From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: fsl-espi: avoid processing uninitalized data on error
Date: Thu, 27 Oct 2016 07:55:30 +0200
Message-ID: <b5d3b5f3-034e-28c4-e616-69de4bf7cb8f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

When we get a spurious interrupt in fsl_espi_irq, we end up
processing four uninitalized bytes of data, as shown in this
warning message:

   drivers/spi/spi-fsl-espi.c: In function 'fsl_espi_irq':
   drivers/spi/spi-fsl-espi.c:462:4: warning: 'rx_data' may be used uninitialized in this function [-Wmaybe-uninitialized]

This adds another check so we skip the data in this case.

A functionally identical patch was submitted for stable
already, however due to a merge conflict a separate patch
is needed for next.

Fixes: 6319a68011b8 ("spi/fsl-espi: avoid infinite loops on fsl_espi_cpu_irq()")
Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index eea5123..4e8a99d 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -455,7 +455,7 @@ static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 
 		mspi->len -= rx_nr_bytes;
 
-		if (mspi->rx) {
+		if (rx_nr_bytes && mspi->rx) {
 			*(u32 *)mspi->rx = rx_data;
 			mspi->rx += 4;
 		}
-- 
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
