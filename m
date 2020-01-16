From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] spi: pxa2xx: Add support for Intel Comet Lake PCH-V
Date: Thu, 16 Jan 2020 11:10:35 +0200
Message-ID: <20200116091035.575175-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add support for Intel Comet Lake PCH-V which has the same LPSS than on
Intel Kaby lake unlike other Intel Comet Lake PCH variants that are based
on Intel Cannon Lake PCH LPSS.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 9071333ebdd8..7289fb3302d5 100644
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
2.24.1
