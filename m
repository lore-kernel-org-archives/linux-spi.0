From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] spi/rockchip: Avoid accidentally turning off the clock
Date: Thu, 28 Aug 2014 16:43:48 -0700
Message-ID: <1409269428-24680-1-git-send-email-dianders@chromium.org>
Cc: "Jeffy.Chen" <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	amstan-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

If our client is requesting a clock that is above the maximum clock
then the following division will result in 0:
  rs->max_freq / rs->speed

We'll then program 0 into the SPI_BAUDR register.  The Rockchip TRM
says: "If the value is 0, the serial output clock (sclk_out) is
disabled."

It's much better to end up with the fastest possible clock rather than
a clock that is off, so enforce a minimum value.

Signed-off-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/spi/spi-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 6321326..cd0e08b0 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -499,7 +499,7 @@ static void rockchip_spi_config(struct rockchip_spi *rs)
 	}
 
 	/* div doesn't support odd number */
-	div = rs->max_freq / rs->speed;
+	div = max_t(u32, rs->max_freq / rs->speed, 1);
 	div = (div + 1) & 0xfffe;
 
 	spi_enable_chip(rs, 0);
-- 
2.1.0.rc2.206.gedb03e5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
