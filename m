From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-dspi: Set max_speed_hz for master" to the spi tree
Date: Wed, 23 Mar 2016 13:55:17 +0000
Message-ID: <E1aijFl-0004hj-HJ@debutante>
References: <1458591112-2743-1-git-send-email-bhuvanchandra.dv@toradex.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>,
	Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458591112-2743-1-git-send-email-bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-dspi: Set max_speed_hz for master

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 9419b2006cf47c75985ea51d36ddc51346d29efd Mon Sep 17 00:00:00 2001
From: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Date: Tue, 22 Mar 2016 01:41:52 +0530
Subject: [PATCH] spi: fsl-dspi: Set max_speed_hz for master

Calculate and update max speed from bus clock for SoCs
using DSPI IP.

The bus clock factor's are taken from the data sheets
of respective SoCs.

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Acked-by: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 39412c9097c6..559ed70fd229 100644
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
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
