From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 8/8] spi: lm70llp: remove printk
Date: Mon,  7 Dec 2015 16:17:35 +0530
Message-ID: <1449485255-1103-8-git-send-email-sudipm.mukherjee@gmail.com>
References: <1449485255-1103-1-git-send-email-sudipm.mukherjee@gmail.com>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449485255-1103-1-git-send-email-sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Using pr_* macros are more prefferable than using printk. Start using
pr_* family of macros and define pr_fmt to be used with it.
While at it remove DRVNAME from an existing pr_info() as the name is now
being printed by pr_fmt.

Signed-off-by: Sudip Mukherjee <sudip-ofJRbWXBVFamYgehrs7/Lw@public.gmane.org>
---
 drivers/spi/spi-lm70llp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-lm70llp.c b/drivers/spi/spi-lm70llp.c
index 393eb2b..8fe83d0 100644
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
 	struct pardev_cb        lm70llp_cb;
 
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
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
