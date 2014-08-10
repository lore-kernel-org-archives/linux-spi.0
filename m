From: Manuel Lauss <manuel.lauss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: spi-au1550: fix build failure introduced in recent "bugfix"
Date: Sun, 10 Aug 2014 17:56:31 +0200
Message-ID: <1407686191-87706-1-git-send-email-manuel.lauss@gmail.com>
Cc: Manuel Lauss <manuel.lauss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Himangi Saraogi <himangi774-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Commit 30670539b867d08c1931abd4815699de5887ee58
(spi: au1550: Fix bug in deallocation of memory) replaced working lines
of code with an obvious and untested copy-paste leading to a build failure.

This patch fixes the "bugfix".

Cc: Himangi Saraogi <himangi774-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Manuel Lauss <manuel.lauss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
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
