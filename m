From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 2/4] spi: butterfly: remove cast to void
Date: Wed,  2 Dec 2015 19:17:49 +0530
Message-ID: <1449064071-4915-2-git-send-email-sudipm.mukherjee@gmail.com>
References: <1449064071-4915-1-git-send-email-sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449064071-4915-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

checkpatch was complaining about space after cast. But the cast to void
is not required at that place.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/spi/spi-butterfly.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-butterfly.c b/drivers/spi/spi-butterfly.c
index f520eaa..8fc284d 100644
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
1.9.1
