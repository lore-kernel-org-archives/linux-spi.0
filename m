From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] spi: pxa2xx: Add support for Intel Kaby Lake PCH-H
Date: Mon,  4 Jul 2016 13:21:07 +0300
Message-ID: <1467627667-63196-1-git-send-email-mika.westerberg@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Kaby Lake PCH-H has the same SPI host controller as Skylake. Add these new
PCI IDs to the list of supported devices.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index fe07c0592b44..c67e7b197e6e 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1389,6 +1389,9 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
 	/* SPT-H */
 	{ PCI_VDEVICE(INTEL, 0xa129), LPSS_SPT_SSP },
 	{ PCI_VDEVICE(INTEL, 0xa12a), LPSS_SPT_SSP },
+	/* KBL-H */
+	{ PCI_VDEVICE(INTEL, 0xa2a9), LPSS_SPT_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa2aa), LPSS_SPT_SSP },
 	/* BXT A-Step */
 	{ PCI_VDEVICE(INTEL, 0x0ac2), LPSS_BXT_SSP },
 	{ PCI_VDEVICE(INTEL, 0x0ac4), LPSS_BXT_SSP },
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
