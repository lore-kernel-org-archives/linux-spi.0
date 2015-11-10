From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Add missing kerneldoc description for parameter" to the spi tree
Date: Tue, 10 Nov 2015 18:53:43 +0000
Message-ID: <E1ZwE35-0001lP-Bd@debutante>
References: <1447156984-22000-1-git-send-email-thierry.reding@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1447156984-22000-1-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Add missing kerneldoc description for parameter

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

>From 88c9321d1ddb9c9539f1ef5da86a35604eb153d5 Mon Sep 17 00:00:00 2001
From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Date: Tue, 10 Nov 2015 13:03:04 +0100
Subject: [PATCH] spi: Add missing kerneldoc description for parameter

Commit ca5d24854210 ("spi: Add THIS_MODULE to spi_driver in SPI core")
adds the new __spi_register_driver() function, but keeps the kerneldoc
for the spi_register_driver() function in place and forgets to add the
description for the new owner parameter.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e2415be209d5..20ef4693d48f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -376,6 +376,7 @@ static void spi_drv_shutdown(struct device *dev)
 
 /**
  * __spi_register_driver - register a SPI driver
+ * @owner: owner module of the driver to register
  * @sdrv: the driver to register
  * Context: can sleep
  *
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
