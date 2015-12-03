From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 3/7] spi: lm70llp: remove cast to void
Date: Thu,  3 Dec 2015 18:29:55 +0530
Message-ID: <1449147599-26705-3-git-send-email-sudipm.mukherjee@gmail.com>
References: <1449147599-26705-1-git-send-email-sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449147599-26705-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

checkpatch was complaining about space after cast. But the cast to void
is not required at that place.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
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
