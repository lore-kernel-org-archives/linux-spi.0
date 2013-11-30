From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 4/5] MIPS: BCM63XX: add HSSPI platform device and register it
Date: Sat, 30 Nov 2013 12:42:05 +0100
Message-ID: <1385811726-6746-5-git-send-email-jogo@openwrt.org>
References: <1385811726-6746-1-git-send-email-jogo@openwrt.org>
Cc: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
To: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385811726-6746-1-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
 arch/mips/bcm63xx/Makefile                         |  4 +-
 arch/mips/bcm63xx/boards/board_bcm963xx.c          |  3 ++
 arch/mips/bcm63xx/dev-hsspi.c                      | 47 ++++++++++++++++++++++
 .../include/asm/mach-bcm63xx/bcm63xx_dev_hsspi.h   |  8 ++++
 4 files changed, 60 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/bcm63xx/dev-hsspi.c
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_hsspi.h

diff --git a/arch/mips/bcm63xx/Makefile b/arch/mips/bcm63xx/Makefile
index ac28073..9019f54 100644
--- a/arch/mips/bcm63xx/Makefile
+++ b/arch/mips/bcm63xx/Makefile
@@ -1,7 +1,7 @@
 obj-y		+= clk.o cpu.o cs.o gpio.o irq.o nvram.o prom.o reset.o \
 		   setup.o timer.o dev-dsp.o dev-enet.o dev-flash.o \
-		   dev-pcmcia.o dev-rng.o dev-spi.o dev-uart.o dev-wdt.o \
-		   dev-usb-usbd.o
+		   dev-pcmcia.o dev-rng.o dev-spi.o dev-hsspi.o dev-uart.o \
+		   dev-wdt.o dev-usb-usbd.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-y		+= boards/
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 5b974eb..33727e7 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -23,6 +23,7 @@
 #include <bcm63xx_dev_enet.h>
 #include <bcm63xx_dev_dsp.h>
 #include <bcm63xx_dev_flash.h>
+#include <bcm63xx_dev_hsspi.h>
 #include <bcm63xx_dev_pcmcia.h>
 #include <bcm63xx_dev_spi.h>
 #include <bcm63xx_dev_usb_usbd.h>
@@ -915,6 +916,8 @@ int __init board_register_devices(void)
 
 	bcm63xx_spi_register();
 
+	bcm63xx_hsspi_register();
+
 	bcm63xx_flash_register();
 
 	bcm63xx_led_data.num_leds = ARRAY_SIZE(board.leds);
diff --git a/arch/mips/bcm63xx/dev-hsspi.c b/arch/mips/bcm63xx/dev-hsspi.c
new file mode 100644
index 0000000..696abc4
--- /dev/null
+++ b/arch/mips/bcm63xx/dev-hsspi.c
@@ -0,0 +1,47 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012 Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+
+#include <bcm63xx_cpu.h>
+#include <bcm63xx_dev_hsspi.h>
+#include <bcm63xx_regs.h>
+
+static struct resource spi_resources[] = {
+	{
+		.start		= -1, /* filled at runtime */
+		.end		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device bcm63xx_hsspi_device = {
+	.name		= "bcm63xx-hsspi",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(spi_resources),
+	.resource	= spi_resources,
+};
+
+int __init bcm63xx_hsspi_register(void)
+{
+	if (!BCMCPU_IS_6328() && !BCMCPU_IS_6362())
+		return -ENODEV;
+
+	spi_resources[0].start = bcm63xx_regset_address(RSET_HSSPI);
+	spi_resources[0].end = spi_resources[0].start;
+	spi_resources[0].end += RSET_HSSPI_SIZE - 1;
+	spi_resources[1].start = bcm63xx_get_irq_number(IRQ_HSSPI);
+
+	return platform_device_register(&bcm63xx_hsspi_device);
+}
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_hsspi.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_hsspi.h
new file mode 100644
index 0000000..1b1acaf
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_hsspi.h
@@ -0,0 +1,8 @@
+#ifndef BCM63XX_DEV_HSSPI_H
+#define BCM63XX_DEV_HSSPI_H
+
+#include <linux/types.h>
+
+int bcm63xx_hsspi_register(void);
+
+#endif /* BCM63XX_DEV_HSSPI_H */
-- 
1.8.4.rc3
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
