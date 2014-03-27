From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [-next PATCH] spi: omap-uwire: add missing iounmap
Date: Thu, 27 Mar 2014 11:07:59 -0500
Message-ID: <1395936479-26069-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This fixes the following coccicheck warning:
linux-2.6/drivers/spi/spi-omap-uwire.c:485:2-8: ERROR: missing iounmap; ioremap on line 471 and execution via conditional on line 481

Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
---
based on: next-20140326 tag

 drivers/spi/spi-omap-uwire.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index 95cc694..e47c9c6 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -482,6 +482,7 @@ static int uwire_probe(struct platform_device *pdev)
 		status = PTR_ERR(uwire->ck);
 		dev_dbg(&pdev->dev, "no functional clock?\n");
 		spi_master_put(master);
+		iounmap(uwire_base);
 		return status;
 	}
 	clk_enable(uwire->ck);
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
