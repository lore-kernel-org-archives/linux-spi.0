From: Manuel Lauss <manuel.lauss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: spi-au1550: fix build failure
Date: Tue, 19 Aug 2014 19:18:44 +0200
Message-ID: <1408468724-34602-1-git-send-email-manuel.lauss@gmail.com>
Cc: Himangi Saraogi <himangi774-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Manuel Lauss <manuel.lauss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Fix a build failure introduced with commit 30670539b86
(spi: au1550: Fix bug in deallocation of memory)

Signed-off-by: Manuel Lauss <manuel.lauss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Please consider for 3.17, compile and runtested.

 drivers/spi/spi-au1550.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-au1550.c b/drivers/spi/spi-au1550.c
index 40c3d43..f40b34c 100644
--- a/drivers/spi/spi-au1550.c
+++ b/drivers/spi/spi-au1550.c
@@ -945,7 +945,7 @@ static int au1550_spi_remove(struct platform_device *pdev)
 	spi_bitbang_stop(&hw->bitbang);
 	free_irq(hw->irq, hw);
 	iounmap((void __iomem *)hw->regs);
-	release_mem_region(r->start, sizeof(psc_spi_t));
+	release_mem_region(hw->ioarea->start, sizeof(psc_spi_t));
 
 	if (hw->usedma) {
 		au1550_spi_dma_rxtmp_free(hw);
-- 
2.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
