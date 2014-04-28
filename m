From: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH v2 04/10] Documentation: mtd: add a new document for SPI NOR flash
Date: Mon, 28 Apr 2014 11:53:41 +0800
Message-ID: <1398657227-20721-5-git-send-email-b32955@freescale.com>
References: <1398657227-20721-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <marex-ynQEQJNshbs@public.gmane.org>,
	<linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398657227-20721-1-git-send-email-b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

We need a DT property to store the dummy cycles for DDR Quad read.
This is a common feature for the SPI NOR flash, such as Spansion and Micron
chips.

Add this file to describe this specific SPI NOR flash features which will
be referred by the SPI NOR flash drivers.

Signed-off-by: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 .../devicetree/bindings/mtd/spi-nor-flash.txt      |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/spi-nor-flash.txt

diff --git a/Documentation/devicetree/bindings/mtd/spi-nor-flash.txt b/Documentation/devicetree/bindings/mtd/spi-nor-flash.txt
new file mode 100644
index 0000000..aba4d54
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/spi-nor-flash.txt
@@ -0,0 +1,7 @@
+This file defines some DT properties for specific SPI NOR flash features.
+The SPI NOR controller drivers may refer to this file, such as fsl-quadspi.txt
+
+Optional properties:
+  - spi-nor,ddr-quad-read-dummy: The dummy cycles used by the DDR Quad read.
+                                 Please refer to the chip's datasheet. This
+                                 property can be 4 or 6 which is less then 8.
-- 
1.7.2.rc3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
