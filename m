From: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH v2 2/2] spi: core: Use min_t(size_t,..)
Date: Wed, 17 Feb 2016 15:42:28 -0200
Message-ID: <1455730948-24938-2-git-send-email-fabio.estevam@nxp.com>
References: <1455730948-24938-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455730948-24938-1-git-send-email-fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use min_t(size_t,..) in order to avoid the following 
build warning on ARM64:

include/linux/kernel.h:754:17: warning: comparison of distinct pointer types lacks a cast
  (void) (&_min1 == &_min2);  \
                 ^
drivers/spi/spi.c:2304:17: note: in expansion of macro 'min'
  xfers[0].len = min(maxsize, xfer[0].len);

Suggested-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
---
Changes since v1:
- Use min_t(size_t (Geert).

 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0725ffa..4f42f09 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2301,7 +2301,7 @@ static int __spi_split_transfer_maxsize(struct spi_master *master,
 	/* the first transfer just needs the length modified, so we
 	 * run it outside the loop
 	 */
-	xfers[0].len = min(maxsize, xfer[0].len);
+	xfers[0].len = min_t(size_t, maxsize, xfer[0].len);
 
 	/* all the others need rx_buf/tx_buf also set */
 	for (i = 1, offset = maxsize; i < count; offset += maxsize, i++) {
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
