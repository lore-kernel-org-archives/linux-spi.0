From: Matthias Seidel <kernel-NoMTM8u0nx3R7s880joybQ@public.gmane.org>
Subject: [PATCH v4] spi: dw: round up result of calculation for clock
 divider
Date: Wed, 7 Sep 2016 17:45:30 +0200
Message-ID: <20160907174530.1ada556f@vm>
References: <20160904020535.2bb2ab68@vm>
        <20160906105352.GK3950@sirena.org.uk>
        <20160906191652.01a11698@vm>
        <20160906222131.GT3950@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160906222131.GT3950-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Avoid ending up with a higher frequency than requested

Signed-off-by: Matthias Seidel <kernel-NoMTM8u0nx3R7s880joybQ@public.gmane.org>
---
v4: Corrected subject, thanks for your work!

Previously failing example:
requested transfer freq: 16MHz
max_freq = 200MHz
calculated clk_div = 12
actual frequency = 200/12 = 16.6666MHz
---
 drivers/spi/spi-dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index c85e4b3..27960e4 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -300,7 +300,7 @@ static int dw_spi_transfer_one(struct spi_master *master,
 	if (transfer->speed_hz != dws->current_freq) {
 		if (transfer->speed_hz != chip->speed_hz) {
 			/* clk_div doesn't support odd number */
-			chip->clk_div = (dws->max_freq / transfer->speed_hz + 1) & 0xfffe;
+			chip->clk_div = (DIV_ROUND_UP(dws->max_freq, transfer->speed_hz) + 1) & 0xfffe;
 			chip->speed_hz = transfer->speed_hz;
 		}
 		dws->current_freq = transfer->speed_hz;
-- 
2.7.4



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
