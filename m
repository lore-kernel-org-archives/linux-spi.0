From: Adam Ford <aford173@gmail.com>
Subject: [PATCH 2/5] spi: fspi: dynamically alloc AHB memory
Date: Sun, 26 Jan 2020 08:09:09 -0600
Message-ID: <20200126140913.2139260-2-aford173@gmail.com>
References: <20200126140913.2139260-1-aford173@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: han.xu@nxp.com, Adam Ford <aford173@gmail.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
To: linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200126140913.2139260-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Han Xu <han.xu@nxp.com>

Apply patch from NXP upstream repo to
dynamically allocate AHB memory as needed.

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Han Xu <han.xu@nxp.com>

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 00c7899428a1..23abf5ae318e 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -307,6 +307,7 @@
 
 #define POLL_TOUT		5000
 #define NXP_FSPI_MAX_CHIPSELECT		4
+#define NXP_FSPI_MIN_IOMAP	SZ_4M
 
 struct nxp_fspi_devtype_data {
 	unsigned int rxfifo;
@@ -345,6 +346,8 @@ struct nxp_fspi {
 	void __iomem *ahb_addr;
 	u32 memmap_phy;
 	u32 memmap_phy_size;
+	u32 memmap_start;
+	u32 memmap_len;
 	struct clk *clk, *clk_en;
 	struct device *dev;
 	struct completion c;
@@ -657,12 +660,35 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi)
 	f->selected = spi->chip_select;
 }
 
-static void nxp_fspi_read_ahb(struct nxp_fspi *f, const struct spi_mem_op *op)
+static int nxp_fspi_read_ahb(struct nxp_fspi *f, const struct spi_mem_op *op)
 {
+	u32 start = op->addr.val;
 	u32 len = op->data.nbytes;
 
+	/* if necessary, ioremap before AHB read */
+	if ((!f->ahb_addr) || start < f->memmap_start ||
+	     start + len > f->memmap_start + f->memmap_len) {
+		if (f->ahb_addr)
+			iounmap(f->ahb_addr);
+
+		f->memmap_start = start;
+		f->memmap_len = len > NXP_FSPI_MIN_IOMAP ?
+				len : NXP_FSPI_MIN_IOMAP;
+
+		f->ahb_addr = ioremap_wc(f->memmap_phy + f->memmap_start,
+					 f->memmap_len);
+
+		if (!f->ahb_addr) {
+			dev_err(f->dev, "failed to alloc memory\n");
+			return -ENOMEM;
+		}
+	}
+
 	/* Read out the data directly from the AHB buffer. */
-	memcpy_fromio(op->data.buf.in, (f->ahb_addr + op->addr.val), len);
+	memcpy_fromio(op->data.buf.in,
+		      f->ahb_addr + start - f->memmap_start, len);
+
+	return 0;
 }
 
 static void nxp_fspi_fill_txfifo(struct nxp_fspi *f,
@@ -822,7 +848,7 @@ static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	 */
 	if (op->data.nbytes > (f->devtype_data->rxfifo - 4) &&
 	    op->data.dir == SPI_MEM_DATA_IN) {
-		nxp_fspi_read_ahb(f, op);
+		err = nxp_fspi_read_ahb(f, op);
 	} else {
 		if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
 			nxp_fspi_fill_txfifo(f, op);
@@ -992,9 +1018,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 
 	/* find the resources - controller memory mapped space */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fspi_mmap");
-	f->ahb_addr = devm_ioremap_resource(dev, res);
-	if (IS_ERR(f->ahb_addr)) {
-		ret = PTR_ERR(f->ahb_addr);
+	if (IS_ERR(res)) {
+		ret = PTR_ERR(res);
 		goto err_put_ctrl;
 	}
 
@@ -1073,6 +1098,9 @@ static int nxp_fspi_remove(struct platform_device *pdev)
 
 	mutex_destroy(&f->lock);
 
+	if (f->ahb_addr)
+		iounmap(f->ahb_addr);
+
 	return 0;
 }
 
-- 
2.24.0
