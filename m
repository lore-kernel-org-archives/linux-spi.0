From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: dw: Make debugfs name unique between instances" to the spi tree
Date: Wed, 04 Jan 2017 18:37:39 +0000
Message-ID: <E1cOqRP-00026r-Q6@debutante>
References: <1482398292-46946-1-git-send-email-preid@electromag.com.au>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        kernel-NoMTM8u0nx3R7s880joybQ@public.gmane.org, jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1482398292-46946-1-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: dw: Make debugfs name unique between instances

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

>From 13288bdf4adbaa6bd1267f10044c1bc25d90ce7f Mon Sep 17 00:00:00 2001
From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Date: Thu, 22 Dec 2016 17:18:12 +0800
Subject: [PATCH] spi: dw: Make debugfs name unique between instances

Some system have multiple dw devices. Currently the driver uses a
fixed name for the debugfs dir. Append dev name to the debugfs dir
name to make it unique.

Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-dw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index b715a26a9148..054012f87567 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -107,7 +107,10 @@ static const struct file_operations dw_spi_regs_ops = {
 
 static int dw_spi_debugfs_init(struct dw_spi *dws)
 {
-	dws->debugfs = debugfs_create_dir("dw_spi", NULL);
+	char name[128];
+
+	snprintf(name, 128, "dw_spi-%s", dev_name(&dws->master->dev));
+	dws->debugfs = debugfs_create_dir(name, NULL);
 	if (!dws->debugfs)
 		return -ENOMEM;
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
