From: Julius Werner <jwerner-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/2] spi/rockchip: Round up clock rate divisor to err on the safe side
Date: Thu, 26 Mar 2015 16:30:24 -0700
Message-ID: <1427412625-12377-1-git-send-email-jwerner@chromium.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
	addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Julius Werner <jwerner-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The Rockchip SPI driver currently calculates its clock rate divisor by
integer dividing the parent rate by the target rate, and then rounding
the result up to the next even number (since the divisor must be
even).

Clock rate divisors should always be rounded up, so that the resulting
frequency is lower or equal to the target. This is correctly done in the
second step here but not in the first, so we still have a risk of
exceeding the desired target frequency (e.g. setting spi-max-frequency
to 40000000 with a parent clock of 99000000 could lead to a divisor of
99000000 / 40000000 == 2 (which is even) that then results in an
effective frequency of 99000000 / 2 == 49500000 (potentially exceeding
the flash chip's specifications).

This patch changes the division to round up to fix this problem.

Signed-off-by: Julius Werner <jwerner-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/spi/spi-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 1a777dc..5e4e52c 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -519,7 +519,7 @@ static void rockchip_spi_config(struct rockchip_spi *rs)
 	}
 
 	/* div doesn't support odd number */
-	div = max_t(u32, rs->max_freq / rs->speed, 1);
+	div = DIV_ROUND_UP(rs->max_freq, rs->speed);
 	div = (div + 1) & 0xfffe;
 
 	writel_relaxed(cr0, rs->regs + ROCKCHIP_SPI_CTRLR0);
-- 
2.1.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
