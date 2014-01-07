From: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH -next] spi: dw-pci: remove free for resources allocated with devm_*
Date: Tue, 7 Jan 2014 21:36:24 +0800
Message-ID: <CAPgLHd9tVkshm+T-emPowGZT6_tNZHnBSMvhLeeQw3Ti-SytvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>

It's not necessary to free resources allocated with devm_*
and free them may lead to double free.

Fixes: 04f421e7b0b1 ('spi: dw: use managed resources')
Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
---
 drivers/spi/spi-dw-pci.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index a98f64d..3f3dc12 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -91,10 +91,6 @@ static void spi_pci_remove(struct pci_dev *pdev)
 	struct dw_spi_pci *dwpci = pci_get_drvdata(pdev);
 
 	dw_spi_remove_host(&dwpci->dws);
-	iounmap(dwpci->dws.regs);
-	pci_release_region(pdev, 0);
-	kfree(dwpci);
-	pci_disable_device(pdev);
 }
 
 #ifdef CONFIG_PM

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
