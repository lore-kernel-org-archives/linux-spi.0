From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: add spi-loopback-test to build framework" to the spi tree
Date: Sat, 12 Dec 2015 23:08:03 +0000
Message-ID: <E1a7tGl-0002rY-Su@finisterre>
References: <1448641042-4722-1-git-send-email-kernel@martin.sperl.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448641042-4722-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: add spi-loopback-test to build framework

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

>From 97896195b3f7a6bcbfd52fd920cab5a3df2c5445 Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Date: Fri, 27 Nov 2015 16:17:21 +0000
Subject: [PATCH] spi: add spi-loopback-test to build framework

adding the spi-loopback-test module to Kconfig and Makefile

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/Kconfig  | 9 +++++++++
 drivers/spi/Makefile | 1 +
 2 files changed, 10 insertions(+)

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
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
