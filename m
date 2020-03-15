From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>
Subject: [PATCH] spi: fix cs_change for last transfer
Date: Sun, 15 Mar 2020 18:08:53 +0100
Message-ID: <45912ba25c34a63b8098f471c3c8ebf8857a4716.1584292056.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Generic spi_transfer_one_message() implementation introduced in
commit b158935f70b9 has a bug in cs_change handling: it keeps CS
asserted when cs_change is set. Fix it.

Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Fixes: b158935f70b9 ("spi: Provide common spi_message processing loop")
Signed-off-by: Michał Mirosław <mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>
---
 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8994545367a2..5012eabde468 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1206,7 +1206,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 				    struct spi_message *msg)
 {
 	struct spi_transfer *xfer;
-	bool keep_cs = false;
+	bool keep_cs = true;
 	int ret = 0;
 	struct spi_statistics *statm = &ctlr->statistics;
 	struct spi_statistics *stats = &msg->spi->statistics;
@@ -1268,7 +1268,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 		if (xfer->cs_change) {
 			if (list_is_last(&xfer->transfer_list,
 					 &msg->transfers)) {
-				keep_cs = true;
+				keep_cs = false;
 			} else {
 				spi_set_cs(msg->spi, false);
 				_spi_transfer_cs_change_delay(msg, xfer);
-- 
2.20.1
