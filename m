From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: imx: Add support for SPI Slave mode" to the spi tree
Date: Tue, 19 Sep 2017 16:02:22 +0100
Message-ID: <E1duK2Y-0002gq-Bs@debutante>
References: <20170905051232.21203-1-jiada_wang@mentor.com>
Cc: Jiada Wang <jiada_wang@mentor.com>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        s.hauer@pengutronix.de, fabio.estevam@nxp.com,
        jiada_wang@mentor.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: jiada wang <jiada_wang@mentor.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170905051232.21203-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: imx: Add support for SPI Slave mode

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 71abd29057cb17b6b9532421821dc443427399ed Mon Sep 17 00:00:00 2001
From: jiada wang <jiada_wang@mentor.com>
Date: Tue, 5 Sep 2017 14:12:32 +0900
Subject: [PATCH] spi: imx: Add support for SPI Slave mode

Previously i.MX SPI controller only works in Master mode.
This patch adds support to i.MX51, i.MX53 and i.MX6 ECSPI
controller to work also in Slave mode.

Currently SPI Slave mode support patch has the following limitations:
1. The stale data in RXFIFO will be dropped when the Slave does any new
   transfer.
2. One transfer can be finished only after all transfer->len data been
   transferred to master device
3. Slave device only accepts transfer->len data. Any data longer than this
   from master device will be dropped. Any data shorter than this from
   master will cause SPI to stuck due to mentioned HW limitation 2.
4. Only PIO transfer is supported in Slave mode.
5. Dynamic burst size adjust isn't supported in Slave mode.

Following HW limitation applies:
1.  ECSPI has a HW issue when works in Slave mode, after 64
    words written to TXFIFO, even TXFIFO becomes empty,
    ECSPI_TXDATA keeps shift out the last word data,
    so we have to disable ECSPI when in slave mode after the
    transfer completes
2.  Due to Freescale errata ERR003775 "eCSPI: Burst completion by Chip
    Select (SS) signal in Slave mode is not functional" burst size must
    be set exactly to the size of the transfer. This limit SPI transaction
    with maximum 2^12 bits. This errata affects i.MX53 and i.MX6 ECSPI
    controllers.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 227 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 196 insertions(+), 31 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index babb15f07995..fe35aaea323b 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -53,10 +53,13 @@
 /* generic defines to abstract from the different register layouts */
 #define MXC_INT_RR	(1 << 0) /* Receive data ready interrupt */
 #define MXC_INT_TE	(1 << 1) /* Transmit FIFO empty interrupt */
+#define MXC_INT_RDR	BIT(4) /* Receive date threshold interrupt */
 
 /* The maximum  bytes that a sdma BD can transfer.*/
 #define MAX_SDMA_BD_BYTES  (1 << 15)
 #define MX51_ECSPI_CTRL_MAX_BURST	512
+/* The maximum bytes that IMX53_ECSPI can transfer in slave mode.*/
+#define MX53_MAX_TRANSFER_BYTES		512
 
 enum spi_imx_devtype {
 	IMX1_CSPI,
@@ -76,7 +79,9 @@ struct spi_imx_devtype_data {
 	void (*trigger)(struct spi_imx_data *);
 	int (*rx_available)(struct spi_imx_data *);
 	void (*reset)(struct spi_imx_data *);
+	void (*disable)(struct spi_imx_data *);
 	bool has_dmamode;
+	bool has_slavemode;
 	unsigned int fifo_size;
 	bool dynamic_burst;
 	enum spi_imx_devtype devtype;
@@ -108,6 +113,11 @@ struct spi_imx_data {
 	unsigned int dynamic_burst, read_u32;
 	unsigned int word_mask;
 
+	/* Slave mode */
+	bool slave_mode;
+	bool slave_aborted;
+	unsigned int slave_burst;
+
 	/* DMA */
 	bool usedma;
 	u32 wml;
@@ -221,6 +231,9 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 	if (!master->dma_rx)
 		return false;
 
+	if (spi_imx->slave_mode)
+		return false;
+
 	bytes_per_word = spi_imx_bytes_per_word(transfer->bits_per_word);
 
 	if (bytes_per_word != 1 && bytes_per_word != 2 && bytes_per_word != 4)
@@ -262,6 +275,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_INT		0x10
 #define MX51_ECSPI_INT_TEEN		(1 <<  0)
 #define MX51_ECSPI_INT_RREN		(1 <<  3)
+#define MX51_ECSPI_INT_RDREN		(1 <<  4)
 
 #define MX51_ECSPI_DMA      0x14
 #define MX51_ECSPI_DMA_TX_WML(wml)	((wml) & 0x3f)
@@ -378,6 +392,44 @@ static void spi_imx_buf_tx_swap(struct spi_imx_data *spi_imx)
 		spi_imx_buf_tx_u16(spi_imx);
 }
 
+static void mx53_ecspi_rx_slave(struct spi_imx_data *spi_imx)
+{
+	u32 val = be32_to_cpu(readl(spi_imx->base + MXC_CSPIRXDATA));
+
+	if (spi_imx->rx_buf) {
+		int n_bytes = spi_imx->slave_burst % sizeof(val);
+
+		if (!n_bytes)
+			n_bytes = sizeof(val);
+
+		memcpy(spi_imx->rx_buf,
+		       ((u8 *)&val) + sizeof(val) - n_bytes, n_bytes);
+
+		spi_imx->rx_buf += n_bytes;
+		spi_imx->slave_burst -= n_bytes;
+	}
+}
+
+static void mx53_ecspi_tx_slave(struct spi_imx_data *spi_imx)
+{
+	u32 val = 0;
+	int n_bytes = spi_imx->count % sizeof(val);
+
+	if (!n_bytes)
+		n_bytes = sizeof(val);
+
+	if (spi_imx->tx_buf) {
+		memcpy(((u8 *)&val) + sizeof(val) - n_bytes,
+		       spi_imx->tx_buf, n_bytes);
+		val = cpu_to_be32(val);
+		spi_imx->tx_buf += n_bytes;
+	}
+
+	spi_imx->count -= n_bytes;
+
+	writel(val, spi_imx->base + MXC_CSPITXDATA);
+}
+
 /* MX51 eCSPI */
 static unsigned int mx51_ecspi_clkdiv(struct spi_imx_data *spi_imx,
 				      unsigned int fspi, unsigned int *fres)
@@ -427,6 +479,9 @@ static void mx51_ecspi_intctrl(struct spi_imx_data *spi_imx, int enable)
 	if (enable & MXC_INT_RR)
 		val |= MX51_ECSPI_INT_RREN;
 
+	if (enable & MXC_INT_RDR)
+		val |= MX51_ECSPI_INT_RDREN;
+
 	writel(val, spi_imx->base + MX51_ECSPI_INT);
 }
 
@@ -439,6 +494,15 @@ static void mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
 }
 
+static void mx51_ecspi_disable(struct spi_imx_data *spi_imx)
+{
+	u32 ctrl;
+
+	ctrl = readl(spi_imx->base + MX51_ECSPI_CTRL);
+	ctrl &= ~MX51_ECSPI_CTRL_ENABLE;
+	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
+}
+
 static int mx51_ecspi_config(struct spi_device *spi)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
@@ -446,14 +510,11 @@ static int mx51_ecspi_config(struct spi_device *spi)
 	u32 clk = spi_imx->speed_hz, delay, reg;
 	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
 
-	/*
-	 * The hardware seems to have a race condition when changing modes. The
-	 * current assumption is that the selection of the channel arrives
-	 * earlier in the hardware than the mode bits when they are written at
-	 * the same time.
-	 * So set master mode for all channels as we do not support slave mode.
-	 */
-	ctrl |= MX51_ECSPI_CTRL_MODE_MASK;
+	/* set Master or Slave mode */
+	if (spi_imx->slave_mode)
+		ctrl &= ~MX51_ECSPI_CTRL_MODE_MASK;
+	else
+		ctrl |= MX51_ECSPI_CTRL_MODE_MASK;
 
 	/*
 	 * Enable SPI_RDY handling (falling edge/level triggered).
@@ -468,9 +529,22 @@ static int mx51_ecspi_config(struct spi_device *spi)
 	/* set chip select to use */
 	ctrl |= MX51_ECSPI_CTRL_CS(spi->chip_select);
 
-	ctrl |= (spi_imx->bits_per_word - 1) << MX51_ECSPI_CTRL_BL_OFFSET;
+	if (spi_imx->slave_mode && is_imx53_ecspi(spi_imx))
+		ctrl |= (spi_imx->slave_burst * 8 - 1)
+			<< MX51_ECSPI_CTRL_BL_OFFSET;
+	else
+		ctrl |= (spi_imx->bits_per_word - 1)
+			<< MX51_ECSPI_CTRL_BL_OFFSET;
 
-	cfg |= MX51_ECSPI_CONFIG_SBBCTRL(spi->chip_select);
+	/*
+	 * eCSPI burst completion by Chip Select signal in Slave mode
+	 * is not functional for imx53 Soc, config SPI burst completed when
+	 * BURST_LENGTH + 1 bits are received
+	 */
+	if (spi_imx->slave_mode && is_imx53_ecspi(spi_imx))
+		cfg &= ~MX51_ECSPI_CONFIG_SBBCTRL(spi->chip_select);
+	else
+		cfg |= MX51_ECSPI_CONFIG_SBBCTRL(spi->chip_select);
 
 	if (spi->mode & SPI_CPHA)
 		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(spi->chip_select);
@@ -805,6 +879,7 @@ static struct spi_imx_devtype_data imx1_cspi_devtype_data = {
 	.fifo_size = 8,
 	.has_dmamode = false,
 	.dynamic_burst = false,
+	.has_slavemode = false,
 	.devtype = IMX1_CSPI,
 };
 
@@ -817,6 +892,7 @@ static struct spi_imx_devtype_data imx21_cspi_devtype_data = {
 	.fifo_size = 8,
 	.has_dmamode = false,
 	.dynamic_burst = false,
+	.has_slavemode = false,
 	.devtype = IMX21_CSPI,
 };
 
@@ -830,6 +906,7 @@ static struct spi_imx_devtype_data imx27_cspi_devtype_data = {
 	.fifo_size = 8,
 	.has_dmamode = false,
 	.dynamic_burst = false,
+	.has_slavemode = false,
 	.devtype = IMX27_CSPI,
 };
 
@@ -842,6 +919,7 @@ static struct spi_imx_devtype_data imx31_cspi_devtype_data = {
 	.fifo_size = 8,
 	.has_dmamode = false,
 	.dynamic_burst = false,
+	.has_slavemode = false,
 	.devtype = IMX31_CSPI,
 };
 
@@ -855,6 +933,7 @@ static struct spi_imx_devtype_data imx35_cspi_devtype_data = {
 	.fifo_size = 8,
 	.has_dmamode = true,
 	.dynamic_burst = false,
+	.has_slavemode = false,
 	.devtype = IMX35_CSPI,
 };
 
@@ -867,6 +946,8 @@ static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
 	.fifo_size = 64,
 	.has_dmamode = true,
 	.dynamic_burst = true,
+	.has_slavemode = true,
+	.disable = mx51_ecspi_disable,
 	.devtype = IMX51_ECSPI,
 };
 
@@ -878,6 +959,8 @@ static struct spi_imx_devtype_data imx53_ecspi_devtype_data = {
 	.reset = mx51_ecspi_reset,
 	.fifo_size = 64,
 	.has_dmamode = true,
+	.has_slavemode = true,
+	.disable = mx51_ecspi_disable,
 	.devtype = IMX53_ECSPI,
 };
 
@@ -945,14 +1028,16 @@ static void spi_imx_push(struct spi_imx_data *spi_imx)
 		spi_imx->txfifo++;
 	}
 
-	spi_imx->devtype_data->trigger(spi_imx);
+	if (!spi_imx->slave_mode)
+		spi_imx->devtype_data->trigger(spi_imx);
 }
 
 static irqreturn_t spi_imx_isr(int irq, void *dev_id)
 {
 	struct spi_imx_data *spi_imx = dev_id;
 
-	while (spi_imx->devtype_data->rx_available(spi_imx)) {
+	while (spi_imx->txfifo &&
+	       spi_imx->devtype_data->rx_available(spi_imx)) {
 		spi_imx->rx(spi_imx);
 		spi_imx->txfifo--;
 	}
@@ -1034,7 +1119,7 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	spi_imx->speed_hz  = t->speed_hz;
 
 	/* Initialize the functions for transfer */
-	if (spi_imx->devtype_data->dynamic_burst) {
+	if (spi_imx->devtype_data->dynamic_burst && !spi_imx->slave_mode) {
 		u32 mask;
 
 		spi_imx->dynamic_burst = 0;
@@ -1078,6 +1163,12 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 			return ret;
 	}
 
+	if (is_imx53_ecspi(spi_imx) && spi_imx->slave_mode) {
+		spi_imx->rx = mx53_ecspi_rx_slave;
+		spi_imx->tx = mx53_ecspi_tx_slave;
+		spi_imx->slave_burst = t->len;
+	}
+
 	spi_imx->devtype_data->config(spi);
 
 	return 0;
@@ -1262,11 +1353,61 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
 	return transfer->len;
 }
 
+static int spi_imx_pio_transfer_slave(struct spi_device *spi,
+				      struct spi_transfer *transfer)
+{
+	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
+	int ret = transfer->len;
+
+	if (is_imx53_ecspi(spi_imx) &&
+	    transfer->len > MX53_MAX_TRANSFER_BYTES) {
+		dev_err(&spi->dev, "Transaction too big, max size is %d bytes\n",
+			MX53_MAX_TRANSFER_BYTES);
+		return -EMSGSIZE;
+	}
+
+	spi_imx->tx_buf = transfer->tx_buf;
+	spi_imx->rx_buf = transfer->rx_buf;
+	spi_imx->count = transfer->len;
+	spi_imx->txfifo = 0;
+
+	reinit_completion(&spi_imx->xfer_done);
+	spi_imx->slave_aborted = false;
+
+	spi_imx_push(spi_imx);
+
+	spi_imx->devtype_data->intctrl(spi_imx, MXC_INT_TE | MXC_INT_RDR);
+
+	if (wait_for_completion_interruptible(&spi_imx->xfer_done) ||
+	    spi_imx->slave_aborted) {
+		dev_dbg(&spi->dev, "interrupted\n");
+		ret = -EINTR;
+	}
+
+	/* ecspi has a HW issue when works in Slave mode,
+	 * after 64 words writtern to TXFIFO, even TXFIFO becomes empty,
+	 * ECSPI_TXDATA keeps shift out the last word data,
+	 * so we have to disable ECSPI when in slave mode after the
+	 * transfer completes
+	 */
+	if (spi_imx->devtype_data->disable)
+		spi_imx->devtype_data->disable(spi_imx);
+
+	return ret;
+}
+
 static int spi_imx_transfer(struct spi_device *spi,
 				struct spi_transfer *transfer)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
 
+	/* flush rxfifo before transfer */
+	while (spi_imx->devtype_data->rx_available(spi_imx))
+		spi_imx->rx(spi_imx);
+
+	if (spi_imx->slave_mode)
+		return spi_imx_pio_transfer_slave(spi, transfer);
+
 	if (spi_imx->usedma)
 		return spi_imx_dma_transfer(spi_imx, transfer);
 	else
@@ -1323,6 +1464,16 @@ spi_imx_unprepare_message(struct spi_master *master, struct spi_message *msg)
 	return 0;
 }
 
+static int spi_imx_slave_abort(struct spi_master *master)
+{
+	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
+
+	spi_imx->slave_aborted = true;
+	complete(&spi_imx->xfer_done);
+
+	return 0;
+}
+
 static int spi_imx_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1334,13 +1485,23 @@ static int spi_imx_probe(struct platform_device *pdev)
 	struct spi_imx_data *spi_imx;
 	struct resource *res;
 	int i, ret, irq, spi_drctl;
+	const struct spi_imx_devtype_data *devtype_data = of_id ? of_id->data :
+		(struct spi_imx_devtype_data *)pdev->id_entry->driver_data;
+	bool slave_mode;
 
 	if (!np && !mxc_platform_info) {
 		dev_err(&pdev->dev, "can't get the platform data\n");
 		return -EINVAL;
 	}
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct spi_imx_data));
+	slave_mode = devtype_data->has_slavemode &&
+			of_property_read_bool(np, "spi-slave");
+	if (slave_mode)
+		master = spi_alloc_slave(&pdev->dev,
+					 sizeof(struct spi_imx_data));
+	else
+		master = spi_alloc_master(&pdev->dev,
+					  sizeof(struct spi_imx_data));
 	if (!master)
 		return -ENOMEM;
 
@@ -1358,9 +1519,9 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx = spi_master_get_devdata(master);
 	spi_imx->bitbang.master = master;
 	spi_imx->dev = &pdev->dev;
+	spi_imx->slave_mode = slave_mode;
 
-	spi_imx->devtype_data = of_id ? of_id->data :
-		(struct spi_imx_devtype_data *)pdev->id_entry->driver_data;
+	spi_imx->devtype_data = devtype_data;
 
 	if (mxc_platform_info) {
 		master->num_chipselect = mxc_platform_info->num_chipselect;
@@ -1380,6 +1541,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->bitbang.master->cleanup = spi_imx_cleanup;
 	spi_imx->bitbang.master->prepare_message = spi_imx_prepare_message;
 	spi_imx->bitbang.master->unprepare_message = spi_imx_unprepare_message;
+	spi_imx->bitbang.master->slave_abort = spi_imx_slave_abort;
 	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
 					     | SPI_NO_CS;
 	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx) ||
@@ -1457,23 +1619,26 @@ static int spi_imx_probe(struct platform_device *pdev)
 		goto out_clk_put;
 	}
 
-	if (!master->cs_gpios) {
-		dev_err(&pdev->dev, "No CS GPIOs available\n");
-		ret = -EINVAL;
-		goto out_clk_put;
-	}
-
-	for (i = 0; i < master->num_chipselect; i++) {
-		if (!gpio_is_valid(master->cs_gpios[i]))
-			continue;
-
-		ret = devm_gpio_request(&pdev->dev, master->cs_gpios[i],
-					DRIVER_NAME);
-		if (ret) {
-			dev_err(&pdev->dev, "Can't get CS GPIO %i\n",
-				master->cs_gpios[i]);
+	if (!spi_imx->slave_mode) {
+		if (!master->cs_gpios) {
+			dev_err(&pdev->dev, "No CS GPIOs available\n");
+			ret = -EINVAL;
 			goto out_clk_put;
 		}
+
+		for (i = 0; i < master->num_chipselect; i++) {
+			if (!gpio_is_valid(master->cs_gpios[i]))
+				continue;
+
+			ret = devm_gpio_request(&pdev->dev,
+						master->cs_gpios[i],
+						DRIVER_NAME);
+			if (ret) {
+				dev_err(&pdev->dev, "Can't get CS GPIO %i\n",
+					master->cs_gpios[i]);
+				goto out_clk_put;
+			}
+		}
 	}
 
 	dev_info(&pdev->dev, "probed\n");
-- 
2.14.1
