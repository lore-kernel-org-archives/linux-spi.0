From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 48/49] spi: davinci: shorten variable names
Date: Wed, 17 Nov 2010 16:14:20 +0530
Message-ID: <1289990661-30126-49-git-send-email-nsekhar@ti.com>
References: <1289990661-30126-1-git-send-email-nsekhar@ti.com>
	<1289990661-30126-2-git-send-email-nsekhar@ti.com>
	<1289990661-30126-3-git-send-email-nsekhar@ti.com>
	<1289990661-30126-4-git-send-email-nsekhar@ti.com>
	<1289990661-30126-5-git-send-email-nsekhar@ti.com>
	<1289990661-30126-6-git-send-email-nsekhar@ti.com>
	<1289990661-30126-7-git-send-email-nsekhar@ti.com>
	<1289990661-30126-8-git-send-email-nsekhar@ti.com>
	<1289990661-30126-9-git-send-email-nsekhar@ti.com>
	<1289990661-30126-10-git-send-email-nsekhar@ti.com>
	<1289990661-30126-11-git-send-email-nsekhar@ti.com>
	<1289990661-30126-12-git-send-email-nsekhar@ti.com>
	<1289990661-30126-13-git-send-email-nsekhar@ti.com>
	<1289990661-30126-14-git-send-email-nsekhar@ti.com>
	<1289990661-30126-15-git-send-email-nsekhar@ti.com>
	<1289990661-30126-16-git-send-email-nsekhar@ti.com>
	<1289990661-30126-17-git-send-email-nsekhar@ti.com>
	<1289990661-30126-18-git-send-email-nsekhar@ti.com>
	<1289990661-30126-19-git-send-email-nsekhar@ti.com>
	<1289990661-30126-20-git-send-email-nsekhar@ti.com>
	<1289990661-30126-21-git-send-email-nsekhar@ti.com>
	<1289990661-30126-22-git-send-email-nsekhar@ti.com>
	<1289990661-30126-23-git-send-email-nsekhar@ti.com>
	<1289990661-30126-24-git-send-email-nsekhar@ti.com>
	<1289990661-30126-25-git-send-email-nsekhar@ti.com>
	<1289990661-30126-26-git-send-email-nsekhar@ti.com>
	<1289990661-30126-27-git-send-email-nsekhar@ti.com>
	<1289990661-30126-28-git-send-email-nsekhar@ti.com>
	<1289990661-30126-29-git-send-email-nsekhar@ti.com>
	<1289990661-30126-30-git-send-email-nsekhar@ti.com>
	<1289990661-30126-31-git-send-email-nsekhar@ti.com>
	<1289990661-30126-32-git-send-email-nsekhar@ti.com>
	<1289990661-30126-33-git-send-email-nsekhar@ti.com>
	<1289990661-30126-34-git-send-email-nsekhar@ti.com>
	<1289990661-30126-35-git-send-email-nsekhar@ti.com>
	<1289990661-30126-36-git-send-email-nsekhar@ti.com>
	<1289990661-30126-37-git-send-email-nsekhar@ti.com>
	<1289990661-30126-38-git-send-email-nsekhar@ti.com>
	<1289990661-30126-39-git-send-email-nsekhar@ti.com>
	<1289990661-30126-40-git-send-email-nsekhar@ti.com>
	<1289990661-30126-41-git-send-email-nsekhar@ti.com>
	<1289990661-30126-42-git-send-email-nsekhar@ti.com>
	<1289990661-30126-43-git-send-email-nsekhar@ti.com>
	<1289990661-30126-44-git-send-email-nsekhar@ti.com>
	<1289990661-30126-45-git-send-email-nsekhar@ti.com>
	<1289990661-30126-46-git-send-email-nsekhar@ti.com>
	<1289990661-30126-47-git-send-email-nsekhar@ti.com>
	<1289990661-30126-48-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-48-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Shorten names of local variables and structure members where
possible.

Local variables:

* 'davinci_spi' is being renamed 'dspi'
* 'davinci_spi_dma' is being renamed 'dma'

Structure members:

* 'dma_{tx|rx}_channel' is being renamed '{tx|rx}_channel'
  since the structure containing them is already called
  'davinci_spi_dma'

* 'davinci_spi_dma' in 'davinci_spi' structure is being
  renamed 'dma'

Tested-By: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/davinci_spi.c |  409 ++++++++++++++++++++++-----------------------
 1 files changed, 198 insertions(+), 211 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index f6f63d0..6beab99 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -115,8 +115,8 @@
 
 /* We have 2 DMA channels per CS, one for RX and one for TX */
 struct davinci_spi_dma {
-	int			dma_tx_channel;
-	int			dma_rx_channel;
+	int			tx_channel;
+	int			rx_channel;
 	int			dummy_param_slot;
 	enum dma_event_q	eventq;
 };
@@ -138,7 +138,7 @@ struct davinci_spi {
 	u8			rx_tmp_buf[SPI_TMP_BUFSZ];
 	int			rcount;
 	int			wcount;
-	struct davinci_spi_dma	dma_channels;
+	struct davinci_spi_dma	dma;
 	struct davinci_spi_platform_data *pdata;
 
 	void			(*get_rx)(u32 rx_data, struct davinci_spi *);
@@ -149,42 +149,42 @@ struct davinci_spi {
 
 static struct davinci_spi_config davinci_spi_default_cfg;
 
-static void davinci_spi_rx_buf_u8(u32 data, struct davinci_spi *davinci_spi)
+static void davinci_spi_rx_buf_u8(u32 data, struct davinci_spi *dspi)
 {
-	if (davinci_spi->rx) {
-		u8 *rx = davinci_spi->rx;
+	if (dspi->rx) {
+		u8 *rx = dspi->rx;
 		*rx++ = (u8)data;
-		davinci_spi->rx = rx;
+		dspi->rx = rx;
 	}
 }
 
-static void davinci_spi_rx_buf_u16(u32 data, struct davinci_spi *davinci_spi)
+static void davinci_spi_rx_buf_u16(u32 data, struct davinci_spi *dspi)
 {
-	if (davinci_spi->rx) {
-		u16 *rx = davinci_spi->rx;
+	if (dspi->rx) {
+		u16 *rx = dspi->rx;
 		*rx++ = (u16)data;
-		davinci_spi->rx = rx;
+		dspi->rx = rx;
 	}
 }
 
-static u32 davinci_spi_tx_buf_u8(struct davinci_spi *davinci_spi)
+static u32 davinci_spi_tx_buf_u8(struct davinci_spi *dspi)
 {
 	u32 data = 0;
-	if (davinci_spi->tx) {
-		const u8 *tx = davinci_spi->tx;
+	if (dspi->tx) {
+		const u8 *tx = dspi->tx;
 		data = *tx++;
-		davinci_spi->tx = tx;
+		dspi->tx = tx;
 	}
 	return data;
 }
 
-static u32 davinci_spi_tx_buf_u16(struct davinci_spi *davinci_spi)
+static u32 davinci_spi_tx_buf_u16(struct davinci_spi *dspi)
 {
 	u32 data = 0;
-	if (davinci_spi->tx) {
-		const u16 *tx = davinci_spi->tx;
+	if (dspi->tx) {
+		const u16 *tx = dspi->tx;
 		data = *tx++;
-		davinci_spi->tx = tx;
+		dspi->tx = tx;
 	}
 	return data;
 }
@@ -210,14 +210,14 @@ static inline void clear_io_bits(void __iomem *addr, u32 bits)
  */
 static void davinci_spi_chipselect(struct spi_device *spi, int value)
 {
-	struct davinci_spi *davinci_spi;
+	struct davinci_spi *dspi;
 	struct davinci_spi_platform_data *pdata;
 	u8 chip_sel = spi->chip_select;
-	u16 spidat1_cfg = CS_DEFAULT;
+	u16 spidat1 = CS_DEFAULT;
 	bool gpio_chipsel = false;
 
-	davinci_spi = spi_master_get_devdata(spi->master);
-	pdata = davinci_spi->pdata;
+	dspi = spi_master_get_devdata(spi->master);
+	pdata = dspi->pdata;
 
 	if (pdata->chip_sel && chip_sel < pdata->num_chipselect &&
 				pdata->chip_sel[chip_sel] != SPI_INTERN_CS)
@@ -234,11 +234,11 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
 			gpio_set_value(pdata->chip_sel[chip_sel], 1);
 	} else {
 		if (value == BITBANG_CS_ACTIVE) {
-			spidat1_cfg |= SPIDAT1_CSHOLD_MASK;
-			spidat1_cfg &= ~(0x1 << chip_sel);
+			spidat1 |= SPIDAT1_CSHOLD_MASK;
+			spidat1 &= ~(0x1 << chip_sel);
 		}
 
-		iowrite16(spidat1_cfg, davinci_spi->base + SPIDAT1 + 2);
+		iowrite16(spidat1, dspi->base + SPIDAT1 + 2);
 	}
 }
 
@@ -252,12 +252,12 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
  * Returns: calculated prescale - 1 for easy programming into SPI registers
  * or negative error number if valid prescalar cannot be updated.
  */
-static inline int davinci_spi_get_prescale(struct davinci_spi *davinci_spi,
+static inline int davinci_spi_get_prescale(struct davinci_spi *dspi,
 							u32 max_speed_hz)
 {
 	int ret;
 
-	ret = DIV_ROUND_UP(clk_get_rate(davinci_spi->clk), max_speed_hz);
+	ret = DIV_ROUND_UP(clk_get_rate(dspi->clk), max_speed_hz);
 
 	if (ret < 3 || ret > 256)
 		return -EINVAL;
@@ -278,12 +278,12 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 		struct spi_transfer *t)
 {
 
-	struct davinci_spi *davinci_spi;
+	struct davinci_spi *dspi;
 	struct davinci_spi_config *spicfg;
 	u8 bits_per_word = 0;
 	u32 hz = 0, spifmt = 0, prescale = 0;
 
-	davinci_spi = spi_master_get_devdata(spi->master);
+	dspi = spi_master_get_devdata(spi->master);
 	spicfg = (struct davinci_spi_config *)spi->controller_data;
 	if (!spicfg)
 		spicfg = &davinci_spi_default_cfg;
@@ -302,13 +302,13 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 	 * 8bit, 16bit or 32bit transfer
 	 */
 	if (bits_per_word <= 8 && bits_per_word >= 2) {
-		davinci_spi->get_rx = davinci_spi_rx_buf_u8;
-		davinci_spi->get_tx = davinci_spi_tx_buf_u8;
-		davinci_spi->bytes_per_word[spi->chip_select] = 1;
+		dspi->get_rx = davinci_spi_rx_buf_u8;
+		dspi->get_tx = davinci_spi_tx_buf_u8;
+		dspi->bytes_per_word[spi->chip_select] = 1;
 	} else if (bits_per_word <= 16 && bits_per_word >= 2) {
-		davinci_spi->get_rx = davinci_spi_rx_buf_u16;
-		davinci_spi->get_tx = davinci_spi_tx_buf_u16;
-		davinci_spi->bytes_per_word[spi->chip_select] = 2;
+		dspi->get_rx = davinci_spi_rx_buf_u16;
+		dspi->get_tx = davinci_spi_tx_buf_u16;
+		dspi->bytes_per_word[spi->chip_select] = 2;
 	} else
 		return -EINVAL;
 
@@ -317,7 +317,7 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 
 	/* Set up SPIFMTn register, unique to this chipselect. */
 
-	prescale = davinci_spi_get_prescale(davinci_spi, hz);
+	prescale = davinci_spi_get_prescale(dspi, hz);
 	if (prescale < 0)
 		return prescale;
 
@@ -345,7 +345,7 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 	 *  - 4 pin with enable is (SPI_READY | SPI_NO_CS)
 	 */
 
-	if (davinci_spi->version == SPI_VERSION_2) {
+	if (dspi->version == SPI_VERSION_2) {
 
 		u32 delay = 0;
 
@@ -375,10 +375,10 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 						& SPIDELAY_C2EDELAY_MASK;
 		}
 
-		iowrite32(delay, davinci_spi->base + SPIDELAY);
+		iowrite32(delay, dspi->base + SPIDELAY);
 	}
 
-	iowrite32(spifmt, davinci_spi->base + SPIFMT0);
+	iowrite32(spifmt, dspi->base + SPIFMT0);
 
 	return 0;
 }
@@ -392,11 +392,11 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 static int davinci_spi_setup(struct spi_device *spi)
 {
 	int retval = 0;
-	struct davinci_spi *davinci_spi;
+	struct davinci_spi *dspi;
 	struct davinci_spi_platform_data *pdata;
 
-	davinci_spi = spi_master_get_devdata(spi->master);
-	pdata = davinci_spi->pdata;
+	dspi = spi_master_get_devdata(spi->master);
+	pdata = dspi->pdata;
 
 	/* if bits per word length is zero then set it default 8 */
 	if (!spi->bits_per_word)
@@ -405,28 +405,24 @@ static int davinci_spi_setup(struct spi_device *spi)
 	if (!(spi->mode & SPI_NO_CS)) {
 		if ((pdata->chip_sel == NULL) ||
 		    (pdata->chip_sel[spi->chip_select] == SPI_INTERN_CS))
-			set_io_bits(davinci_spi->base + SPIPC0,
-					1 << spi->chip_select);
+			set_io_bits(dspi->base + SPIPC0, 1 << spi->chip_select);
 
 	}
 
 	if (spi->mode & SPI_READY)
-		set_io_bits(davinci_spi->base + SPIPC0, SPIPC0_SPIENA_MASK);
+		set_io_bits(dspi->base + SPIPC0, SPIPC0_SPIENA_MASK);
 
 	if (spi->mode & SPI_LOOP)
-		set_io_bits(davinci_spi->base + SPIGCR1,
-				SPIGCR1_LOOPBACK_MASK);
+		set_io_bits(dspi->base + SPIGCR1, SPIGCR1_LOOPBACK_MASK);
 	else
-		clear_io_bits(davinci_spi->base + SPIGCR1,
-				SPIGCR1_LOOPBACK_MASK);
+		clear_io_bits(dspi->base + SPIGCR1, SPIGCR1_LOOPBACK_MASK);
 
 	return retval;
 }
 
-static int davinci_spi_check_error(struct davinci_spi *davinci_spi,
-				   int int_status)
+static int davinci_spi_check_error(struct davinci_spi *dspi, int int_status)
 {
-	struct device *sdev = davinci_spi->bitbang.master->dev.parent;
+	struct device *sdev = dspi->bitbang.master->dev.parent;
 
 	if (int_status & SPIFLG_TIMEOUT_MASK) {
 		dev_dbg(sdev, "SPI Time-out Error\n");
@@ -441,7 +437,7 @@ static int davinci_spi_check_error(struct davinci_spi *davinci_spi,
 		return -EIO;
 	}
 
-	if (davinci_spi->version == SPI_VERSION_2) {
+	if (dspi->version == SPI_VERSION_2) {
 		if (int_status & SPIFLG_DLEN_ERR_MASK) {
 			dev_dbg(sdev, "SPI Data Length Error\n");
 			return -EIO;
@@ -465,35 +461,35 @@ static int davinci_spi_check_error(struct davinci_spi *davinci_spi,
 
 /**
  * davinci_spi_process_events - check for and handle any SPI controller events
- * @davinci_spi: the controller data
+ * @dspi: the controller data
  *
  * This function will check the SPIFLG register and handle any events that are
  * detected there
  */
-static int davinci_spi_process_events(struct davinci_spi *davinci_spi)
+static int davinci_spi_process_events(struct davinci_spi *dspi)
 {
-	u32 buf, status, errors = 0, data1_reg_val;
+	u32 buf, status, errors = 0, spidat1;
 
-	buf = ioread32(davinci_spi->base + SPIBUF);
+	buf = ioread32(dspi->base + SPIBUF);
 
-	if (davinci_spi->rcount > 0 && !(buf & SPIBUF_RXEMPTY_MASK)) {
-		davinci_spi->get_rx(buf & 0xFFFF, davinci_spi);
-		davinci_spi->rcount--;
+	if (dspi->rcount > 0 && !(buf & SPIBUF_RXEMPTY_MASK)) {
+		dspi->get_rx(buf & 0xFFFF, dspi);
+		dspi->rcount--;
 	}
 
-	status = ioread32(davinci_spi->base + SPIFLG);
+	status = ioread32(dspi->base + SPIFLG);
 
 	if (unlikely(status & SPIFLG_ERROR_MASK)) {
 		errors = status & SPIFLG_ERROR_MASK;
 		goto out;
 	}
 
-	if (davinci_spi->wcount > 0 && !(buf & SPIBUF_TXFULL_MASK)) {
-		data1_reg_val = ioread32(davinci_spi->base + SPIDAT1);
-		davinci_spi->wcount--;
-		data1_reg_val &= ~0xFFFF;
-		data1_reg_val |= 0xFFFF & davinci_spi->get_tx(davinci_spi);
-		iowrite32(data1_reg_val, davinci_spi->base + SPIDAT1);
+	if (dspi->wcount > 0 && !(buf & SPIBUF_TXFULL_MASK)) {
+		spidat1 = ioread32(dspi->base + SPIDAT1);
+		dspi->wcount--;
+		spidat1 &= ~0xFFFF;
+		spidat1 |= 0xFFFF & dspi->get_tx(dspi);
+		iowrite32(spidat1, dspi->base + SPIDAT1);
 	}
 
 out:
@@ -502,21 +498,20 @@ out:
 
 static void davinci_spi_dma_callback(unsigned lch, u16 status, void *data)
 {
-	struct davinci_spi *davinci_spi = data;
-	struct davinci_spi_dma *davinci_spi_dma = &davinci_spi->dma_channels;
+	struct davinci_spi *dspi = data;
+	struct davinci_spi_dma *dma = &dspi->dma;
 
 	edma_stop(lch);
 
 	if (status == DMA_COMPLETE) {
-		if (lch == davinci_spi_dma->dma_rx_channel)
-			davinci_spi->rcount = 0;
-		if (lch == davinci_spi_dma->dma_tx_channel)
-			davinci_spi->wcount = 0;
+		if (lch == dma->rx_channel)
+			dspi->rcount = 0;
+		if (lch == dma->tx_channel)
+			dspi->wcount = 0;
 	}
 
-	if ((!davinci_spi->wcount && !davinci_spi->rcount) ||
-	    (status != DMA_COMPLETE))
-		complete(&davinci_spi->done);
+	if ((!dspi->wcount && !dspi->rcount) || (status != DMA_COMPLETE))
+		complete(&dspi->done);
 }
 
 /**
@@ -530,57 +525,57 @@ static void davinci_spi_dma_callback(unsigned lch, u16 status, void *data)
  */
 static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 {
-	struct davinci_spi *davinci_spi;
+	struct davinci_spi *dspi;
 	int data_type, ret;
-	u32 tx_data, data1_reg_val;
+	u32 tx_data, spidat1;
 	u32 errors = 0;
 	struct davinci_spi_config *spicfg;
 	struct davinci_spi_platform_data *pdata;
 	unsigned uninitialized_var(rx_buf_count);
 	struct device *sdev;
 
-	davinci_spi = spi_master_get_devdata(spi->master);
-	pdata = davinci_spi->pdata;
+	dspi = spi_master_get_devdata(spi->master);
+	pdata = dspi->pdata;
 	spicfg = (struct davinci_spi_config *)spi->controller_data;
 	if (!spicfg)
 		spicfg = &davinci_spi_default_cfg;
-	sdev = davinci_spi->bitbang.master->dev.parent;
+	sdev = dspi->bitbang.master->dev.parent;
 
 	/* convert len to words based on bits_per_word */
-	data_type = davinci_spi->bytes_per_word[spi->chip_select];
+	data_type = dspi->bytes_per_word[spi->chip_select];
 
-	davinci_spi->tx = t->tx_buf;
-	davinci_spi->rx = t->rx_buf;
-	davinci_spi->wcount = t->len / data_type;
-	davinci_spi->rcount = davinci_spi->wcount;
+	dspi->tx = t->tx_buf;
+	dspi->rx = t->rx_buf;
+	dspi->wcount = t->len / data_type;
+	dspi->rcount = dspi->wcount;
 
-	data1_reg_val = ioread32(davinci_spi->base + SPIDAT1);
+	spidat1 = ioread32(dspi->base + SPIDAT1);
 
-	clear_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_POWERDOWN_MASK);
-	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_MASK);
+	clear_io_bits(dspi->base + SPIGCR1, SPIGCR1_POWERDOWN_MASK);
+	set_io_bits(dspi->base + SPIGCR1, SPIGCR1_SPIENA_MASK);
 
-	INIT_COMPLETION(davinci_spi->done);
+	INIT_COMPLETION(dspi->done);
 
 	if (spicfg->io_type == SPI_IO_TYPE_INTR)
-		set_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKINT);
+		set_io_bits(dspi->base + SPIINT, SPIINT_MASKINT);
 
 	if (spicfg->io_type != SPI_IO_TYPE_DMA) {
 		/* start the transfer */
-		davinci_spi->wcount--;
-		tx_data = davinci_spi->get_tx(davinci_spi);
-		data1_reg_val &= 0xFFFF0000;
-		data1_reg_val |= tx_data & 0xFFFF;
-		iowrite32(data1_reg_val, davinci_spi->base + SPIDAT1);
+		dspi->wcount--;
+		tx_data = dspi->get_tx(dspi);
+		spidat1 &= 0xFFFF0000;
+		spidat1 |= tx_data & 0xFFFF;
+		iowrite32(spidat1, dspi->base + SPIDAT1);
 	} else {
-		struct davinci_spi_dma *davinci_spi_dma;
+		struct davinci_spi_dma *dma;
 		unsigned long tx_reg, rx_reg;
 		struct edmacc_param param;
 		void *rx_buf;
 
-		davinci_spi_dma = &davinci_spi->dma_channels;
+		dma = &dspi->dma;
 
-		tx_reg = (unsigned long)davinci_spi->pbase + SPIDAT1;
-		rx_reg = (unsigned long)davinci_spi->pbase + SPIBUF;
+		tx_reg = (unsigned long)dspi->pbase + SPIDAT1;
+		rx_reg = (unsigned long)dspi->pbase + SPIBUF;
 
 		/*
 		 * Transmit DMA setup
@@ -596,26 +591,24 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 
 		if (t->tx_buf) {
 			t->tx_dma = dma_map_single(&spi->dev, (void *)t->tx_buf,
-					davinci_spi->wcount, DMA_TO_DEVICE);
+						dspi->wcount, DMA_TO_DEVICE);
 			if (dma_mapping_error(&spi->dev, t->tx_dma)) {
 				dev_dbg(sdev, "Unable to DMA map %d bytes"
-						"TX buffer\n",
-						davinci_spi->wcount);
+						"TX buffer\n", dspi->wcount);
 				return -ENOMEM;
 			}
 		}
 
-		param.opt = TCINTEN | EDMA_TCC(davinci_spi_dma->dma_tx_channel);
+		param.opt = TCINTEN | EDMA_TCC(dma->tx_channel);
 		param.src = t->tx_buf ? t->tx_dma : tx_reg;
-		param.a_b_cnt = davinci_spi->wcount << 16 | data_type;
+		param.a_b_cnt = dspi->wcount << 16 | data_type;
 		param.dst = tx_reg;
 		param.src_dst_bidx = t->tx_buf ? data_type : 0;
 		param.link_bcntrld = 0xffff;
 		param.src_dst_cidx = 0;
 		param.ccnt = 1;
-		edma_write_slot(davinci_spi_dma->dma_tx_channel, &param);
-		edma_link(davinci_spi_dma->dma_tx_channel,
-				davinci_spi_dma->dummy_param_slot);
+		edma_write_slot(dma->tx_channel, &param);
+		edma_link(dma->tx_channel, dma->dummy_param_slot);
 
 		/*
 		 * Receive DMA setup
@@ -631,10 +624,10 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 
 		if (t->rx_buf) {
 			rx_buf = t->rx_buf;
-			rx_buf_count = davinci_spi->rcount;
+			rx_buf_count = dspi->rcount;
 		} else {
-			rx_buf = davinci_spi->rx_tmp_buf;
-			rx_buf_count = sizeof(davinci_spi->rx_tmp_buf);
+			rx_buf = dspi->rx_tmp_buf;
+			rx_buf_count = sizeof(dspi->rx_tmp_buf);
 		}
 
 		t->rx_dma = dma_map_single(&spi->dev, rx_buf, rx_buf_count,
@@ -643,71 +636,69 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 			dev_dbg(sdev, "Couldn't DMA map a %d bytes RX buffer\n",
 								rx_buf_count);
 			if (t->tx_buf)
-				dma_unmap_single(NULL, t->tx_dma,
-						davinci_spi->wcount,
-						DMA_TO_DEVICE);
+				dma_unmap_single(NULL, t->tx_dma, dspi->wcount,
+								DMA_TO_DEVICE);
 			return -ENOMEM;
 		}
 
-		param.opt = TCINTEN | EDMA_TCC(davinci_spi_dma->dma_rx_channel);
+		param.opt = TCINTEN | EDMA_TCC(dma->rx_channel);
 		param.src = rx_reg;
-		param.a_b_cnt = davinci_spi->rcount << 16 | data_type;
+		param.a_b_cnt = dspi->rcount << 16 | data_type;
 		param.dst = t->rx_dma;
 		param.src_dst_bidx = (t->rx_buf ? data_type : 0) << 16;
 		param.link_bcntrld = 0xffff;
 		param.src_dst_cidx = 0;
 		param.ccnt = 1;
-		edma_write_slot(davinci_spi_dma->dma_rx_channel, &param);
+		edma_write_slot(dma->rx_channel, &param);
 
 		if (pdata->cshold_bug)
-			iowrite16(data1_reg_val >> 16,
-					davinci_spi->base + SPIDAT1 + 2);
+			iowrite16(spidat1 >> 16, dspi->base + SPIDAT1 + 2);
 
-		edma_start(davinci_spi_dma->dma_rx_channel);
-		edma_start(davinci_spi_dma->dma_tx_channel);
-		set_io_bits(davinci_spi->base + SPIINT, SPIINT_DMA_REQ_EN);
+		edma_start(dma->rx_channel);
+		edma_start(dma->tx_channel);
+		set_io_bits(dspi->base + SPIINT, SPIINT_DMA_REQ_EN);
 	}
 
 	/* Wait for the transfer to complete */
 	if (spicfg->io_type != SPI_IO_TYPE_POLL) {
-		wait_for_completion_interruptible(&(davinci_spi->done));
+		wait_for_completion_interruptible(&(dspi->done));
 	} else {
-		while (davinci_spi->rcount > 0 || davinci_spi->wcount > 0) {
-			errors = davinci_spi_process_events(davinci_spi);
+		while (dspi->rcount > 0 || dspi->wcount > 0) {
+			errors = davinci_spi_process_events(dspi);
 			if (errors)
 				break;
 			cpu_relax();
 		}
 	}
 
-	clear_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKALL);
+	clear_io_bits(dspi->base + SPIINT, SPIINT_MASKALL);
 	if (spicfg->io_type == SPI_IO_TYPE_DMA) {
 
 		if (t->tx_buf)
-			dma_unmap_single(NULL, t->tx_dma, davinci_spi->wcount,
+			dma_unmap_single(NULL, t->tx_dma, dspi->wcount,
 								DMA_TO_DEVICE);
 
 		dma_unmap_single(NULL, t->rx_dma, rx_buf_count,
 							DMA_FROM_DEVICE);
 
-		clear_io_bits(davinci_spi->base + SPIINT, SPIINT_DMA_REQ_EN);
+		clear_io_bits(dspi->base + SPIINT, SPIINT_DMA_REQ_EN);
 	}
 
-	clear_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_MASK);
-	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_POWERDOWN_MASK);
+	clear_io_bits(dspi->base + SPIGCR1, SPIGCR1_SPIENA_MASK);
+	set_io_bits(dspi->base + SPIGCR1, SPIGCR1_POWERDOWN_MASK);
 
 	/*
 	 * Check for bit error, desync error,parity error,timeout error and
 	 * receive overflow errors
 	 */
 	if (errors) {
-		ret = davinci_spi_check_error(davinci_spi, errors);
+		ret = davinci_spi_check_error(dspi, errors);
 		WARN(!ret, "%s: error reported but no error found!\n",
 							dev_name(&spi->dev));
 		return ret;
 	}
 
-	if (davinci_spi->rcount != 0 || davinci_spi->wcount != 0) {
+	if (dspi->rcount != 0 || dspi->wcount != 0) {
 		dev_err(sdev, "SPI data transfer error\n");
 		return -EIO;
 	}
@@ -726,60 +717,56 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
  * If transfer length is zero then it will indicate the COMPLETION so that
  * davinci_spi_bufs function can go ahead.
  */
-static irqreturn_t davinci_spi_irq(s32 irq, void *context_data)
+static irqreturn_t davinci_spi_irq(s32 irq, void *data)
 {
-	struct davinci_spi *davinci_spi = context_data;
+	struct davinci_spi *dspi = data;
 	int status;
 
-	status = davinci_spi_process_events(davinci_spi);
+	status = davinci_spi_process_events(dspi);
 	if (unlikely(status != 0))
-		clear_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKINT);
+		clear_io_bits(dspi->base + SPIINT, SPIINT_MASKINT);
 
-	if ((!davinci_spi->rcount && !davinci_spi->wcount) || status)
-		complete(&davinci_spi->done);
+	if ((!dspi->rcount && !dspi->wcount) || status)
+		complete(&dspi->done);
 
 	return IRQ_HANDLED;
 }
 
-static int davinci_spi_request_dma(struct davinci_spi *davinci_spi)
+static int davinci_spi_request_dma(struct davinci_spi *dspi)
 {
 	int r;
-	struct davinci_spi_dma *davinci_spi_dma = &davinci_spi->dma_channels;
+	struct davinci_spi_dma *dma = &dspi->dma;
 
-	r = edma_alloc_channel(davinci_spi_dma->dma_rx_channel,
-				davinci_spi_dma_callback, davinci_spi,
-				davinci_spi_dma->eventq);
+	r = edma_alloc_channel(dma->rx_channel, davinci_spi_dma_callback, dspi,
+								dma->eventq);
 	if (r < 0) {
 		pr_err("Unable to request DMA channel for SPI RX\n");
 		r = -EAGAIN;
 		goto rx_dma_failed;
 	}
 
-	r = edma_alloc_channel(davinci_spi_dma->dma_tx_channel,
-				davinci_spi_dma_callback, davinci_spi,
-				davinci_spi_dma->eventq);
+	r = edma_alloc_channel(dma->tx_channel, davinci_spi_dma_callback, dspi,
+								dma->eventq);
 	if (r < 0) {
 		pr_err("Unable to request DMA channel for SPI TX\n");
 		r = -EAGAIN;
 		goto tx_dma_failed;
 	}
 
-	r = edma_alloc_slot(EDMA_CTLR(davinci_spi_dma->dma_tx_channel),
-		EDMA_SLOT_ANY);
+	r = edma_alloc_slot(EDMA_CTLR(dma->tx_channel), EDMA_SLOT_ANY);
 	if (r < 0) {
 		pr_err("Unable to request SPI TX DMA param slot\n");
 		r = -EAGAIN;
 		goto param_failed;
 	}
-	davinci_spi_dma->dummy_param_slot = r;
-	edma_link(davinci_spi_dma->dummy_param_slot,
-		davinci_spi_dma->dummy_param_slot);
+	dma->dummy_param_slot = r;
+	edma_link(dma->dummy_param_slot, dma->dummy_param_slot);
 
 	return 0;
 param_failed:
-	edma_free_channel(davinci_spi_dma->dma_tx_channel);
+	edma_free_channel(dma->tx_channel);
 tx_dma_failed:
-	edma_free_channel(davinci_spi_dma->dma_rx_channel);
+	edma_free_channel(dma->rx_channel);
 rx_dma_failed:
 	return r;
 }
@@ -798,7 +785,7 @@ rx_dma_failed:
 static int davinci_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
-	struct davinci_spi *davinci_spi;
+	struct davinci_spi *dspi;
 	struct davinci_spi_platform_data *pdata;
 	struct resource *r, *mem;
 	resource_size_t dma_rx_chan = SPI_NO_RESOURCE;
@@ -821,8 +808,8 @@ static int davinci_spi_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, master);
 
-	davinci_spi = spi_master_get_devdata(master);
-	if (davinci_spi == NULL) {
+	dspi = spi_master_get_devdata(master);
+	if (dspi == NULL) {
 		ret = -ENOENT;
 		goto free_master;
 	}
@@ -833,8 +820,8 @@ static int davinci_spi_probe(struct platform_device *pdev)
 		goto free_master;
 	}
 
-	davinci_spi->pbase = r->start;
-	davinci_spi->pdata = pdata;
+	dspi->pbase = r->start;
+	dspi->pdata = pdata;
 
 	mem = request_mem_region(r->start, resource_size(r), pdev->name);
 	if (mem == NULL) {
@@ -842,48 +829,48 @@ static int davinci_spi_probe(struct platform_device *pdev)
 		goto free_master;
 	}
 
-	davinci_spi->base = ioremap(r->start, resource_size(r));
-	if (davinci_spi->base == NULL) {
+	dspi->base = ioremap(r->start, resource_size(r));
+	if (dspi->base == NULL) {
 		ret = -ENOMEM;
 		goto release_region;
 	}
 
-	davinci_spi->irq = platform_get_irq(pdev, 0);
-	if (davinci_spi->irq <= 0) {
+	dspi->irq = platform_get_irq(pdev, 0);
+	if (dspi->irq <= 0) {
 		ret = -EINVAL;
 		goto unmap_io;
 	}
 
-	ret = request_irq(davinci_spi->irq, davinci_spi_irq, 0,
-					dev_name(&pdev->dev), davinci_spi);
+	ret = request_irq(dspi->irq, davinci_spi_irq, 0, dev_name(&pdev->dev),
+									dspi);
 	if (ret)
 		goto unmap_io;
 
-	davinci_spi->bitbang.master = spi_master_get(master);
-	if (davinci_spi->bitbang.master == NULL) {
+	dspi->bitbang.master = spi_master_get(master);
+	if (dspi->bitbang.master == NULL) {
 		ret = -ENODEV;
 		goto irq_free;
 	}
 
-	davinci_spi->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(davinci_spi->clk)) {
+	dspi->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(dspi->clk)) {
 		ret = -ENODEV;
 		goto put_master;
 	}
-	clk_enable(davinci_spi->clk);
+	clk_enable(dspi->clk);
 
 	master->bus_num = pdev->id;
 	master->num_chipselect = pdata->num_chipselect;
 	master->setup = davinci_spi_setup;
 
-	davinci_spi->bitbang.chipselect = davinci_spi_chipselect;
-	davinci_spi->bitbang.setup_transfer = davinci_spi_setup_transfer;
+	dspi->bitbang.chipselect = davinci_spi_chipselect;
+	dspi->bitbang.setup_transfer = davinci_spi_setup_transfer;
 
-	davinci_spi->version = pdata->version;
+	dspi->version = pdata->version;
 
-	davinci_spi->bitbang.flags = SPI_NO_CS | SPI_LSB_FIRST | SPI_LOOP;
-	if (davinci_spi->version == SPI_VERSION_2)
-		davinci_spi->bitbang.flags |= SPI_READY;
+	dspi->bitbang.flags = SPI_NO_CS | SPI_LSB_FIRST | SPI_LOOP;
+	if (dspi->version == SPI_VERSION_2)
+		dspi->bitbang.flags |= SPI_READY;
 
 	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (r)
@@ -895,15 +882,15 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	if (r)
 		dma_eventq = r->start;
 
-	davinci_spi->bitbang.txrx_bufs = davinci_spi_bufs;
+	dspi->bitbang.txrx_bufs = davinci_spi_bufs;
 	if (dma_rx_chan != SPI_NO_RESOURCE &&
 	    dma_tx_chan != SPI_NO_RESOURCE &&
 	    dma_eventq != SPI_NO_RESOURCE) {
-		davinci_spi->dma_channels.dma_rx_channel = dma_rx_chan;
-		davinci_spi->dma_channels.dma_tx_channel = dma_tx_chan;
-		davinci_spi->dma_channels.eventq = dma_eventq;
+		dspi->dma.rx_channel = dma_rx_chan;
+		dspi->dma.tx_channel = dma_tx_chan;
+		dspi->dma.eventq = dma_eventq;
 
-		ret = davinci_spi_request_dma(davinci_spi);
+		ret = davinci_spi_request_dma(dspi);
 		if (ret)
 			goto free_clk;
 
@@ -913,19 +900,19 @@ static int davinci_spi_probe(struct platform_device *pdev)
 				dma_eventq);
 	}
 
-	davinci_spi->get_rx = davinci_spi_rx_buf_u8;
-	davinci_spi->get_tx = davinci_spi_tx_buf_u8;
+	dspi->get_rx = davinci_spi_rx_buf_u8;
+	dspi->get_tx = davinci_spi_tx_buf_u8;
 
-	init_completion(&davinci_spi->done);
+	init_completion(&dspi->done);
 
 	/* Reset In/OUT SPI module */
-	iowrite32(0, davinci_spi->base + SPIGCR0);
+	iowrite32(0, dspi->base + SPIGCR0);
 	udelay(100);
-	iowrite32(1, davinci_spi->base + SPIGCR0);
+	iowrite32(1, dspi->base + SPIGCR0);
 
 	/* Set up SPIPC0.  CS and ENA init is done in davinci_spi_setup */
 	spipc0 = SPIPC0_DIFUN_MASK | SPIPC0_DOFUN_MASK | SPIPC0_CLKFUN_MASK;
-	iowrite32(spipc0, davinci_spi->base + SPIPC0);
+	iowrite32(spipc0, dspi->base + SPIPC0);
 
 	/* initialize chip selects */
 	if (pdata->chip_sel) {
@@ -936,40 +923,40 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	}
 
 	if (pdata->intr_line)
-		iowrite32(SPI_INTLVL_1, davinci_spi->base + SPILVL);
+		iowrite32(SPI_INTLVL_1, dspi->base + SPILVL);
 	else
-		iowrite32(SPI_INTLVL_0, davinci_spi->base + SPILVL);
+		iowrite32(SPI_INTLVL_0, dspi->base + SPILVL);
 
-	iowrite32(CS_DEFAULT, davinci_spi->base + SPIDEF);
+	iowrite32(CS_DEFAULT, dspi->base + SPIDEF);
 
 	/* master mode default */
-	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_CLKMOD_MASK);
-	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_MASTER_MASK);
-	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_POWERDOWN_MASK);
+	set_io_bits(dspi->base + SPIGCR1, SPIGCR1_CLKMOD_MASK);
+	set_io_bits(dspi->base + SPIGCR1, SPIGCR1_MASTER_MASK);
+	set_io_bits(dspi->base + SPIGCR1, SPIGCR1_POWERDOWN_MASK);
 
-	ret = spi_bitbang_start(&davinci_spi->bitbang);
+	ret = spi_bitbang_start(&dspi->bitbang);
 	if (ret)
 		goto free_dma;
 
-	dev_info(&pdev->dev, "Controller at 0x%p\n", davinci_spi->base);
+	dev_info(&pdev->dev, "Controller at 0x%p\n", dspi->base);
 
 	return ret;
 
 free_dma:
-	edma_free_channel(davinci_spi->dma_channels.dma_tx_channel);
-	edma_free_channel(davinci_spi->dma_channels.dma_rx_channel);
-	edma_free_slot(davinci_spi->dma_channels.dummy_param_slot);
+	edma_free_channel(dspi->dma.tx_channel);
+	edma_free_channel(dspi->dma.rx_channel);
+	edma_free_slot(dspi->dma.dummy_param_slot);
 free_clk:
-	clk_disable(davinci_spi->clk);
-	clk_put(davinci_spi->clk);
+	clk_disable(dspi->clk);
+	clk_put(dspi->clk);
 put_master:
 	spi_master_put(master);
 irq_free:
-	free_irq(davinci_spi->irq, davinci_spi);
+	free_irq(dspi->irq, dspi);
 unmap_io:
-	iounmap(davinci_spi->base);
+	iounmap(dspi->base);
 release_region:
-	release_mem_region(davinci_spi->pbase, resource_size(r));
+	release_mem_region(dspi->pbase, resource_size(r));
 free_master:
 	kfree(master);
 err:
@@ -987,22 +974,22 @@ err:
  */
 static int __exit davinci_spi_remove(struct platform_device *pdev)
 {
-	struct davinci_spi *davinci_spi;
+	struct davinci_spi *dspi;
 	struct spi_master *master;
 	struct resource *r;
 
 	master = dev_get_drvdata(&pdev->dev);
-	davinci_spi = spi_master_get_devdata(master);
+	dspi = spi_master_get_devdata(master);
 
-	spi_bitbang_stop(&davinci_spi->bitbang);
+	spi_bitbang_stop(&dspi->bitbang);
 
-	clk_disable(davinci_spi->clk);
-	clk_put(davinci_spi->clk);
+	clk_disable(dspi->clk);
+	clk_put(dspi->clk);
 	spi_master_put(master);
-	free_irq(davinci_spi->irq, davinci_spi);
-	iounmap(davinci_spi->base);
+	free_irq(dspi->irq, dspi);
+	iounmap(dspi->base);
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(davinci_spi->pbase, resource_size(r));
+	release_mem_region(dspi->pbase, resource_size(r));
 
 	return 0;
 }
-- 
1.7.3.2
