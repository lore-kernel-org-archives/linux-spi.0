From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: lm70llp: use dev_warn" to the spi tree
Date: Mon, 07 Dec 2015 20:09:31 +0000
Message-ID: <E1a626F-0004Vu-Rg@debutante>
References: <1449485255-1103-7-git-send-email-sudipm.mukherjee@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudip Mukherjee <sudip-ofJRbWXBVFamYgehrs7/Lw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449485255-1103-7-git-send-email-sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: lm70llp: use dev_warn

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

>From 46c52c28deb38df19b1284468792fb59e6a6c27b Mon Sep 17 00:00:00 2001
From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Mon, 7 Dec 2015 16:17:34 +0530
Subject: [PATCH] spi: lm70llp: use dev_warn

As we have a struct device available it is better to use dev_warn()
instead of printk.

Signed-off-by: Sudip Mukherjee <sudip-ofJRbWXBVFamYgehrs7/Lw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-lm70llp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-lm70llp.c b/drivers/spi/spi-lm70llp.c
index ef829081abd7..cb2284475385 100644
--- a/drivers/spi/spi-lm70llp.c
+++ b/drivers/spi/spi-lm70llp.c
@@ -249,9 +249,8 @@ static void spi_lm70llp_attach(struct parport *p)
 	 */
 	status = spi_bitbang_start(&pp->bitbang);
 	if (status < 0) {
-		printk(KERN_WARNING
-			"%s: spi_bitbang_start failed with status %d\n",
-			DRVNAME, status);
+		dev_warn(&pd->dev, "spi_bitbang_start failed with status %d\n",
+			 status);
 		goto out_off_and_release;
 	}
 
@@ -278,7 +277,7 @@ static void spi_lm70llp_attach(struct parport *p)
 		dev_dbg(&pp->spidev_lm70->dev, "spidev_lm70 at %s\n",
 			dev_name(&pp->spidev_lm70->dev));
 	else {
-		printk(KERN_WARNING "%s: spi_new_device failed\n", DRVNAME);
+		dev_warn(&pd->dev, "spi_new_device failed\n");
 		status = -ENODEV;
 		goto out_bitbang_stop;
 	}
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
