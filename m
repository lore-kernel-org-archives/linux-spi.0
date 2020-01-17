From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Add support for Intel Comet Lake PCH-V" to the spi tree
Date: Fri, 17 Jan 2020 15:44:24 +0000 (GMT)
Message-ID: <applied-20200116091035.575175-1-jarkko.nikula@linux.intel.com>
References: <20200116091035.575175-1-jarkko.nikula@linux.intel.com>
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200116091035.575175-1-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Add support for Intel Comet Lake PCH-V

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

>From 6157d4c255609da28f5a271ec1d56d74beb4c8be Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Thu, 16 Jan 2020 11:10:35 +0200
Subject: [PATCH] spi: pxa2xx: Add support for Intel Comet Lake PCH-V

Add support for Intel Comet Lake PCH-V which has the same LPSS than on
Intel Kaby lake unlike other Intel Comet Lake PCH variants that are based
on Intel Cannon Lake PCH LPSS.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Link: https://lore.kernel.org/r/20200116091035.575175-1-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index d58791d92c73..8114d3289fdc 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1423,6 +1423,9 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
 	/* KBL-H */
 	{ PCI_VDEVICE(INTEL, 0xa2a9), LPSS_SPT_SSP },
 	{ PCI_VDEVICE(INTEL, 0xa2aa), LPSS_SPT_SSP },
+	/* CML-V */
+	{ PCI_VDEVICE(INTEL, 0xa3a9), LPSS_SPT_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa3aa), LPSS_SPT_SSP },
 	/* BXT A-Step */
 	{ PCI_VDEVICE(INTEL, 0x0ac2), LPSS_BXT_SSP },
 	{ PCI_VDEVICE(INTEL, 0x0ac4), LPSS_BXT_SSP },
-- 
2.20.1
