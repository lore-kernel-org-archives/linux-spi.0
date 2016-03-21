From: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] spi: fsl-dspi: Set max_speed_hz for master
Date: Tue, 22 Mar 2016 01:41:52 +0530
Message-ID: <1458591112-2743-1-git-send-email-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <stefan-XLVq0VzYD2Y@public.gmane.org>, <haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, <han.xu-3arQi8VN3Tc@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Calculate and update max speed from bus clock for SoC's
using DSPI IP.

The bus clock factor's are taken from the data sheet's
of respective SoC's.

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 59a1143..8753276 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -121,18 +121,22 @@ enum dspi_trans_mode {
 
 struct fsl_dspi_devtype_data {
 	enum dspi_trans_mode trans_mode;
+	u8 max_clock_factor;
 };
 
 static const struct fsl_dspi_devtype_data vf610_data = {
 	.trans_mode = DSPI_EOQ_MODE,
+	.max_clock_factor = 2,
 };
 
 static const struct fsl_dspi_devtype_data ls1021a_v1_data = {
 	.trans_mode = DSPI_TCFQ_MODE,
+	.max_clock_factor = 8,
 };
 
 static const struct fsl_dspi_devtype_data ls2085a_data = {
 	.trans_mode = DSPI_TCFQ_MODE,
+	.max_clock_factor = 8,
 };
 
 struct fsl_dspi {
@@ -726,6 +730,9 @@ static int dspi_probe(struct platform_device *pdev)
 	}
 	clk_prepare_enable(dspi->clk);
 
+	master->max_speed_hz =
+		clk_get_rate(dspi->clk) / dspi->devtype_data->max_clock_factor;
+
 	init_waitqueue_head(&dspi->waitq);
 	platform_set_drvdata(pdev, master);
 
-- 
2.7.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
