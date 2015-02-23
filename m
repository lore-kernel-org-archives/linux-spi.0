From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 1/1] spi: dw-pci: correct number of chip selects
Date: Mon, 23 Feb 2015 17:55:54 +0200
Message-ID: <1424706954-6055-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The commit d58cf5ff6500 brought a second controller to the list of supported
devices and changed a number of the chip selects. Besides the previous number
was wrong anyway the mentioned patch makes it wrong again meanwhile has a
proper numbers in the commit message. Indeed, SPI1 has 5 bits and SPI2 has 2
bits, but it does not mean to have power of two of this bits as a possible
number of the chip selects. So, this patch fixes it eventually.

Fixes: d58cf5ff6500 (spi: dw-pci: describe Intel MID controllers better)
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw-pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 5ba3310..6d331e0 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -36,13 +36,13 @@ struct spi_pci_desc {
 
 static struct spi_pci_desc spi_pci_mid_desc_1 = {
 	.setup = dw_spi_mid_init,
-	.num_cs = 32,
+	.num_cs = 5,
 	.bus_num = 0,
 };
 
 static struct spi_pci_desc spi_pci_mid_desc_2 = {
 	.setup = dw_spi_mid_init,
-	.num_cs = 4,
+	.num_cs = 2,
 	.bus_num = 1,
 };
 
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
