From: Himangi Saraogi <himangi774-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: au1550: Fix bug in deallocation of memory
Date: Fri, 4 Jul 2014 23:09:49 +0530
Message-ID: <20140704173949.GA8558@himangi-Dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: julia.lawall-L2FTfq7BK8M@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TZUIDd8j+nm9g@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch fixes a bug on the deallocation of memory allocated using
request_mem_region, by using release_mem_region instead of
release_resource and kfree.

Signed-off-by: Himangi Saraogi <himangi774-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-au1550.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-au1550.c b/drivers/spi/spi-au1550.c
index 67375a1..fb61464 100644
--- a/drivers/spi/spi-au1550.c
+++ b/drivers/spi/spi-au1550.c
@@ -925,8 +925,7 @@ err_no_txdma:
 	iounmap((void __iomem *)hw->regs);
 
 err_ioremap:
-	release_resource(hw->ioarea);
-	kfree(hw->ioarea);
+	release_mem_region(r->start, sizeof(psc_spi_t));
 
 err_no_iores:
 err_no_pdata:
@@ -946,8 +945,7 @@ static int au1550_spi_remove(struct platform_device *pdev)
 	spi_bitbang_stop(&hw->bitbang);
 	free_irq(hw->irq, hw);
 	iounmap((void __iomem *)hw->regs);
-	release_resource(hw->ioarea);
-	kfree(hw->ioarea);
+	release_mem_region(r->start, sizeof(psc_spi_t));
 
 	if (hw->usedma) {
 		au1550_spi_dma_rxtmp_free(hw);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
