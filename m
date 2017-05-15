From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spidev: use memdup_user" to the spi tree
Date: Mon, 15 May 2017 09:05:02 +0100
Message-ID: <E1dAB02-0002iT-L8@finisterre>
References: <1028812604e64cd8e1ca2e25b119200fdbec2049.1493781496.git.geliangtang@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Geliang Tang <geliangtang@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1028812604e64cd8e1ca2e25b119200fdbec2049.1493781496.git.geliangtang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spidev: use memdup_user

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

>From f7929436a286ca31f0365a7013de968017f76818 Mon Sep 17 00:00:00 2001
From: Geliang Tang <geliangtang@gmail.com>
Date: Sat, 6 May 2017 23:42:17 +0800
Subject: [PATCH] spi: spidev: use memdup_user

Use memdup_user() helper instead of open-coding to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spidev.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 3b570018705c..d4d2d8d9f3e7 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -324,7 +324,6 @@ static struct spi_ioc_transfer *
 spidev_get_ioc_message(unsigned int cmd, struct spi_ioc_transfer __user *u_ioc,
 		unsigned *n_ioc)
 {
-	struct spi_ioc_transfer	*ioc;
 	u32	tmp;
 
 	/* Check type, command number and direction */
@@ -341,14 +340,7 @@ spidev_get_ioc_message(unsigned int cmd, struct spi_ioc_transfer __user *u_ioc,
 		return NULL;
 
 	/* copy into scratch area */
-	ioc = kmalloc(tmp, GFP_KERNEL);
-	if (!ioc)
-		return ERR_PTR(-ENOMEM);
-	if (__copy_from_user(ioc, u_ioc, tmp)) {
-		kfree(ioc);
-		return ERR_PTR(-EFAULT);
-	}
-	return ioc;
+	return memdup_user(u_ioc, tmp);
 }
 
 static long
-- 
2.11.0
