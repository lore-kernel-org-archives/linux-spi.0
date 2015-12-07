From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: lm70llp: remove printk" to the spi tree
Date: Mon, 07 Dec 2015 20:09:30 +0000
Message-ID: <E1a626E-0004VO-GE@debutante>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudip Mukherjee <sudip-ofJRbWXBVFamYgehrs7/Lw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: 
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: lm70llp: remove printk

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

>From 22de54a9b929e7c11e445c8f329d33aa7b154495 Mon Sep 17 00:00:00 2001
From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Mon, 7 Dec 2015 16:17:35 +0530
Subject: [PATCH] spi: lm70llp: remove printk

Using pr_* macros are more prefferable than using printk. Start using
pr_* family of macros and define pr_fmt to be used with it.
While at it remove DRVNAME from an existing pr_info() as the name is now
being printed by pr_fmt.

Signed-off-by: Sudip Mukherjee <sudip-ofJRbWXBVFamYgehrs7/Lw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-lm70llp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-lm70llp.c b/drivers/spi/spi-lm70llp.c
index cb2284475385..61ee0f4269ae 100644
--- a/drivers/spi/spi-lm70llp.c
+++ b/drivers/spi/spi-lm70llp.c
@@ -14,6 +14,8 @@
  * GNU General Public License for more details.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -200,9 +202,7 @@ static void spi_lm70llp_attach(struct parport *p)
 	struct pardev_cb	lm70llp_cb;
 
 	if (lm70llp) {
-		printk(KERN_WARNING
-			"%s: spi_lm70llp instance already loaded. Aborting.\n",
-			DRVNAME);
+		pr_warn("spi_lm70llp instance already loaded. Aborting.\n");
 		return;
 	}
 
@@ -298,7 +298,7 @@ out_parport_unreg:
 out_free_master:
 	spi_master_put(master);
 out_fail:
-	pr_info("%s: spi_lm70llp probe fail, status %d\n", DRVNAME, status);
+	pr_info("spi_lm70llp probe fail, status %d\n", status);
 }
 
 static void spi_lm70llp_detach(struct parport *p)
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
