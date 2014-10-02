From: Michael Heimpold <mhei-Z/Lg1yOAjpkb1SvskN2V4Q@public.gmane.org>
Subject: [PATCH] spi: spi-mxs: fix a tiny typo in a comment
Date: Thu,  2 Oct 2014 23:10:22 +0200
Message-ID: <1412284222-5855-1-git-send-email-mhei@heimpold.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michael Heimpold <mhei-Z/Lg1yOAjpkb1SvskN2V4Q@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Michael Heimpold <mhei-Z/Lg1yOAjpkb1SvskN2V4Q@public.gmane.org>
---
 drivers/spi/spi-mxs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 2884f0c..74f2ba0 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -85,7 +85,7 @@ static int mxs_spi_setup_transfer(struct spi_device *dev,
 		mxs_ssp_set_clk_rate(ssp, hz);
 		/*
 		 * Save requested rate, hz, rather than the actual rate,
-		 * ssp->clk_rate.  Otherwise we would set the rate every trasfer
+		 * ssp->clk_rate.  Otherwise we would set the rate every transfer
 		 * when the actual rate is not quite the same as requested rate.
 		 */
 		spi->sck = hz;
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
