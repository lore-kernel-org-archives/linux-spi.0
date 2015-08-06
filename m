From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: img-spfi: fix kbuild test robot warning" to the spi tree
Date: Thu, 06 Aug 2015 12:28:36 +0100
Message-ID: <E1ZNJLg-0001q7-A3@finisterre>
References: <1438853581-17154-1-git-send-email-sifan.naeem@imgtec.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438853581-17154-1-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: img-spfi: fix kbuild test robot warning

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

>From 9176c6657b5c313cf504d157e6d91496ee5c8708 Mon Sep 17 00:00:00 2001
From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Date: Thu, 6 Aug 2015 10:33:01 +0100
Subject: [PATCH] spi: img-spfi: fix kbuild test robot warning

drivers/spi/spi-img-spfi.c: In function 'img_spfi_setup':
drivers/spi/spi-img-spfi.c:446: warning: 'ret' may be used
uninitialized in this function.

Fixes: commit b03ba9e314c1 ("spi: img-spfi: fix multiple calls to request gpio")
Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/spi/spi-img-spfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 1ba9056..61f7748 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -443,7 +443,7 @@ static int img_spfi_unprepare(struct spi_master *master,
 
 static int img_spfi_setup(struct spi_device *spi)
 {
-	int ret;
+	int ret = -EINVAL;
 	struct img_spfi_device_data *spfi_data = spi_get_ctldata(spi);
 
 	if (!spfi_data) {
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
