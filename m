From: Matthias Seidel <kernel-NoMTM8u0nx3R7s880joybQ@public.gmane.org>
Subject: [PATCH 2/2] spi: dw: round up result of calculation for clock divider
Date: Fri, 2 Sep 2016 17:41:45 +0200
Message-ID: <457c5375-38b3-9c36-76a3-a43321aa687b@mseidel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

avoid ending up with a higher frequency than requested

---
 drivers/spi/spi-dw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index c85e4b3..2fd517d 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -300,7 +300,8 @@ static int dw_spi_transfer_one(struct spi_master *master,
     if (transfer->speed_hz != dws->current_freq) {
         if (transfer->speed_hz != chip->speed_hz) {
             /* clk_div doesn't support odd number */
-            chip->clk_div = (dws->max_freq / transfer->speed_hz + 1) & 0xfffe;
+            chip->clk_div = ((dws->max_freq + transfer->speed_hz) /
+                transfer->speed_hz + 1) & 0xfffe;
             chip->speed_hz = transfer->speed_hz;
         }
         dws->current_freq = transfer->speed_hz;
-- 
1.9.1
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
