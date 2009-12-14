From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: [PATCH] xilinx_spi.c: use resource_size()
Date: Mon, 14 Dec 2009 17:48:59 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090200EA93@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "David Brownell" <dbrownell@users.sourceforge.net>
To: "kernel list" <linux-kernel@vger.kernel.org>,
	<spi-devel-general@lists.sourceforge.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758676AbZLNWtB@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Use resource_size().

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>

---

diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
index 5a143b9..32525e6 100644
--- a/drivers/spi/xilinx_spi.c
+++ b/drivers/spi/xilinx_spi.c
@@ -332,14 +332,14 @@ static int __init xilinx_spi_of_probe(struct of_device *ofdev,
 
 	xspi->irq = r_irq->start;
 
-	if (!request_mem_region(r_mem->start,
-			r_mem->end - r_mem->start + 1, XILINX_SPI_NAME)) {
+	if (!request_mem_region(r_mem->start, resource_size(r_mem),
+			XILINX_SPI_NAME)) {
 		rc = -ENXIO;
 		dev_warn(&ofdev->dev, "memory request failure\n");
 		goto put_master;
 	}
 
-	xspi->regs = ioremap(r_mem->start, r_mem->end - r_mem->start + 1);
+	xspi->regs = ioremap(r_mem->start, resource_size(r_mem));
 	if (xspi->regs == NULL) {
 		rc = -ENOMEM;
 		dev_warn(&ofdev->dev, "ioremap failure\n"); 
