From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: butterfly: remove cast to void" to the spi tree
Date: Wed, 02 Dec 2015 20:11:05 +0000
Message-ID: <E1a4Dk1-0003TN-HZ@debutante>
References: <1449064071-4915-2-git-send-email-sudipm.mukherjee@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudip Mukherjee <sudip-ofJRbWXBVFamYgehrs7/Lw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449064071-4915-2-git-send-email-sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: butterfly: remove cast to void

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

>From b12fe7250cf013622d064a280b87b19448d26d00 Mon Sep 17 00:00:00 2001
From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 2 Dec 2015 19:17:49 +0530
Subject: [PATCH] spi: butterfly: remove cast to void

checkpatch was complaining about space after cast. But the cast to void
is not required at that place.

Signed-off-by: Sudip Mukherjee <sudip-ofJRbWXBVFamYgehrs7/Lw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-butterfly.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-butterfly.c b/drivers/spi/spi-butterfly.c
index f520eaa193c5..8fc284d0d7c3 100644
--- a/drivers/spi/spi-butterfly.c
+++ b/drivers/spi/spi-butterfly.c
@@ -289,7 +289,7 @@ clean2:
 clean1:
 	parport_unregister_device(pd);
 clean0:
-	(void) spi_master_put(pp->bitbang.master);
+	spi_master_put(pp->bitbang.master);
 done:
 	pr_debug("%s: butterfly probe, fail %d\n", p->name, status);
 }
@@ -317,7 +317,7 @@ static void butterfly_detach(struct parport *p)
 	parport_release(pp->pd);
 	parport_unregister_device(pp->pd);
 
-	(void) spi_master_put(pp->bitbang.master);
+	spi_master_put(pp->bitbang.master);
 }
 
 static struct parport_driver butterfly_driver = {
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
