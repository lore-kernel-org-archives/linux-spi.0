From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 3/8] spi: lm70llp: remove cast to void
Date: Mon,  7 Dec 2015 16:17:30 +0530
Message-ID: <1449485255-1103-3-git-send-email-sudipm.mukherjee@gmail.com>
References: <1449485255-1103-1-git-send-email-sudipm.mukherjee@gmail.com>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449485255-1103-1-git-send-email-sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

checkpatch was complaining about space after cast. But the cast to void
is not required at that place.

Signed-off-by: Sudip Mukherjee <sudip-ofJRbWXBVFamYgehrs7/Lw@public.gmane.org>
---
 drivers/spi/spi-lm70llp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-lm70llp.c b/drivers/spi/spi-lm70llp.c
index 7037028..133e76c 100644
--- a/drivers/spi/spi-lm70llp.c
+++ b/drivers/spi/spi-lm70llp.c
@@ -294,7 +294,7 @@ out_off_and_release:
 out_parport_unreg:
 	parport_unregister_device(pd);
 out_free_master:
-	(void) spi_master_put(master);
+	spi_master_put(master);
 out_fail:
 	pr_info("%s: spi_lm70llp probe fail, status %d\n", DRVNAME, status);
 }
@@ -315,7 +315,7 @@ static void spi_lm70llp_detach(struct parport *p)
 	parport_release(pp->pd);
 	parport_unregister_device(pp->pd);
 
-	(void) spi_master_put(pp->bitbang.master);
+	spi_master_put(pp->bitbang.master);
 
 	lm70llp = NULL;
 }
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
