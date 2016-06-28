From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Fix typo in devicetree/bindings/spi" to the spi tree
Date: Tue, 28 Jun 2016 20:36:33 +0100
Message-ID: <E1bHyoD-0004ZZ-Be@debutante>
References: <20160628193333.3971-1-standby24x7@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
To: Masanari Iida <standby24x7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160628193333.3971-1-standby24x7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Fix typo in devicetree/bindings/spi

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 0fb7620fba7feb977a5138f8d7f6b42514f81ea9 Mon Sep 17 00:00:00 2001
From: Masanari Iida <standby24x7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 29 Jun 2016 04:33:33 +0900
Subject: [PATCH] spi: Fix typo in devicetree/bindings/spi

This patch fix spelling typos found in
Documentation/devicetree/bingings/spi.

Signed-off-by: Masanari Iida <standby24x7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
