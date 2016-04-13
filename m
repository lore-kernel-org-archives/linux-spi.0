From: Po Liu <po.liu-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH] dspi: config dspi master regmap with right mode depend on BE or LE
Date: Wed, 13 Apr 2016 19:03:22 +0800
Message-ID: <1460545402-8162-1-git-send-email-po.liu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Po Liu <po.liu-3arQi8VN3Tc@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

When kernel config with big endian mode, spi master need
to config regmap data value to be little endian mode. Or else,
the kernel boot will hang.

Signed-off-by: Po Liu <po.liu-3arQi8VN3Tc@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 39412c9..a1d893c 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -637,6 +637,9 @@ static const struct regmap_config dspi_regmap_config = {
 	.val_bits = 32,
 	.reg_stride = 4,
 	.max_register = 0x88,
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+#endif
 };
 
 static int dspi_probe(struct platform_device *pdev)
-- 
2.1.0.27.g96db324

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
