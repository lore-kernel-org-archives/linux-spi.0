From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: core: Replace S_IRUGO permissions by 0444" to the spi tree
Date: Mon, 15 May 2017 17:04:51 +0900
Message-ID: <E1dAAzr-0002gb-G6@finisterre>
References: <1493908196-13001-1-git-send-email-geert+renesas@glider.be>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1493908196-13001-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: core: Replace S_IRUGO permissions by 0444

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

>From ad25c92ecb160235668cdeaff26f5907a6fbf6b3 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Date: Thu, 4 May 2017 16:29:56 +0200
Subject: [PATCH] spi: core: Replace S_IRUGO permissions by 0444

Octal permissions are preferred over symbolic permissions.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 89254a55eb2e..bd7a546f5d9b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -80,7 +80,7 @@ static ssize_t spi_master_##field##_show(struct device *dev,		\
 	return spi_statistics_##field##_show(&master->statistics, buf);	\
 }									\
 static struct device_attribute dev_attr_spi_master_##field = {		\
-	.attr = { .name = file, .mode = S_IRUGO },			\
+	.attr = { .name = file, .mode = 0444 },				\
 	.show = spi_master_##field##_show,				\
 };									\
 static ssize_t spi_device_##field##_show(struct device *dev,		\
@@ -91,7 +91,7 @@ static ssize_t spi_device_##field##_show(struct device *dev,		\
 	return spi_statistics_##field##_show(&spi->statistics, buf);	\
 }									\
 static struct device_attribute dev_attr_spi_device_##field = {		\
-	.attr = { .name = file, .mode = S_IRUGO },			\
+	.attr = { .name = file, .mode = 0444 },				\
 	.show = spi_device_##field##_show,				\
 }
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
