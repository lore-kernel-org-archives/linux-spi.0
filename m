From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: dw: eliminate speed variable in ->transfer_one()" to the spi tree
Date: Mon, 19 Oct 2015 20:43:28 +0100
Message-ID: <E1ZoGLA-0002LH-Qd@debutante>
References: <1444853545-59868-7-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444853545-59868-7-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: dw: eliminate speed variable in ->transfer_one()

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

>From de6feda884b0079f5f232a41d94da23d198ff230 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Wed, 14 Oct 2015 23:12:21 +0300
Subject: [PATCH] spi: dw: eliminate speed variable in ->transfer_one()

There is no point to have a separate variable for speed in ->transfer_one().

While here, remove !chip->clk_div from a condition since it is assigned
simultaneously with chip->speed_hz. We can do this safely because
 a) transfer speed can't be higher than max_freq and therefore chip->clk_div
    can be 0 only when chip->speed_hz is 0, and
 b) transfer speed can't be 0, otherwise we will get division by zero
    exception.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-dw.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index c8f7f161213d..a6fd7cfa1b40 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -285,8 +285,7 @@ static int dw_spi_transfer_one(struct spi_master *master,
 	struct chip_data *chip = spi_get_ctldata(spi);
 	u8 imask = 0;
 	u16 txlevel = 0;
-	u16 clk_div = 0;
-	u32 speed = 0;
+	u16 clk_div;
 	u32 cr0;
 	int ret;
 
@@ -301,14 +300,11 @@ static int dw_spi_transfer_one(struct spi_master *master,
 	spi_enable_chip(dws, 0);
 
 	/* Handle per transfer options for bpw and speed */
-	speed = chip->speed_hz;
-	if ((transfer->speed_hz != speed) || !chip->clk_div) {
-		speed = transfer->speed_hz;
-
+	if (transfer->speed_hz != chip->speed_hz) {
 		/* clk_div doesn't support odd number */
-		clk_div = (dws->max_freq / speed + 1) & 0xfffe;
+		clk_div = (dws->max_freq / transfer->speed_hz + 1) & 0xfffe;
 
-		chip->speed_hz = speed;
+		chip->speed_hz = transfer->speed_hz;
 		chip->clk_div = clk_div;
 
 		spi_set_clk(dws, chip->clk_div);
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
