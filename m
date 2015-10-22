From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 3/7] spi: pxa2xx: Convert unique ID string of ACPI device as unsigned integer
Date: Thu, 22 Oct 2015 16:44:41 +0300
Message-ID: <1445521485-2029-3-git-send-email-jarkko.nikula@linux.intel.com>
References: <1445521485-2029-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445521485-2029-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Andy noticed numeric unique device ID is unsigned integer so convert it
using kstrtouint(). Actually integer in ACPI 2.0 and later is 64 bits
litte-endian unsigned integer but quite certainly having so big value here
would mean something extra than just the SPI bus number so it won't hurt to
assume only lower 32 bits carry the bus number for now.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index e02ea46168eb..48fdcb6a7f79 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1309,7 +1309,8 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
 	struct resource *res;
 	const struct acpi_device_id *adev_id = NULL;
 	const struct pci_device_id *pcidev_id = NULL;
-	int devid, type;
+	unsigned int devid;
+	int type;
 
 	adev = ACPI_COMPANION(&pdev->dev);
 	if (!adev)
@@ -1356,7 +1357,7 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
 	ssp->pdev = pdev;
 
 	ssp->port_id = -1;
-	if (adev->pnp.unique_id && !kstrtoint(adev->pnp.unique_id, 0, &devid))
+	if (adev->pnp.unique_id && !kstrtouint(adev->pnp.unique_id, 0, &devid))
 		ssp->port_id = devid;
 
 	pdata->num_chipselect = 1;
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
