From: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/2] spi: s3c64xx: fix potential division by zero
Date: Tue, 07 Feb 2017 17:10:25 +0900
Message-ID: <20170207081025.9671-2-andi.shyti@samsung.com>
References: <20170207081025.9671-1-andi.shyti@samsung.com>
 <CGME20170207081032epcas5p3af837bbe00278da4029fc7bb9eba6961@epcas5p3.samsung.com>
Cc: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
        linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
To: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20170207081025.9671-1-andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Even though it's quite unlikely to happen in this particular
case, clk_get_rate can return '0' if sdd->src_clk is not set
properly. In that case we would have a clear division by '0'.

Check the return value of clk_get_rate and fail in case it
returns '0'.

This patch fixes '1397922 Division or modulo by zero' from
scan.coverity.com

Signed-off-by: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-s3c64xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index f6ea9ae047ec..a2ec07f44e33 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -811,6 +811,8 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 
 		/* Max possible */
 		speed = clk_get_rate(sdd->src_clk) / 2 / (0 + 1);
+		if (!speed)
+			goto setup_exit;
 
 		if (spi->max_speed_hz > speed)
 			spi->max_speed_hz = speed;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
