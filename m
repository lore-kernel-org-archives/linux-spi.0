From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] spi: dw-pci: fix bug when regs left uninitialized
Date: Wed, 27 Aug 2014 16:21:12 +0300
Message-ID: <1409145672-10258-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	<stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The commit 04f421e7 "spi: dw: use managed resources" changes drivers to use
managed functions, but seems wasn't properly tested in PCI case. The regs field
of struct dw_spi left uninitialized. Thus, kernel crashes when tries to access
to the SPI controller registers. This patch fixes the issue.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # v3.14+
---
 drivers/spi/spi-dw-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index e203d8f..473bd52 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -59,6 +59,8 @@ static int spi_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
+	dws->regs = pcim_iomap_table(pdev)[pci_bar];
+
 	dws->bus_num = 0;
 	dws->num_cs = 4;
 	dws->irq = pdev->irq;
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
