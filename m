From: jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCHv3 3/3] MAINTAINERS: Add entry for Synquacer SPI driver
Date: Fri, 19 Jan 2018 16:07:45 +0530
Message-ID: <1516358265-4578-1-git-send-email-jassisinghbrar@gmail.com>
References: <1516358213-4400-1-git-send-email-jassisinghbrar@gmail.com>
Cc: tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
        robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        masami.hiramatsu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
        Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1516358213-4400-1-git-send-email-jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Add entry for the Synquacer spi driver and DT bindings.

Signed-off-by: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1899480..da79a2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12627,6 +12627,13 @@ F:	drivers/md/raid*
 F:	include/linux/raid/
 F:	include/uapi/linux/raid/
 
+SOCIONEXT (SNI) Synquacer SPI DRIVER
+M:	Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
+L:	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+S:	Maintained
+F:	drivers/spi/spi-synquacer.c
+F:	Documentation/devicetree/bindings/spi/spi-synquacer.txt
+
 SONIC NETWORK DRIVER
 M:	Thomas Bogendoerfer <tsbogend-I1c7kopa9pxLokYuJOExCg@public.gmane.org>
 L:	netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
