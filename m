From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/2] spi: pxa2xx: Use ACPI_COMPANION() instead of acpi_bus_get_device()
Date: Fri, 25 Sep 2015 10:27:18 +0300
Message-ID: <1443166038-31658-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1443166038-31658-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>
To: linux-spi@vger.kernel.org
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1443166038-31658-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Get pointer to the struct acpi_device by using ACPI_COMPANION() macro. This
is more efficient than using ACPI_HANDLE() and acpi_bus_get_device().

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 36cbb0f10856..6f834e5b0547 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1316,8 +1316,8 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
 	const struct pci_device_id *pcidev_id = NULL;
 	int devid, type;
 
-	if (!ACPI_HANDLE(&pdev->dev) ||
-	    acpi_bus_get_device(ACPI_HANDLE(&pdev->dev), &adev))
+	adev = ACPI_COMPANION(&pdev->dev);
+	if (!adev)
 		return NULL;
 
 	if (dev_is_pci(pdev->dev.parent))
-- 
2.5.3

