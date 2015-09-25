From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Use ACPI_COMPANION() instead of acpi_bus_get_device()" to the spi tree
Date: Fri, 25 Sep 2015 09:55:43 -0700
Message-ID: <E1ZfWHf-0001Xc-M0@finisterre>
References: <1443166038-31658-2-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1443166038-31658-2-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Use ACPI_COMPANION() instead of acpi_bus_get_device()

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

>From b9f6940a437dcb8481df16b175359e126cf7bc33 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Fri, 25 Sep 2015 10:27:18 +0300
Subject: [PATCH] spi: pxa2xx: Use ACPI_COMPANION() instead of
 acpi_bus_get_device()

Get pointer to the struct acpi_device by using ACPI_COMPANION() macro. This
is more efficient than using ACPI_HANDLE() and acpi_bus_get_device().

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 0e075db..aed9aab 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1312,8 +1312,8 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
 	const struct pci_device_id *pcidev_id = NULL;
 	int devid, type;
 
-	if (!ACPI_HANDLE(&pdev->dev) ||
-	    acpi_bus_get_device(ACPI_HANDLE(&pdev->dev), &adev))
+	adev = ACPI_COMPANION(&pdev->dev);
+	if (!adev)
 		return NULL;
 
 	if (dev_is_pci(pdev->dev.parent))
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
