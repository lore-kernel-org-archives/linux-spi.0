From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi: Fix handling of cs_change in core implementation
Date: Sun, 30 Mar 2014 00:27:45 +0000
Message-ID: <1396139265-28900-1-git-send-email-broonie@kernel.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org,
	Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

The core implementation of cs_change didn't follow the documentation
which says that cs_change in the middle of the transfer means to briefly
deassert chip select, instead it followed buggy drivers which change the
polarity of chip select.  Use a delay of 10us between deassert and
reassert simply from pulling numbers out of a hat.

Reported-by: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---

Compile tested only.

 drivers/spi/spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 121c43b..4eb9bf0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -754,7 +754,6 @@ static int spi_transfer_one_message(struct spi_master *master,
 				    struct spi_message *msg)
 {
 	struct spi_transfer *xfer;
-	bool cur_cs = true;
 	bool keep_cs = false;
 	int ret = 0;
 	int ms = 1;
@@ -800,8 +799,9 @@ static int spi_transfer_one_message(struct spi_master *master,
 					 &msg->transfers)) {
 				keep_cs = true;
 			} else {
-				cur_cs = !cur_cs;
-				spi_set_cs(msg->spi, cur_cs);
+				spi_set_cs(msg->spi, false);
+				udelay(10);
+				spi_set_cs(msg->spi, true);
 			}
 		}
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
