From: Masanari Iida <standby24x7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Doc: spi: Fix typo in devicetree/bindings/spi
Date: Wed, 29 Jun 2016 04:33:33 +0900
Message-ID: <20160628193333.3971-1-standby24x7@gmail.com>
Cc: Masanari Iida <standby24x7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch fix spelling typos found in
Documentation/devicetree/bingings/spi.

Signed-off-by: Masanari Iida <standby24x7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-davinci.txt | 2 +-
 Documentation/devicetree/bindings/spi/ti_qspi.txt     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-davinci.txt b/Documentation/devicetree/bindings/spi/spi-davinci.txt
index d1e914adcf6e..f5916c92fe91 100644
--- a/Documentation/devicetree/bindings/spi/spi-davinci.txt
+++ b/Documentation/devicetree/bindings/spi/spi-davinci.txt
@@ -21,7 +21,7 @@ Required properties:
 	IP to the interrupt controller within the SoC. Possible values
 	are 0 and 1. Manual says one of the two possible interrupt
 	lines can be tied to the interrupt controller. Set this
-	based on a specifc SoC configuration.
+	based on a specific SoC configuration.
 - interrupts: interrupt number mapped to CPU.
 - clocks: spi clk phandle
 
diff --git a/Documentation/devicetree/bindings/spi/ti_qspi.txt b/Documentation/devicetree/bindings/spi/ti_qspi.txt
index 50b14f6b53a3..e65fde4a7388 100644
--- a/Documentation/devicetree/bindings/spi/ti_qspi.txt
+++ b/Documentation/devicetree/bindings/spi/ti_qspi.txt
@@ -20,7 +20,7 @@ Optional properties:
 		      chipselect register and offset of that register.
 
 NOTE: TI QSPI controller requires different pinmux and IODelay
-paramaters for Mode-0 and Mode-3 operations, which needs to be set up by
+parameters for Mode-0 and Mode-3 operations, which needs to be set up by
 the bootloader (U-Boot). Default configuration only supports Mode-0
 operation. Hence, "spi-cpol" and "spi-cpha" DT properties cannot be
 specified in the slave nodes of TI QSPI controller without appropriate
-- 
2.9.0.137.gcf4c2cf

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
