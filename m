From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: loopback: fix typo in MODULE_PARM_DESC" to the spi tree
Date: Fri, 08 Jan 2016 13:44:57 +0000
Message-ID: <E1aHXLd-0003O1-D7@debutante>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: 
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: loopback: fix typo in MODULE_PARM_DESC

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

>From 8caad1da223c361e2804b76d68405b1abe7886ff Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Date: Fri, 8 Jan 2016 13:48:51 +0300
Subject: [PATCH] spi: loopback: fix typo in MODULE_PARM_DESC

There should be an 's' on "dump_message" so it matches the module_param.

Fixes: 84e0c4e5e2c4 ('spi: add loopback test driver to allow for spi_master regression tests')
Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 7f79a77c4b68..894616f687b0 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -37,7 +37,7 @@ MODULE_PARM_DESC(simulate_only, "if not 0 do not execute the spi message");
 /* dump spi messages */
 int dump_messages;
 module_param(dump_messages, int, 0);
-MODULE_PARM_DESC(dump_message,
+MODULE_PARM_DESC(dump_messages,
 		 "=1 dump the basic spi_message_structure, " \
 		 "=2 dump the spi_message_structure including data, " \
 		 "=3 dump the spi_message structure before and after execution");
-- 
2.7.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
