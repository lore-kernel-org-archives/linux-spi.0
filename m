From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: oc-tiny: Remove unneeded NULL checking for
 hw->bitbang.master
Date: Wed, 05 Mar 2014 13:34:21 +0800
Message-ID: <1393997661.19790.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

We already has NULL test for master after calling spi_alloc_master().

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-oc-tiny.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-oc-tiny.c b/drivers/spi/spi-oc-tiny.c
index 022774e..8998d11 100644
--- a/drivers/spi/spi-oc-tiny.c
+++ b/drivers/spi/spi-oc-tiny.c
@@ -266,8 +266,6 @@ static int tiny_spi_probe(struct platform_device *pdev)
 
 	/* setup the state for the bitbang driver */
 	hw->bitbang.master = master;
-	if (!hw->bitbang.master)
-		return err;
 	hw->bitbang.setup_transfer = tiny_spi_setup_transfer;
 	hw->bitbang.chipselect = tiny_spi_chipselect;
 	hw->bitbang.txrx_bufs = tiny_spi_txrx_bufs;
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
