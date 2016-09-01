From: Sien Wu <sien.wu-acOepvfBmUk@public.gmane.org>
Subject: [RFC v2] spi: Prevent unexpected SPI time out due to arithmetic overflow
Date: Thu, 1 Sep 2016 18:24:29 -0500
Message-ID: <1472772269-44752-1-git-send-email-sien.wu@ni.com>
References: <20160901195747.GN5967>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Sien Wu <sien.wu-acOepvfBmUk@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160901195747.GN5967>
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
Updated the patch to apply to latest spi.c

---
 drivers/spi/spi.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 51ad42f..ac889df 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -960,7 +960,7 @@ static int spi_transfer_one_message(struct spi_master *master,
 	struct spi_transfer *xfer;
 	bool keep_cs = false;
 	int ret = 0;
-	unsigned long ms = 1;
+	unsigned long long ms = 1;
 	struct spi_statistics *statm = &master->statistics;
 	struct spi_statistics *stats = &msg->spi->statistics;
 
@@ -991,9 +991,13 @@ static int spi_transfer_one_message(struct spi_master *master,
 
 			if (ret > 0) {
 				ret = 0;
-				ms = xfer->len * 8 * 1000 / xfer->speed_hz;
+				ms = 8LL * 1000LL * xfer->len;
+				do_div(ms, xfer->speed_hz);
 				ms += ms + 100; /* some tolerance */
 
+				if (ms > UINT_MAX)
+					ms = UINT_MAX;
+
 				ms = wait_for_completion_timeout(&master->xfer_completion,
 								 msecs_to_jiffies(ms));
 			}
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
