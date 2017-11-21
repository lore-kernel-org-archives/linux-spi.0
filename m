From: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/3] MAINTAINERS: Add Ricardo Ribalda for spi-xilinx
Date: Tue, 21 Nov 2017 10:09:04 +0100
Message-ID: <20171121090904.6901-3-ricardo.ribalda@gmail.com>
References: <20171121090904.6901-1-ricardo.ribalda@gmail.com>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171121090904.6901-1-ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Since almost half of the driver comes from changes from me, I have
access to the hardware and we are using it in a current product I
volunteer for maintaining this driver.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 CREDITS                  | 1 +
 MAINTAINERS              | 6 ++++++
 drivers/spi/spi-xilinx.c | 1 +
 3 files changed, 8 insertions(+)

diff --git a/CREDITS b/CREDITS
index a3ec0c744172..b3bca8d36d2a 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3071,6 +3071,7 @@ D: Several AX.25 hacks
 N: Ricardo Ribalda Delgado
 E: ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
 W: http://ribalda.com
+D: Xilinx QUAD SPI driver
 D: PLX USB338x driver
 D: PCA9634 driver
 D: Option GTM671WFS
diff --git a/MAINTAINERS b/MAINTAINERS
index 2811a211632c..992f24e4e05a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14786,6 +14786,12 @@ M:	John Linn <John.Linn-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
 S:	Maintained
 F:	drivers/net/ethernet/xilinx/xilinx_axienet*
 
+XILINX SPI DRIVER
+M:	Ricardo Ribalda <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+L:	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+S:	Supported
+F:	drivers/spi/spi-xilinx.c
+
 XILINX UARTLITE SERIAL DRIVER
 M:	Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
 L:	linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 63fedc49ae9c..b401c4e1c93a 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -4,6 +4,7 @@
  * Author: MontaVista Software, Inc.
  *	source-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org
  *
+ * Copyright (C) 2015-2017 Ricardo Ribalda, Qtechnology A/S
  * Copyright (c) 2010 Secret Lab Technologies, Ltd.
  * Copyright (c) 2009 Intel Corporation
  * 2002-2007 (c) MontaVista Software, Inc.
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
