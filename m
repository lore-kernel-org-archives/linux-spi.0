From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] spi: fsl-espi: make use of max_msg_size in spi_master to
 handle HW restrictions
Date: Tue, 1 Dec 2015 19:56:35 +0100
Message-ID: <565DED63.4000702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Propagate the 64K message size limitation allowing client drivers
to deal properly with this limitation.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index c27124a..773bbab 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -670,6 +670,7 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 	master->cleanup = fsl_espi_cleanup;
 	master->transfer_one_message = fsl_espi_do_one_msg;
 	master->auto_runtime_pm = true;
+	master->max_msg_size = SPCOM_TRANLEN_MAX;
 
 	mpc8xxx_spi = spi_master_get_devdata(master);
 
-- 
2.6.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
