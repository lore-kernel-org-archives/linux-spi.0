From: Markos Chandras <markos.chandras-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] SPI: spi-au1550: Fix build problem in au1550_spi_remove
Date: Wed, 20 Aug 2014 15:40:13 +0100
Message-ID: <1408545613-28348-1-git-send-email-markos.chandras@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Markos Chandras <markos.chandras-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Himangi Saraogi <himangi774-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
To: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Commit 30670539b867 ("spi: au1550: Fix bug in deallocation of memory")
switched from release_resource to release_mem_region to release
memory regions allocated using the request_mem_region. However,
a build problem was introduced due to 'r' being undefined in that
function. We fix this by having 'r' being defined as the platform's
IORESROUCE_MEM region.

This fixes a problem triggered by the db1xxx defconfig in the MIPS tree:

drivers/spi/spi-au1550.c: In function 'au1550_spi_remove':
drivers/spi/spi-au1550.c:948:21: error: 'r' undeclared (first use in this
							function)
release_mem_region(r->start, sizeof(psc_spi_t));

Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Himangi Saraogi <himangi774-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
Signed-off-by: Markos Chandras <markos.chandras-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
---
This has only been compile tested
---
 drivers/spi/spi-au1550.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-au1550.c b/drivers/spi/spi-au1550.c
index 40c3d43c9292..f7edb504df78 100644
--- a/drivers/spi/spi-au1550.c
+++ b/drivers/spi/spi-au1550.c
@@ -937,6 +937,7 @@ err_nomem:
 
 static int au1550_spi_remove(struct platform_device *pdev)
 {
+	struct resource *r;
 	struct au1550_spi *hw = platform_get_drvdata(pdev);
 
 	dev_info(&pdev->dev, "spi master remove: bus_num=%d\n",
@@ -945,6 +946,13 @@ static int au1550_spi_remove(struct platform_device *pdev)
 	spi_bitbang_stop(&hw->bitbang);
 	free_irq(hw->irq, hw);
 	iounmap((void __iomem *)hw->regs);
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		dev_err(&pdev->dev, "no mmio resource\n");
+		return -ENODEV;
+	}
+
 	release_mem_region(r->start, sizeof(psc_spi_t));
 
 	if (hw->usedma) {
-- 
2.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
