From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org>
Subject: [PATCH v2] spi: mvebu: fix baudrate calculation for armada variant
Date: Thu,  8 Dec 2016 17:37:08 +0100
Message-ID: <20161208163708.9775-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>,
        kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The calculation of SPR and SPPR doesn't round correctly at several
places which might result in baud rates that are too big. For example
with tclk_hz = 250000001 and target rate 25000000 it determined a
divider of 10 which is wrong.

Instead of fixing all the corner cases replace the calculation by an
algorithm without a loop which should even be quicker to execute apart
from being correct.

Fixes: df59fa7f4bca ("spi: orion: support armada extended baud rates")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
Changes since (implicit) v1 sent with Message-Id: 20161208082111.5314-1-uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org

 - Fix e-mail address (which broonie already fixed when v1 was applied)
 - Make it compile without uncommitted changes in worktree (sigh + sorry)

 drivers/spi/spi-orion.c | 83 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 54 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index ded37025b445..6b001c4a5640 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -138,37 +138,62 @@ static int orion_spi_baudrate_set(struct spi_device *spi, unsigned int speed)
 	tclk_hz = clk_get_rate(orion_spi->clk);
 
 	if (devdata->typ == ARMADA_SPI) {
-		unsigned int clk, spr, sppr, sppr2, err;
-		unsigned int best_spr, best_sppr, best_err;
-
-		best_err = speed;
-		best_spr = 0;
-		best_sppr = 0;
-
-		/* Iterate over the valid range looking for best fit */
-		for (sppr = 0; sppr < 8; sppr++) {
-			sppr2 = 0x1 << sppr;
-
-			spr = tclk_hz / sppr2;
-			spr = DIV_ROUND_UP(spr, speed);
-			if ((spr == 0) || (spr > 15))
-				continue;
-
-			clk = tclk_hz / (spr * sppr2);
-			err = speed - clk;
-
-			if (err < best_err) {
-				best_spr = spr;
-				best_sppr = sppr;
-				best_err = err;
-			}
-		}
+		/*
+		 * Given the core_clk (tclk_hz) and the target rate (speed) we
+		 * determine the best values for SPR (in [0 .. 15]) and SPPR (in
+		 * [0..7]) such that
+		 *
+		 * 	core_clk / (SPR * 2 ** SPPR)
+		 *
+		 * is as big as possible but not bigger than speed.
+		 */
 
-		if ((best_sppr == 0) && (best_spr == 0))
-			return -EINVAL;
+		/* best integer divider: */
+		unsigned divider = DIV_ROUND_UP(tclk_hz, speed);
+		unsigned spr, sppr;
+
+		if (divider < 16) {
+			/* This is the easy case, divider is less than 16 */
+			spr = divider;
+			sppr = 0;
+
+		} else {
+			unsigned two_pow_sppr;
+			/*
+			 * Find the highest bit set in divider. This and the
+			 * three next bits define SPR (apart from rounding).
+			 * SPPR is then the number of zero bits that must be
+			 * appended:
+			 */
+			sppr = fls(divider) - 4;
+
+			/*
+			 * As SPR only has 4 bits, we have to round divider up
+			 * to the next multiple of 2 ** sppr.
+			 */
+			two_pow_sppr = 1 << sppr;
+			divider = (divider + two_pow_sppr - 1) & -two_pow_sppr;
+
+			/*
+			 * recalculate sppr as rounding up divider might have
+			 * increased it enough to change the position of the
+			 * highest set bit. In this case the bit that now
+			 * doesn't make it into SPR is 0, so there is no need to
+			 * round again.
+			 */
+			sppr = fls(divider) - 4;
+			spr = divider >> sppr;
+
+			/*
+			 * Now do range checking. SPR is constructed to have a
+			 * width of 4 bits, so this is fine for sure. So we
+			 * still need to check for sppr to fit into 3 bits:
+			 */
+			if (sppr > 7)
+				return -EINVAL;
+		}
 
-		prescale = ((best_sppr & 0x6) << 5) |
-			((best_sppr & 0x1) << 4) | best_spr;
+		prescale = ((sppr & 0x6) << 5) | ((sppr & 0x1) << 4) | spr;
 	} else {
 		/*
 		 * the supported rates are: 4,6,8...30
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
