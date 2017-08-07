From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fix building SPI_PXA on MMP" to the spi tree
Date: Mon, 07 Aug 2017 16:53:23 +0100
Message-ID: <E1dekLL-0005aP-FQ@debutante>
References: <20170807154409.205269-1-arnd@arndb.de>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Mika Westeberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
        Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170807154409.205269-1-arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fix building SPI_PXA on MMP

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

>From 128345b13d9b6a84d12f6b3c478e70acc21a96ac Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Date: Mon, 7 Aug 2017 17:42:55 +0200
Subject: [PATCH] spi: fix building SPI_PXA on MMP

When the audio driver selects CONFIG_PXA_SSP on ARCH_MMP as a
loadable module, and the PXA SPI driver is built-in, we get
a link error in the SPI driver:

drivers/spi/spi-pxa2xx.o: In function `pxa2xx_spi_remove':
spi-pxa2xx.c:(.text+0x5f0): undefined reference to `pxa_ssp_free'
drivers/spi/spi-pxa2xx.o: In function `pxa2xx_spi_probe':
spi-pxa2xx.c:(.text+0xeac): undefined reference to `pxa_ssp_request'
spi-pxa2xx.c:(.text+0x1468): undefined reference to `pxa_ssp_free'
spi-pxa2xx.c:(.text+0x15bc): undefined reference to `pxa_ssp_free'

The problem is that the PXA SPI driver only uses 'select SSP'
specifically when building it for PXA, but we can also build it
for PCI, which is meant for Intel x86 SoCs that use the same SPI
block. When the sound driver forces the SSP to be a loadable
module, the IS_ENABLED() check in include/linux/pxa2xx_ssp.h
triggers but the spi driver can't reference the exported symbols.

I had a different approach before, making the PCI case depend
on X86, which fixed the problem by avoiding the MMP case.

This goes a different route, making the driver select PXA_SSP
also on MMP, which has an SSP that none of the boards in mainline
Linux use for SPI. There is no harm in always enabling the build
on MMP (PCI or not PCI), so I do that too, to document that this
hardware is actually available on MMP.

Link: https://patchwork.kernel.org/patch/8879921/
Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 9b31351fe429..f9f9b0940746 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -518,8 +518,8 @@ config SPI_PPC4xx
 
 config SPI_PXA2XX
 	tristate "PXA2xx SSP SPI master"
-	depends on (ARCH_PXA || PCI || ACPI)
-	select PXA_SSP if ARCH_PXA
+	depends on (ARCH_PXA || ARCH_MMP || PCI || ACPI)
+	select PXA_SSP if ARCH_PXA || ARCH_MMP
 	help
 	  This enables using a PXA2xx or Sodaville SSP port as a SPI master
 	  controller. The driver can be configured to use any SSP port and
-- 
2.13.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
