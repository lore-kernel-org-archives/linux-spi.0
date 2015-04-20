From: "qipeng.zha" <qipeng.zha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi/pxa2xx: add support for Intel Broxton
Date: Tue, 21 Apr 2015 07:48:34 +0800
Message-ID: <1429573714-68828-1-git-send-email-qipeng.zha@intel.com>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, fei.yang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, huiquan.zhong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	jason.cj.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qipeng.zha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Huiquan Zhong <huiquan.zhong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Broxton have 3 SPI ports, PCI ids are 0x0ac2, 0x0ac4, 0x0ac6.
The LPSS SSP private register offset is 0x200. iDMA register offset
is 0x800.

Every Broxton SPI Controller have integrated one dedicated DMA IP.
Two DMA channels mapping:
	channel[0] -> SPI Tx,
	channel[1] -> SPI Rx.

BXT SSP SPI does not support DMA burst mode operation. Only iDMA
M-Size setting equal to 1(Single) is supported for all DMA
peripherial transfers from the SSP to the DMA and from the DMA
to the SSP, otherwise RX data corruption will happen.

Use a new parameter(.chip_select) for BXT dedicated cs control.

Signed-off-by: Huiquan Zhong <huiquan.zhong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-pxa2xx-pci.c   | 103 ++++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-pxa2xx.c       | 105 +++++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-pxa2xx.h       |   1 +
 include/linux/pxa2xx_ssp.h     |   3 ++
 include/linux/spi/pxa2xx_spi.h |   2 +
 5 files changed, 214 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index fa7399e..f042557 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -12,6 +12,7 @@
 
 #include <linux/dmaengine.h>
 #include <linux/platform_data/dma-dw.h>
+#include <linux/dma/dw.h>
 
 enum {
 	PORT_CE4100,
@@ -20,6 +21,9 @@ enum {
 	PORT_BSW1,
 	PORT_BSW2,
 	PORT_QUARK_X1000,
+	PORT_BXT0,
+	PORT_BXT1,
+	PORT_BXT2,
 };
 
 struct pxa_spi_info {
@@ -31,6 +35,9 @@ struct pxa_spi_info {
 	/* DMA channel request parameters */
 	void *tx_param;
 	void *rx_param;
+
+	int (*setup)(struct pci_dev *pdev, struct pxa2xx_spi_master *spi_pdata,
+			struct pxa_spi_info *c);
 };
 
 static struct dw_dma_slave byt_tx_param = { .dst_id = 0 };
@@ -54,6 +61,75 @@ static bool lpss_dma_filter(struct dma_chan *chan, void *param)
 	return true;
 }
 
+static struct dw_dma_platform_data bxt_idma_pdata = {
+	.nr_channels = 2,
+	.is_private = true,
+	.chan_allocation_order = CHAN_ALLOCATION_ASCENDING,
+	.chan_priority = CHAN_PRIORITY_ASCENDING,
+	.block_size = 0x1ffff, /* 128KB -1 */
+};
+
+#define BXT_IDMA_OFFSET	0x800
+static struct dw_dma_chip *bxt_idma_probe(struct device *dev,
+		void __iomem *base, int irq)
+{
+	struct dw_dma_chip *chip;
+	int err;
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return ERR_PTR(-ENOMEM);
+
+	chip->irq = irq;
+	chip->regs = base + BXT_IDMA_OFFSET;
+	chip->type = DW_DMAC_TYPE_IDMA;
+
+	err = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	if (err)
+		return ERR_PTR(err);
+
+	chip->dev = dev;
+	err = dw_dma_probe(chip, &bxt_idma_pdata);
+	if (err)
+		return ERR_PTR(err);
+
+	return chip;
+}
+
+static int bxt_spi_setup(struct pci_dev *dev,
+		struct pxa2xx_spi_master *spi_pdata, struct pxa_spi_info *c)
+{
+	struct ssp_device *ssp = &spi_pdata->ssp;
+	struct dw_dma_slave *tx_param, *rx_param;
+
+	spi_pdata->chip = bxt_idma_probe(&dev->dev, ssp->mmio_base,
+			ssp->irq);
+	if (!spi_pdata->chip) {
+		dev_err(&dev->dev, "error: DMA device register failed\n");
+		return PTR_ERR(spi_pdata->chip);
+	}
+
+	tx_param = devm_kzalloc(&dev->dev, sizeof(*tx_param), GFP_KERNEL);
+	if (!tx_param)
+		return -ENOMEM;
+
+	rx_param = devm_kzalloc(&dev->dev, sizeof(*rx_param), GFP_KERNEL);
+	if (!rx_param)
+		return -ENOMEM;
+
+	tx_param->dst_id = 0;
+	rx_param->src_id = 1;
+
+	tx_param->dma_dev = &dev->dev;
+	rx_param->dma_dev = &dev->dev;
+
+	spi_pdata->tx_param = tx_param;
+	spi_pdata->rx_param = rx_param;
+	spi_pdata->enable_dma = true;
+
+	return 0;
+}
+
 static struct pxa_spi_info spi_info_configs[] = {
 	[PORT_CE4100] = {
 		.type = PXA25x_SSP,
@@ -99,6 +175,27 @@ static struct pxa_spi_info spi_info_configs[] = {
 		.num_chipselect = 1,
 		.max_clk_rate = 50000000,
 	},
+	[PORT_BXT0] = {
+		.type = LPSS_BXT_SSP,
+		.port_id = 0,
+		.num_chipselect = 3,
+		.max_clk_rate = 50000000,
+		.setup = bxt_spi_setup,
+	},
+	[PORT_BXT1] = {
+		.type = LPSS_BXT_SSP,
+		.port_id = 1,
+		.num_chipselect = 4,
+		.max_clk_rate = 50000000,
+		.setup = bxt_spi_setup,
+	},
+	[PORT_BXT2] = {
+		.type = LPSS_BXT_SSP,
+		.port_id = 2,
+		.num_chipselect = 3,
+		.max_clk_rate = 50000000,
+		.setup = bxt_spi_setup,
+	},
 };
 
 static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
@@ -161,6 +258,9 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	ssp->port_id = (c->port_id >= 0) ? c->port_id : dev->devfn;
 	ssp->type = c->type;
 
+	if (c->setup)
+		c->setup(dev, &spi_pdata, c);
+
 	snprintf(buf, sizeof(buf), "pxa2xx-spi.%d", ssp->port_id);
 	ssp->clk = clk_register_fixed_rate(&dev->dev, buf , NULL,
 					CLK_IS_ROOT, c->max_clk_rate);
@@ -203,6 +303,9 @@ static const struct pci_device_id pxa2xx_spi_pci_devices[] = {
 	{ PCI_VDEVICE(INTEL, 0x228e), PORT_BSW0 },
 	{ PCI_VDEVICE(INTEL, 0x2290), PORT_BSW1 },
 	{ PCI_VDEVICE(INTEL, 0x22ac), PORT_BSW2 },
+	{ PCI_VDEVICE(INTEL, 0x0ac2), PORT_BXT0 },
+	{ PCI_VDEVICE(INTEL, 0x0ac4), PORT_BXT1 },
+	{ PCI_VDEVICE(INTEL, 0x0ac6), PORT_BXT2 },
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, pxa2xx_spi_pci_devices);
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index e3223ac..2006eea 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -64,6 +64,10 @@ MODULE_ALIAS("platform:pxa2xx-spi");
 #define LPSS_TX_LOTHRESH_DFLT	160
 #define LPSS_TX_HITHRESH_DFLT	224
 
+#define BXT_RX_THRESH_DFLT	32
+#define BXT_TX_LOTHRESH_DFLT	16
+#define BXT_TX_HITHRESH_DFLT	48
+
 /* Offset from drv_data->lpss_base */
 #define GENERAL_REG		0x08
 #define GENERAL_REG_RXTO_HOLDOFF_DISABLE BIT(24)
@@ -72,6 +76,18 @@ MODULE_ALIAS("platform:pxa2xx-spi");
 #define SPI_CS_CONTROL_SW_MODE	BIT(0)
 #define SPI_CS_CONTROL_CS_HIGH	BIT(1)
 
+#define SSP_RESETS		0x04
+#define BXT_SSP_RESETS_IDMA	BIT(2)
+#define BXT_SSP_RESETS_HOST	0x3
+
+#define SPI_CS_CONTROL_BXT	0x24
+#define SSP_CS_CONTROL_BXT_SEL_SFT 8
+#define SPI_CS_CONTROL_BXT_POL	(0xf << 12)
+
+#define CLOCK_GATE_BXT		0x38
+#define CLOCK_GATE_IDMA_ON	(0x3 << 2)
+#define CLOCK_GATE_IP_ON	0x3
+
 static bool is_lpss_ssp(const struct driver_data *drv_data)
 {
 	return drv_data->ssp_type == LPSS_SSP;
@@ -82,6 +98,11 @@ static bool is_quark_x1000_ssp(const struct driver_data *drv_data)
 	return drv_data->ssp_type == QUARK_X1000_SSP;
 }
 
+static bool is_lpss_bxt_ssp(const struct driver_data *drv_data)
+{
+	return drv_data->ssp_type == LPSS_BXT_SSP;
+}
+
 static u32 pxa2xx_spi_get_ssrc1_change_mask(const struct driver_data *drv_data)
 {
 	switch (drv_data->ssp_type) {
@@ -111,6 +132,9 @@ static bool pxa2xx_spi_txfifo_full(const struct driver_data *drv_data)
 	case QUARK_X1000_SSP:
 		mask = QUARK_X1000_SSSR_TFL_MASK;
 		break;
+	case LPSS_BXT_SSP:
+		mask = SSITF_TFL_BXT_MASK;
+		return (pxa2xx_spi_read(drv_data, SSITF) & mask) == mask;
 	default:
 		mask = SSSR_TFL_MASK;
 		break;
@@ -183,6 +207,31 @@ static void __lpss_ssp_write_priv(struct driver_data *drv_data,
 	writel(value, drv_data->lpss_base + offset);
 }
 
+static void lpss_bxt_ssp_setup(struct driver_data *drv_data)
+{
+	unsigned offset = 0x200;
+	u32 value;
+
+	/* Now set the LPSS base */
+	drv_data->lpss_base = drv_data->ioaddr + offset;
+
+	/* Reset LPSS SSP Controller */
+	__lpss_ssp_write_priv(drv_data, SSP_RESETS, 0x0);
+	usleep_range(10, 100);
+	__lpss_ssp_write_priv(drv_data, SSP_RESETS,
+				BXT_SSP_RESETS_IDMA | BXT_SSP_RESETS_HOST);
+	usleep_range(10, 100);
+
+	/* Force IP Clock on */
+	__lpss_ssp_write_priv(drv_data, CLOCK_GATE_BXT,
+				CLOCK_GATE_IDMA_ON | CLOCK_GATE_IP_ON);
+
+	/* Set the default Idle SPI CS polarity is High, and SW control mode */
+	value = SPI_CS_CONTROL_BXT_POL | SPI_CS_CONTROL_SW_MODE
+				| SPI_CS_CONTROL_CS_HIGH;
+	__lpss_ssp_write_priv(drv_data, SPI_CS_CONTROL_BXT, value);
+}
+
 /*
  * lpss_ssp_setup - perform LPSS SSP specific setup
  * @drv_data: pointer to the driver private data
@@ -251,6 +300,21 @@ static void lpss_ssp_cs_control(struct driver_data *drv_data, bool enable)
 	__lpss_ssp_write_priv(drv_data, SPI_CS_CONTROL, value);
 }
 
+static void lpss_bxt_ssp_cs_control(struct driver_data *drv_data, bool enable)
+{
+	u32 value;
+
+	value = __lpss_ssp_read_priv(drv_data, SPI_CS_CONTROL_BXT);
+	if (enable)
+		value &= ~SPI_CS_CONTROL_CS_HIGH;
+	else
+		value |= SPI_CS_CONTROL_CS_HIGH;
+
+	value |= drv_data->cur_chip->chip_select << SSP_CS_CONTROL_BXT_SEL_SFT;
+
+	__lpss_ssp_write_priv(drv_data, SPI_CS_CONTROL_BXT, value);
+}
+
 static void cs_assert(struct driver_data *drv_data)
 {
 	struct chip_data *chip = drv_data->cur_chip;
@@ -272,6 +336,9 @@ static void cs_assert(struct driver_data *drv_data)
 
 	if (is_lpss_ssp(drv_data))
 		lpss_ssp_cs_control(drv_data, true);
+
+	if (is_lpss_bxt_ssp(drv_data))
+		lpss_bxt_ssp_cs_control(drv_data, true);
 }
 
 static void cs_deassert(struct driver_data *drv_data)
@@ -293,6 +360,9 @@ static void cs_deassert(struct driver_data *drv_data)
 
 	if (is_lpss_ssp(drv_data))
 		lpss_ssp_cs_control(drv_data, false);
+
+	if (is_lpss_bxt_ssp(drv_data))
+		lpss_bxt_ssp_cs_control(drv_data, false);
 }
 
 int pxa2xx_spi_flush(struct driver_data *drv_data)
@@ -970,6 +1040,25 @@ static void pump_transfers(unsigned long data)
 		    != chip->lpss_tx_threshold)
 			pxa2xx_spi_write(drv_data, SSITF,
 					 chip->lpss_tx_threshold);
+	} else if (is_lpss_bxt_ssp(drv_data)) {
+		if (drv_data->dma_mapped) {
+			/*
+			 * BXT SPI does not support DMA burst mode of operation,
+			 * need to set threshold corresponding with burst size.
+			 */
+			chip->lpss_rx_threshold = SSIRF_RxThresh(2);
+			chip->lpss_tx_threshold = SSITF_TxLoThresh(2)
+						| SSITF_TxHiThresh(62);
+		}
+
+		if ((pxa2xx_spi_read(drv_data, SSIRF) & 0x3f)
+		    != chip->lpss_rx_threshold)
+			pxa2xx_spi_write(drv_data, SSIRF,
+					 chip->lpss_rx_threshold);
+		if ((pxa2xx_spi_read(drv_data, SSITF) & 0x3f3f)
+		    != chip->lpss_tx_threshold)
+			pxa2xx_spi_write(drv_data, SSITF,
+					 chip->lpss_tx_threshold);
 	}
 
 	if (is_quark_x1000_ssp(drv_data) &&
@@ -1090,6 +1179,11 @@ static int setup(struct spi_device *spi)
 		tx_hi_thres = LPSS_TX_HITHRESH_DFLT;
 		rx_thres = LPSS_RX_THRESH_DFLT;
 		break;
+	case LPSS_BXT_SSP:
+		tx_thres = BXT_TX_LOTHRESH_DFLT;
+		tx_hi_thres = BXT_TX_HITHRESH_DFLT;
+		rx_thres = BXT_RX_THRESH_DFLT;
+		break;
 	default:
 		tx_thres = TX_THRESH_DFLT;
 		tx_hi_thres = 0;
@@ -1147,6 +1241,11 @@ static int setup(struct spi_device *spi)
 		chip->enable_dma = drv_data->master_info->enable_dma;
 	}
 
+	if (is_lpss_bxt_ssp(drv_data)) {
+		chip->chip_select = spi->chip_select;
+		chip->enable_dma = drv_data->master_info->enable_dma;
+	}
+
 	chip->lpss_rx_threshold = SSIRF_RxThresh(rx_thres);
 	chip->lpss_tx_threshold = SSITF_TxLoThresh(tx_thres)
 				| SSITF_TxHiThresh(tx_hi_thres);
@@ -1439,6 +1538,9 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	if (is_lpss_ssp(drv_data))
 		lpss_ssp_setup(drv_data);
 
+	if (is_lpss_bxt_ssp(drv_data))
+		lpss_bxt_ssp_setup(drv_data);
+
 	tasklet_init(&drv_data->pump_transfers, pump_transfers,
 		     (unsigned long)drv_data);
 
@@ -1541,6 +1643,9 @@ static int pxa2xx_spi_resume(struct device *dev)
 	if (is_lpss_ssp(drv_data))
 		lpss_ssp_setup(drv_data);
 
+	if (is_lpss_bxt_ssp(drv_data))
+		lpss_bxt_ssp_setup(drv_data);
+
 	/* Start the queue running */
 	status = spi_master_resume(drv_data->master);
 	if (status != 0) {
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 85a58c9..c2c5127 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -105,6 +105,7 @@ struct chip_data {
 	u8 enable_dma;
 	u8 bits_per_word;
 	u32 speed_hz;
+	u8 chip_select;
 	union {
 		int gpio_cs;
 		unsigned int frm;
diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index dab545b..0eaaa54 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -185,6 +185,8 @@
 #define SSIRF			0x48		/* RX FIFO trigger level */
 #define SSIRF_RxThresh(x)	((x) - 1)
 
+#define SSITF_TFL_BXT_MASK	(0x3f << 16)	/* Transmit FIFO Level mask */
+
 enum pxa_ssp_type {
 	SSP_UNDEFINED = 0,
 	PXA25x_SSP,  /* pxa 210, 250, 255, 26x */
@@ -196,6 +198,7 @@ enum pxa_ssp_type {
 	CE4100_SSP,
 	LPSS_SSP,
 	QUARK_X1000_SSP,
+	LPSS_BXT_SSP,
 };
 
 struct ssp_device {
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
index 6d36dac..f5d03da 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -34,6 +34,8 @@ struct pxa2xx_spi_master {
 
 	/* For non-PXA arches */
 	struct ssp_device ssp;
+	/* For BXT DMA chip */
+	struct dw_dma_chip *chip;
 };
 
 /* spi_board_info.controller_data for SPI slave devices,
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
