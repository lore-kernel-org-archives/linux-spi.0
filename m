From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] spi: spi-sh: add IORESOURCE_MEM_TYPE_MASK decoding for access
 size
Date: Thu, 26 Jan 2012 17:43:57 +0900
Message-ID: <4F21124D.6030601@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	SH-Linux <linux-sh@vger.kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This SPI controller's access size is 32, or 8-bit. The previous driver
supported 32-bit only. So, this patch adds IORESOURCE_MEM_TYPE_MASK
decoding, an then, the driver can handle the SPI controller of 8-bit.
This patch also changes the readl/writel to ioread*/iowrite*.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/spi/spi-sh.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sh.c b/drivers/spi/spi-sh.c
index 70c8af9..79442c3 100644
--- a/drivers/spi/spi-sh.c
+++ b/drivers/spi/spi-sh.c
@@ -92,17 +92,26 @@ struct spi_sh_data {
 	unsigned long cr1;
 	wait_queue_head_t wait;
 	spinlock_t lock;
+	int width;
 };

 static void spi_sh_write(struct spi_sh_data *ss, unsigned long data,
 			     unsigned long offset)
 {
-	writel(data, ss->addr + offset);
+	if (ss->width == 8)
+		iowrite8(data, ss->addr + (offset >> 2));
+	else if (ss->width == 32)
+		iowrite32(data, ss->addr + offset);
 }

 static unsigned long spi_sh_read(struct spi_sh_data *ss, unsigned long offset)
 {
-	return readl(ss->addr + offset);
+	if (ss->width == 8)
+		return ioread8(ss->addr + (offset >> 2));
+	else if (ss->width == 32)
+		return ioread32(ss->addr + offset);
+	else
+		return 0;
 }

 static void spi_sh_set_bit(struct spi_sh_data *ss, unsigned long val,
@@ -464,6 +473,18 @@ static int __devinit spi_sh_probe(struct platform_device *pdev)
 	ss = spi_master_get_devdata(master);
 	dev_set_drvdata(&pdev->dev, ss);

+	switch (res->flags & IORESOURCE_MEM_TYPE_MASK) {
+	case IORESOURCE_MEM_8BIT:
+		ss->width = 8;
+		break;
+	case IORESOURCE_MEM_32BIT:
+		ss->width = 32;
+		break;
+	default:
+		dev_err(&pdev->dev, "No support width\n");
+		ret = -ENODEV;
+		goto error1;
+	}
 	ss->irq = irq;
 	ss->master = master;
 	ss->addr = ioremap(res->start, resource_size(res));
-- 
1.7.1
