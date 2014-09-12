From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 4/6] spi: dw-mid: remove Moorestown support
Date: Fri, 12 Sep 2014 15:11:59 +0300
Message-ID: <1410523921-16732-5-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1410523921-16732-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1410523921-16732-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The support of the Moorestown was removed [1] from kernel long time ago. This
is just a follow up of that change.

[1] http://www.spinics.net/lists/platform-driver-x86/msg02948.html

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/Kconfig      | 2 +-
 drivers/spi/spi-dw-mid.c | 8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 149d6f3..dc10453 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -600,7 +600,7 @@ config SPI_DW_PCI
 	depends on SPI_DESIGNWARE && PCI
 
 config SPI_DW_MID_DMA
-	bool "DMA support for DW SPI controller on Intel Moorestown platform"
+	bool "DMA support for DW SPI controller on Intel MID platform"
 	depends on SPI_DW_PCI && INTEL_MID_DMAC
 
 config SPI_DW_MMIO
diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 0d88e4a..deba3c4 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -50,11 +50,9 @@ static int mid_spi_dma_init(struct dw_spi *dws)
 
 	/*
 	 * Get pci device for DMA controller, currently it could only
-	 * be the DMA controller of either Moorestown or Medfield
+	 * be the DMA controller of Medfield
 	 */
-	dws->dmac = pci_get_device(PCI_VENDOR_ID_INTEL, 0x0813, NULL);
-	if (!dws->dmac)
-		dws->dmac = pci_get_device(PCI_VENDOR_ID_INTEL, 0x0827, NULL);
+	dws->dmac = pci_get_device(PCI_VENDOR_ID_INTEL, 0x0827, NULL);
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
@@ -192,7 +190,7 @@ static struct dw_spi_dma_ops mid_dma_ops = {
 };
 #endif
 
-/* Some specific info for SPI0 controller on Moorestown */
+/* Some specific info for SPI0 controller on Intel MID */
 
 /* HW info for MRST CLk Control Unit, one 32b reg */
 #define MRST_SPI_CLK_BASE	100000000	/* 100m */
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
