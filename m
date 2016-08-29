From: Sien Wu <sien.wu-acOepvfBmUk@public.gmane.org>
Subject: [RFC] spi: Prevent unexpected SPI time out due to arithmetic overflow
Date: Mon, 29 Aug 2016 09:02:47 -0500
Message-ID: <1472479367-50682-1-git-send-email-sien.wu@ni.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Sien Wu <sien.wu-acOepvfBmUk@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

When reading SPI flash as MTD device, the transfer length is
directly passed to the spi driver. If the requested data size
exceeds 512KB, it will cause the time out calculation to
overflow since transfer length is 32-bit unsigned integer.
This issue is resolved by using 64-bit unsigned integer
to perform the arithmetic.

Signed-off-by: Sien Wu <sien.wu-acOepvfBmUk@public.gmane.org>
Acked-by: Brad Keryan <brad.keryan-acOepvfBmUk@public.gmane.org>
Acked-by: Gratian Crisan <gratian.crisan-acOepvfBmUk@public.gmane.org>
Acked-by: Brad Mouring <brad.mouring-acOepvfBmUk@public.gmane.org>

Natinst-ReviewBoard-ID 150232
---
 drivers/spi/spi.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 029dbd3..a186a62 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -678,7 +678,7 @@ static int spi_transfer_one_message(struct spi_master *master,
 	struct spi_transfer *xfer;
 	bool keep_cs = false;
 	int ret = 0;
-	unsigned long ms = 1;
+	unsigned long long ms = 1;
 
 	spi_set_cs(msg->spi, true);
 
@@ -697,11 +697,16 @@ static int spi_transfer_one_message(struct spi_master *master,
 
 			if (ret > 0) {
 				ret = 0;
-				ms = xfer->len * 8 * 1000 / xfer->speed_hz;
+
+				ms = 8LL * 1000LL * xfer->len;
+				do_div(ms, xfer->speed_hz);
 				ms += ms + 100; /* some tolerance */
 
+				if (ms > UINT_MAX)
+					ms = UINT_MAX;
+
 				ms = wait_for_completion_timeout(&master->xfer_completion,
-								 msecs_to_jiffies(ms));
+							msecs_to_jiffies(ms));
 			}
 
 			if (ms == 0) {
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
