From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] spi: pxa2xx: Add support for Intel Broxton B-Step
Date: Wed,  2 Mar 2016 09:54:14 +0200
Message-ID: <1456905254-32726-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Steve Sakoman <steve.sakoman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add support for third Intel Broxton variant and update comment for
A-Step variant.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Tested-by: Steve Sakoman <steve.sakoman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
Tested-by with commit 87ee91b80763 ("mfd: lpss: Add PCI IDs for Intel
Broxton B-Step platform") from linux-next. Both patches are needed in
order to get SPI host registered but otherwise they are independent.
---
 drivers/spi/spi-pxa2xx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 2c4e8ccd573b..85e59a406a4c 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1384,10 +1384,14 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
 	/* SPT-H */
 	{ PCI_VDEVICE(INTEL, 0xa129), LPSS_SPT_SSP },
 	{ PCI_VDEVICE(INTEL, 0xa12a), LPSS_SPT_SSP },
-	/* BXT */
+	/* BXT A-Step */
 	{ PCI_VDEVICE(INTEL, 0x0ac2), LPSS_BXT_SSP },
 	{ PCI_VDEVICE(INTEL, 0x0ac4), LPSS_BXT_SSP },
 	{ PCI_VDEVICE(INTEL, 0x0ac6), LPSS_BXT_SSP },
+	/* BXT B-Step */
+	{ PCI_VDEVICE(INTEL, 0x1ac2), LPSS_BXT_SSP },
+	{ PCI_VDEVICE(INTEL, 0x1ac4), LPSS_BXT_SSP },
+	{ PCI_VDEVICE(INTEL, 0x1ac6), LPSS_BXT_SSP },
 	/* APL */
 	{ PCI_VDEVICE(INTEL, 0x5ac2), LPSS_BXT_SSP },
 	{ PCI_VDEVICE(INTEL, 0x5ac4), LPSS_BXT_SSP },
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
