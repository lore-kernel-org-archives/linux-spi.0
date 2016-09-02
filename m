From: Matthias Seidel <kernel-NoMTM8u0nx3R7s880joybQ@public.gmane.org>
Subject: [PATCH 1/2] spi: dw: fix multiple slaves with different baudrates
Date: Fri, 2 Sep 2016 17:39:12 +0200
Message-ID: <84f71116-1c79-6769-d537-860ac6ea0de9@mseidel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add current master clock to dws struct and compare it against the
requestedtransfer speed. Update clock divider only if necessary.

Signed-off-by: Matthias Seidel <kernel-NoMTM8u0nx3R7s880joybQ@public.gmane.org>
---
The current implementation stores the transfer speed in the chip struct.
If there are multiple slaves which need different clock speeds, the
clk_div only gets updated the first time for each slave as speed_hz is 0.
After that the comparison always shows the transfer-speed to be equal to the
chipspeed and the divider is not updated.

---
 drivers/spi/spi-dw.c | 15 +++++++--------
 drivers/spi/spi-dw.h |  1 +
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index c09bb74..c85e4b3 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -283,7 +283,6 @@ static int dw_spi_transfer_one(struct spi_master *master,
     struct chip_data *chip = spi_get_ctldata(spi);
     u8 imask = 0;
     u16 txlevel = 0;
-    u16 clk_div;
     u32 cr0;
     int ret;
 
@@ -298,13 +297,13 @@ static int dw_spi_transfer_one(struct spi_master *master,
     spi_enable_chip(dws, 0);
 
     /* Handle per transfer options for bpw and speed */
-    if (transfer->speed_hz != chip->speed_hz) {
-        /* clk_div doesn't support odd number */
-        clk_div = (dws->max_freq / transfer->speed_hz + 1) & 0xfffe;
-
-        chip->speed_hz = transfer->speed_hz;
-        chip->clk_div = clk_div;
-
+    if (transfer->speed_hz != dws->current_freq) {
+        if (transfer->speed_hz != chip->speed_hz) {
+            /* clk_div doesn't support odd number */
+            chip->clk_div = (dws->max_freq / transfer->speed_hz + 1) & 0xfffe;
+            chip->speed_hz = transfer->speed_hz;
+        }
+        dws->current_freq = transfer->speed_hz;
         spi_set_clk(dws, chip->clk_div);
     }
     if (transfer->bits_per_word == 8) {
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 61bc3cb..c21ca02 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -123,6 +123,7 @@ struct dw_spi {
     u8            n_bytes;    /* current is a 1/2 bytes op */
     u32            dma_width;
     irqreturn_t        (*transfer_handler)(struct dw_spi *dws);
+    u32            current_freq;    /* frequency in hz */
 
     /* DMA info */
     int            dma_inited;
-- 
1.9.1
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
