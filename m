From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi/imx: Add MAINTAINERS entry for i.MX SPI driver
Date: Mon, 15 Sep 2014 15:44:20 -0700
Message-ID: <1410821060-9102-1-git-send-email-broonie@kernel.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Marek wrote the driver and has been active in reviewing patches for it so
add a MAINTAINERS entry to help people find him and CC him on new patches.

Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---

Marek, is this OK for you?

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b7976b..ed17a5a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3848,6 +3848,13 @@ S:	Maintained
 F:	include/linux/platform_data/video-imxfb.h
 F:	drivers/video/fbdev/imxfb.c
 
+FREESCALE IMX SPI DRIVER
+M:	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
+L:	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+L:	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org (moderated for non-subscribers)
+F:	drivers/spi/spi-imx.c
+F:	Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
+
 FREESCALE SOC FS_ENET DRIVER
 M:	Pantelis Antoniou <pantelis.antoniou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
 M:	Vitaly Bordug <vbordug-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
