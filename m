From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Wed, 9 Oct 2013 20:54:42 +0530
Message-ID: <1381332284-21822-2-git-send-email-sourav.poddar@ti.com>
References: <1381332284-21822-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
 Sourav Poddar <sourav.poddar@ti.com>, linux-mtd@lists.infradead.org,
 balbi@ti.com
To: <broonie@kernel.org>, <dwmw2@infradead.org>, <computersforpeace@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1381332284-21822-1-git-send-email-sourav.poddar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Qspi controller also supports memory mapped read. Patch
adds support for the same.
In memory mapped read, controller need to be switched to a
memory mapped port using a control module register and a qspi
specific register or just a qspi register.
Then the read need to be happened from the memory mapped
address space.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 drivers/spi/spi-ti-qspi.c |  140 ++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 125 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 0b71270..2722840 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -46,6 +46,8 @@ struct ti_qspi {
 
 	struct spi_master	*master;
 	void __iomem            *base;
+	void __iomem            *ctrl_base;
+	void __iomem            *mmap_base;
 	struct clk		*fclk;
 	struct device           *dev;
 
@@ -54,6 +56,9 @@ struct ti_qspi {
 	u32 spi_max_frequency;
 	u32 cmd;
 	u32 dc;
+
+	bool memory_mapped;
+	bool ctrl_mod;
 };
 
 #define QSPI_PID			(0x0)
@@ -109,6 +114,23 @@ struct ti_qspi {
 #define QSPI_CSPOL(n)			(1 << (1 + n * 8))
 #define QSPI_CKPOL(n)			(1 << (n * 8))
 
+#define	MM_SWITCH	0x01
+#define	MEM_CS		0x100
+#define	MEM_CS_DIS	0xfffff0ff
+
+#define	QSPI_CMD_RD		(0x3 << 0)
+#define	QSPI_CMD_DUAL_RD	(0x3b << 0)
+#define	QSPI_CMD_QUAD_RD	(0x6b << 0)
+#define	QSPI_CMD_READ_FAST	(0x0b << 0)
+#define	QSPI_SETUP0_A_BYTES	(0x3 << 8)
+#define	QSPI_SETUP0_NO_BITS	(0x0 << 10)
+#define	QSPI_SETUP0_8_BITS	(0x1 << 10)
+#define	QSPI_SETUP0_RD_NORMAL	(0x0 << 12)
+#define	QSPI_SETUP0_RD_DUAL	(0x1 << 12)
+#define	QSPI_SETUP0_RD_QUAD	(0x3 << 12)
+#define	QSPI_CMD_WRITE		(0x2 << 16)
+#define	QSPI_NUM_DUMMY_BITS	(0x0 << 24)
+
 #define	QSPI_FRAME			4096
 
 #define QSPI_AUTOSUSPEND_TIMEOUT         2000
@@ -125,12 +147,37 @@ static inline void ti_qspi_write(struct ti_qspi *qspi,
 	writel(val, qspi->base + reg);
 }
 
+void enable_qspi_memory_mapped(struct ti_qspi *qspi)
+{
+	u32 val;
+
+	ti_qspi_write(qspi, MM_SWITCH, QSPI_SPI_SWITCH_REG);
+	if (qspi->ctrl_mod) {
+		val = readl(qspi->ctrl_base);
+		val |= MEM_CS;
+		writel(val, qspi->ctrl_base);
+	}
+}
+
+void disable_qspi_memory_mapped(struct ti_qspi *qspi)
+{
+	u32 val;
+
+	ti_qspi_write(qspi, ~MM_SWITCH, QSPI_SPI_SWITCH_REG);
+	if (qspi->ctrl_mod) {
+		val = readl(qspi->ctrl_base);
+		val |= MEM_CS_DIS;
+		writel(val, qspi->ctrl_base);
+	}
+}
+
 static int ti_qspi_setup(struct spi_device *spi)
 {
 	struct ti_qspi	*qspi = spi_master_get_devdata(spi->master);
 	struct ti_qspi_regs *ctx_reg = &qspi->ctx_reg;
 	int clk_div = 0, ret;
-	u32 clk_ctrl_reg, clk_rate, clk_mask;
+	u32 clk_ctrl_reg, clk_rate, clk_mask, memval = 0;
+	qspi->dc = 0;
 
 	if (spi->master->busy) {
 		dev_dbg(qspi->dev, "master busy doing other trasnfers\n");
@@ -178,6 +225,37 @@ static int ti_qspi_setup(struct spi_device *spi)
 	ti_qspi_write(qspi, clk_mask, QSPI_SPI_CLOCK_CNTRL_REG);
 	ctx_reg->clkctrl = clk_mask;
 
+	if (spi->mode & SPI_CPHA)
+		qspi->dc |= QSPI_CKPHA(spi->chip_select);
+	if (spi->mode & SPI_CPOL)
+		qspi->dc |= QSPI_CKPOL(spi->chip_select);
+	if (spi->mode & SPI_CS_HIGH)
+		qspi->dc |= QSPI_CSPOL(spi->chip_select);
+
+	ti_qspi_write(qspi, qspi->dc, QSPI_SPI_DC_REG);
+
+	if (qspi->memory_mapped) {
+		switch (spi->mode) {
+		case SPI_TX_DUAL:
+			memval |= (QSPI_CMD_DUAL_RD | QSPI_SETUP0_A_BYTES |
+				QSPI_SETUP0_8_BITS | QSPI_SETUP0_RD_DUAL |
+				QSPI_CMD_WRITE | QSPI_NUM_DUMMY_BITS);
+			break;
+		case SPI_TX_QUAD:
+			memval |= (QSPI_CMD_QUAD_RD | QSPI_SETUP0_A_BYTES |
+				QSPI_SETUP0_8_BITS | QSPI_SETUP0_RD_QUAD |
+				QSPI_CMD_WRITE | QSPI_NUM_DUMMY_BITS);
+			break;
+		default:
+			memval |= (QSPI_CMD_RD | QSPI_SETUP0_A_BYTES |
+				QSPI_SETUP0_NO_BITS | QSPI_SETUP0_RD_NORMAL |
+				QSPI_CMD_WRITE | QSPI_NUM_DUMMY_BITS);
+			break;
+		}
+		ti_qspi_write(qspi, memval, QSPI_SPI_SETUP0_REG);
+		spi->mode |= SPI_RX_MMAP;
+	}
+
 	pm_runtime_mark_last_busy(qspi->dev);
 	ret = pm_runtime_put_autosuspend(qspi->dev);
 	if (ret < 0) {
@@ -340,16 +418,7 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,
 	struct spi_transfer *t;
 	int status = 0, ret;
 	int frame_length;
-
-	/* setup device control reg */
-	qspi->dc = 0;
-
-	if (spi->mode & SPI_CPHA)
-		qspi->dc |= QSPI_CKPHA(spi->chip_select);
-	if (spi->mode & SPI_CPOL)
-		qspi->dc |= QSPI_CKPOL(spi->chip_select);
-	if (spi->mode & SPI_CS_HIGH)
-		qspi->dc |= QSPI_CSPOL(spi->chip_select);
+	size_t from = 0;
 
 	frame_length = (m->frame_length << 3) / spi->bits_per_word;
 
@@ -362,11 +431,21 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,
 	qspi->cmd |= QSPI_WC_CMD_INT_EN;
 
 	ti_qspi_write(qspi, QSPI_WC_INT_EN, QSPI_INTR_ENABLE_SET_REG);
-	ti_qspi_write(qspi, qspi->dc, QSPI_SPI_DC_REG);
 
 	mutex_lock(&qspi->list_lock);
 
 	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (t->memory_map) {
+			if (t->tx_buf) {
+				from = t->len;
+				continue;
+			}
+			enable_qspi_memory_mapped(qspi);
+			memcpy(t->rx_buf, qspi->mmap_base + from, t->len);
+			disable_qspi_memory_mapped(qspi);
+			goto out;
+		}
+
 		qspi->cmd |= QSPI_WLEN(t->bits_per_word);
 
 		ret = qspi_transfer_msg(qspi, t);
@@ -379,6 +458,7 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,
 		m->actual_length += t->len;
 	}
 
+out:
 	mutex_unlock(&qspi->list_lock);
 
 	m->status = status;
@@ -437,7 +517,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 {
 	struct  ti_qspi *qspi;
 	struct spi_master *master;
-	struct resource         *r;
+	struct resource         *r, *res_ctrl, *res_mmap;
 	struct device_node *np = pdev->dev.of_node;
 	u32 max_freq;
 	int ret = 0, num_cs, irq;
@@ -446,7 +526,8 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
+					SPI_RX_MMAP;
 
 	master->bus_num = -1;
 	master->flags = SPI_MASTER_HALF_DUPLEX;
@@ -465,7 +546,16 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	qspi->master = master;
 	qspi->dev = &pdev->dev;
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_base");
+	if (r == NULL) {
+		dev_err(&pdev->dev, "missing platform resources data\n");
+		return -ENODEV;
+	}
+
+	res_mmap = platform_get_resource_byname(pdev,
+				IORESOURCE_MEM, "qspi_mmap");
+	res_ctrl = platform_get_resource_byname(pdev,
+				IORESOURCE_MEM, "qspi_ctrlmod");
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -481,6 +571,23 @@ static int ti_qspi_probe(struct platform_device *pdev)
 		goto free_master;
 	}
 
+	if (res_ctrl) {
+		qspi->ctrl_mod = true;
+		qspi->ctrl_base = devm_ioremap_resource(&pdev->dev, res_ctrl);
+		if (IS_ERR(qspi->ctrl_base)) {
+			ret = PTR_ERR(qspi->ctrl_base);
+			goto free_master;
+		}
+	}
+
+	if (res_mmap) {
+		qspi->mmap_base = devm_ioremap_resource(&pdev->dev, res_mmap);
+		if (IS_ERR(qspi->mmap_base)) {
+			ret = PTR_ERR(qspi->mmap_base);
+			goto free_master;
+		}
+	}
+
 	ret = devm_request_irq(&pdev->dev, irq, ti_qspi_isr, 0,
 			dev_name(&pdev->dev), qspi);
 	if (ret < 0) {
@@ -504,6 +611,9 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	if (!of_property_read_u32(np, "spi-max-frequency", &max_freq))
 		qspi->spi_max_frequency = max_freq;
 
+	if (of_property_read_bool(np, "mmap_read"))
+		qspi->memory_mapped = true;
+
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret)
 		goto free_master;
-- 
1.7.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
