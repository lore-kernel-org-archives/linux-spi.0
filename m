From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH] spi: add spi-loopback-test to build framework
Date: Fri, 27 Nov 2015 16:17:21 +0000
Message-ID: <1448641042-4722-1-git-send-email-kernel@martin.sperl.org>
References: <1448632564-2381-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448632564-2381-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

adding the spi-loopback-test module to Kconfig and Makefile

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/Kconfig  |    9 +++++++++
 drivers/spi/Makefile |    1 +
 2 files changed, 10 insertions(+)

Forgot to add the build infrastructure to ther patch...

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 8b9c2a3..0876d59 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -689,6 +689,15 @@ config SPI_SPIDEV
 	  Note that this application programming interface is EXPERIMENTAL
 	  and hence SUBJECT TO CHANGE WITHOUT NOTICE while it stabilizes.
 
+config SPI_LOOPBACK_TEST
+	tristate "spi loopback test framework support"
+	depends on m
+	help
+	  This enables the SPI loopback testing framework driver
+
+	  primarily used for development of spi_master drivers
+	  and to detect regressions
+
 config SPI_TLE62X0
 	tristate "Infineon TLE62X0 (for power switching)"
 	depends on SYSFS
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 31fb7fb..8991ffc 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -8,6 +8,7 @@ ccflags-$(CONFIG_SPI_DEBUG) := -DDEBUG
 # config declarations into driver model code
 obj-$(CONFIG_SPI_MASTER)		+= spi.o
 obj-$(CONFIG_SPI_SPIDEV)		+= spidev.o
+obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
 
 # SPI master controller drivers (bus)
 obj-$(CONFIG_SPI_ALTERA)		+= spi-altera.o
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
