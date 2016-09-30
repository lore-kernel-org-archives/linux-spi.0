From: Vikram N <vicky773-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: omap2-mcspi: Fix modifying platform resource data
Date: Fri, 30 Sep 2016 19:53:11 +0530
Message-ID: <1475245427-4140-1-git-send-email-vicky773@gmail.com>
Cc: Vikram N <vicky773-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

currently during probe the resource data gets modified and device
physical address remains valid only during first load. If the module is
unloaded and loaded again, the ioremp will be done on a incorrect address
as the resource was modified during previous module load.
This patch fixes this issue.

Signed-off-by: Vikram N <vicky773-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index d5157b2..3567e1d 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1391,15 +1391,13 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 		goto free_master;
 	}
 
-	r->start += regs_offset;
-	r->end += regs_offset;
-	mcspi->phys = r->start;
-
 	mcspi->base = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(mcspi->base)) {
 		status = PTR_ERR(mcspi->base);
 		goto free_master;
 	}
+	mcspi->phys = r->start + regs_offset;
+	mcspi->base += regs_offset;
 
 	mcspi->dev = &pdev->dev;
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
