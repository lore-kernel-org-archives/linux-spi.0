From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Convert unique ID string of ACPI device as unsigned integer" to the spi tree
Date: Fri, 23 Oct 2015 08:57:20 +0900
Message-ID: <E1ZpPjU-0002zc-5X@finisterre>
References: <1445521485-2029-3-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445521485-2029-3-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Convert unique ID string of ACPI device as unsigned integer

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

>From 3b8b6d05942ef5dd952674e7420600f762166e22 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Thu, 22 Oct 2015 16:44:41 +0300
Subject: [PATCH] spi: pxa2xx: Convert unique ID string of ACPI device as
 unsigned integer

Andy noticed numeric unique device ID is unsigned integer so convert it
using kstrtouint(). Actually integer in ACPI 2.0 and later is 64 bits
litte-endian unsigned integer but quite certainly having so big value here
would mean something extra than just the SPI bus number so it won't hurt to
assume only lower 32 bits carry the bus number for now.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 4fddc2a..db9016b 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1305,7 +1305,8 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
 	struct resource *res;
 	const struct acpi_device_id *adev_id = NULL;
 	const struct pci_device_id *pcidev_id = NULL;
-	int devid, type;
+	unsigned int devid;
+	int type;
 
 	adev = ACPI_COMPANION(&pdev->dev);
 	if (!adev)
@@ -1352,7 +1353,7 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
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
