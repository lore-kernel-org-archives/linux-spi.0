From: han.xu@nxp.com
Subject: [PATCH 3/3] spi: spi-fsl-qspi: dynamically alloc AHB memory for QSPI
Date: Wed, 10 Jul 2019 10:31:28 +0800
Message-ID: <20190710023128.13115-4-han.xu@nxp.com>
References: <20190710023128.13115-1-han.xu@nxp.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
To: han.xu@nxp.com, broonie@kernel.org, ashish.kumar@nxp.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190710023128.13115-1-han.xu@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Han Xu <han.xu@nxp.com>

dynamically alloc AHB memory for QSPI controller.

Signed-off-by: Han Xu <han.xu@nxp.com>
---
 drivers/spi/spi-fsl-qspi.c | 58 +++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 1d08c60e5ae2..f7795e071eb6 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -181,6 +181,8 @@
  */
 #define QUADSPI_QUIRK_BASE_INTERNAL	BIT(4)
 
+#define QUADSPI_MIN_IOMAP		SZ_4M
+
 struct fsl_qspi_devtype_data {
 	unsigned int rxfifo;
 	unsigned int txfifo;
@@ -241,6 +243,9 @@ struct fsl_qspi {
 	void __iomem *iobase;
 	void __iomem *ahb_addr;
 	u32 memmap_phy;
+	u32 memmap_phy_size;
+	u32 memmap_start;
+	u32 memmap_len;
 	struct clk *clk, *clk_en;
 	struct device *dev;
 	struct completion c;
@@ -519,11 +524,34 @@ static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device *spi)
 	fsl_qspi_invalidate(q);
 }
 
-static void fsl_qspi_read_ahb(struct fsl_qspi *q, const struct spi_mem_op *op)
+static int fsl_qspi_read_ahb(struct fsl_qspi *q, const struct spi_mem_op *op)
 {
+	u32 start = op->addr.val + q->selected * q->memmap_phy_size;
+	u32 len = op->data.nbytes;
+
+	/* if necessary, ioremap before AHB read */
+	if ((!q->ahb_addr) || start < q->memmap_start ||
+	    start + len > q->memmap_start + q->memmap_len) {
+		if (q->ahb_addr) {
+			iounmap(q->ahb_addr);
+		}
+
+		q->memmap_start = start;
+		q->memmap_len = len > QUADSPI_MIN_IOMAP ?
+				len : QUADSPI_MIN_IOMAP;
+
+		q->ahb_addr = ioremap_wc(q->memmap_phy + q->memmap_start,
+					 q->memmap_len);
+		if (!q->ahb_addr) {
+			dev_err(q->dev, "failed to alloc memory\n");
+			return -ENOMEM;
+		}
+	}
+
 	memcpy_fromio(op->data.buf.in,
-		      q->ahb_addr + q->selected * q->devtype_data->ahb_buf_size,
-		      op->data.nbytes);
+		      q->ahb_addr + start - q->memmap_start, len);
+
+	return 0;
 }
 
 static void fsl_qspi_fill_txfifo(struct fsl_qspi *q,
@@ -647,7 +675,7 @@ static int fsl_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	 */
 	if (op->data.nbytes > (q->devtype_data->rxfifo - 4) &&
 	    op->data.dir == SPI_MEM_DATA_IN) {
-		fsl_qspi_read_ahb(q, op);
+		err = fsl_qspi_read_ahb(q, op);
 	} else {
 		qspi_writel(q, QUADSPI_RBCT_WMRK_MASK |
 			    QUADSPI_RBCT_RXBRD_USEIPS, base + QUADSPI_RBCT);
@@ -735,16 +763,16 @@ static int fsl_qspi_default_setup(struct fsl_qspi *q)
 	 * In HW there can be a maximum of four chips on two buses with
 	 * two chip selects on each bus. We use four chip selects in SW
 	 * to differentiate between the four chips.
-	 * We use ahb_buf_size for each chip and set SFA1AD, SFA2AD, SFB1AD,
-	 * SFB2AD accordingly.
+	 * We divide the total memory region size equally for each chip
+	 * and set SFA1AD, SFA2AD, SFB1AD, SFB2AD accordingly.
 	 */
-	qspi_writel(q, q->devtype_data->ahb_buf_size + addr_offset,
+	qspi_writel(q, q->memmap_phy_size / 4 + addr_offset,
 		    base + QUADSPI_SFA1AD);
-	qspi_writel(q, q->devtype_data->ahb_buf_size * 2 + addr_offset,
+	qspi_writel(q, q->memmap_phy_size / 4 * 2 + addr_offset,
 		    base + QUADSPI_SFA2AD);
-	qspi_writel(q, q->devtype_data->ahb_buf_size * 3 + addr_offset,
+	qspi_writel(q, q->memmap_phy_size / 4 * 3 + addr_offset,
 		    base + QUADSPI_SFB1AD);
-	qspi_writel(q, q->devtype_data->ahb_buf_size * 4 + addr_offset,
+	qspi_writel(q, q->memmap_phy_size / 4 * 4 + addr_offset,
 		    base + QUADSPI_SFB2AD);
 
 	q->selected = -1;
@@ -831,13 +859,8 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 					"QuadSPI-memory");
-	q->ahb_addr = devm_ioremap_resource(dev, res);
-	if (IS_ERR(q->ahb_addr)) {
-		ret = PTR_ERR(q->ahb_addr);
-		goto err_put_ctrl;
-	}
-
 	q->memmap_phy = res->start;
+	q->memmap_phy_size = resource_size(res);
 
 	/* find the clocks */
 	q->clk_en = devm_clk_get(dev, "qspi_en");
@@ -913,6 +936,9 @@ static int fsl_qspi_remove(struct platform_device *pdev)
 
 	mutex_destroy(&q->lock);
 
+	if (q->ahb_addr)
+		iounmap(q->ahb_addr);
+
 	return 0;
 }
 
-- 
2.17.1
