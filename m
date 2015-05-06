From: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Subject: [PATCH v3] spi: omap2-mcspi: Add support for GPIO chipselects
Date: Wed,  6 May 2015 18:37:52 -0500
Message-ID: <1430955472-11409-1-git-send-email-mwelling@ieee.org>
Cc: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch allows for GPIOs specified in the devicetree to be used as SPI
chipselects on TI OMAP2 SoCs.

Tested on the AM3354.

Signed-off-by: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
---
v3: Switches driver to use transfer_one instead of transfer_one_message
allowing the spi core to handle toggling GPIO chip selects if specified.

v2: Considers the possible use of SPI_CS_HIGH during chip select activation.

 drivers/spi/spi-omap2-mcspi.c |  251 +++++++++++++++++++----------------------
 1 file changed, 117 insertions(+), 134 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index d1a5b9f..7152d8e 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -35,6 +35,7 @@
 #include <linux/gcd.h>
 
 #include <linux/spi/spi.h>
+#include <linux/gpio.h>
 
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
@@ -1015,6 +1016,12 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
+	if (gpio_is_valid(spi->cs_gpio)) {
+		if (gpio_request(spi->cs_gpio, dev_name(&spi->dev)) == 0)
+			gpio_direction_output(spi->cs_gpio,
+				!(spi->mode & SPI_CS_HIGH));
+	}
+
 	ret = omap2_mcspi_setup_transfer(spi, NULL);
 	pm_runtime_mark_last_busy(mcspi->dev);
 	pm_runtime_put_autosuspend(mcspi->dev);
@@ -1052,7 +1059,8 @@ static void omap2_mcspi_cleanup(struct spi_device *spi)
 	}
 }
 
-static void omap2_mcspi_work(struct omap2_mcspi *mcspi, struct spi_message *m)
+static int omap2_mcspi_work_one(struct omap2_mcspi *mcspi,
+		struct spi_device *spi, struct spi_transfer *t)
 {
 
 	/* We only enable one channel at a time -- the one whose message is
@@ -1062,8 +1070,6 @@ static void omap2_mcspi_work(struct omap2_mcspi *mcspi, struct spi_message *m)
 	 * chipselect with the FORCE bit ... CS != channel enable.
 	 */
 
-	struct spi_device		*spi;
-	struct spi_transfer		*t = NULL;
 	struct spi_master		*master;
 	struct omap2_mcspi_dma		*mcspi_dma;
 	int				cs_active = 0;
@@ -1073,7 +1079,6 @@ static void omap2_mcspi_work(struct omap2_mcspi *mcspi, struct spi_message *m)
 	int				status = 0;
 	u32				chconf;
 
-	spi = m->spi;
 	master = spi->master;
 	mcspi_dma = mcspi->dma_channels + spi->chip_select;
 	cs = spi->controller_state;
@@ -1090,94 +1095,89 @@ static void omap2_mcspi_work(struct omap2_mcspi *mcspi, struct spi_message *m)
 		par_override = 1;
 
 	omap2_mcspi_set_enable(spi, 0);
-	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (t->tx_buf == NULL && t->rx_buf == NULL && t->len) {
-			status = -EINVAL;
-			break;
-		}
-		if (par_override ||
-		    (t->speed_hz != spi->max_speed_hz) ||
-		    (t->bits_per_word != spi->bits_per_word)) {
-			par_override = 1;
-			status = omap2_mcspi_setup_transfer(spi, t);
-			if (status < 0)
-				break;
-			if (t->speed_hz == spi->max_speed_hz &&
-			    t->bits_per_word == spi->bits_per_word)
-				par_override = 0;
-		}
-		if (cd && cd->cs_per_word) {
-			chconf = mcspi->ctx.modulctrl;
-			chconf &= ~OMAP2_MCSPI_MODULCTRL_SINGLE;
-			mcspi_write_reg(master, OMAP2_MCSPI_MODULCTRL, chconf);
-			mcspi->ctx.modulctrl =
-				mcspi_read_cs_reg(spi, OMAP2_MCSPI_MODULCTRL);
-		}
-
 
-		if (!cs_active) {
-			omap2_mcspi_force_cs(spi, 1);
-			cs_active = 1;
-		}
+	if (par_override ||
+	    (t->speed_hz != spi->max_speed_hz) ||
+	    (t->bits_per_word != spi->bits_per_word)) {
+		par_override = 1;
+		status = omap2_mcspi_setup_transfer(spi, t);
+		if (status < 0)
+			goto out;
+		if (t->speed_hz == spi->max_speed_hz &&
+		    t->bits_per_word == spi->bits_per_word)
+			par_override = 0;
+	}
+	if (cd && cd->cs_per_word) {
+		chconf = mcspi->ctx.modulctrl;
+		chconf &= ~OMAP2_MCSPI_MODULCTRL_SINGLE;
+		mcspi_write_reg(master, OMAP2_MCSPI_MODULCTRL, chconf);
+		mcspi->ctx.modulctrl =
+			mcspi_read_cs_reg(spi, OMAP2_MCSPI_MODULCTRL);
+	}
 
-		chconf = mcspi_cached_chconf0(spi);
-		chconf &= ~OMAP2_MCSPI_CHCONF_TRM_MASK;
-		chconf &= ~OMAP2_MCSPI_CHCONF_TURBO;
+	if (!cs_active) {
+		omap2_mcspi_force_cs(spi, 1);
+		cs_active = 1;
+	}
 
-		if (t->tx_buf == NULL)
-			chconf |= OMAP2_MCSPI_CHCONF_TRM_RX_ONLY;
-		else if (t->rx_buf == NULL)
-			chconf |= OMAP2_MCSPI_CHCONF_TRM_TX_ONLY;
-
-		if (cd && cd->turbo_mode && t->tx_buf == NULL) {
-			/* Turbo mode is for more than one word */
-			if (t->len > ((cs->word_len + 7) >> 3))
-				chconf |= OMAP2_MCSPI_CHCONF_TURBO;
-		}
+	chconf = mcspi_cached_chconf0(spi);
+	chconf &= ~OMAP2_MCSPI_CHCONF_TRM_MASK;
+	chconf &= ~OMAP2_MCSPI_CHCONF_TURBO;
+
+	if (t->tx_buf == NULL)
+		chconf |= OMAP2_MCSPI_CHCONF_TRM_RX_ONLY;
+	else if (t->rx_buf == NULL)
+		chconf |= OMAP2_MCSPI_CHCONF_TRM_TX_ONLY;
+
+	if (cd && cd->turbo_mode && t->tx_buf == NULL) {
+		/* Turbo mode is for more than one word */
+		if (t->len > ((cs->word_len + 7) >> 3))
+			chconf |= OMAP2_MCSPI_CHCONF_TURBO;
+	}
 
-		mcspi_write_chconf0(spi, chconf);
+	mcspi_write_chconf0(spi, chconf);
 
-		if (t->len) {
-			unsigned	count;
+	if (t->len) {
+		unsigned	count;
 
-			if ((mcspi_dma->dma_rx && mcspi_dma->dma_tx) &&
-			    (m->is_dma_mapped || t->len >= DMA_MIN_BYTES))
-				omap2_mcspi_set_fifo(spi, t, 1);
+		if ((mcspi_dma->dma_rx && mcspi_dma->dma_tx) &&
+		    (t->len >= DMA_MIN_BYTES))
+			omap2_mcspi_set_fifo(spi, t, 1);
 
-			omap2_mcspi_set_enable(spi, 1);
+		omap2_mcspi_set_enable(spi, 1);
 
-			/* RX_ONLY mode needs dummy data in TX reg */
-			if (t->tx_buf == NULL)
-				writel_relaxed(0, cs->base
-						+ OMAP2_MCSPI_TX0);
+		/* RX_ONLY mode needs dummy data in TX reg */
+		if (t->tx_buf == NULL)
+			writel_relaxed(0, cs->base
+					+ OMAP2_MCSPI_TX0);
 
-			if ((mcspi_dma->dma_rx && mcspi_dma->dma_tx) &&
-			    (m->is_dma_mapped || t->len >= DMA_MIN_BYTES))
-				count = omap2_mcspi_txrx_dma(spi, t);
-			else
-				count = omap2_mcspi_txrx_pio(spi, t);
-			m->actual_length += count;
+		if ((mcspi_dma->dma_rx && mcspi_dma->dma_tx) &&
+		    (t->len >= DMA_MIN_BYTES))
+			count = omap2_mcspi_txrx_dma(spi, t);
+		else
+			count = omap2_mcspi_txrx_pio(spi, t);
 
-			if (count != t->len) {
-				status = -EIO;
-				break;
-			}
+		if (count != t->len) {
+			status = -EIO;
+			goto out;
 		}
+	}
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+	if (t->delay_usecs)
+		udelay(t->delay_usecs);
 
-		/* ignore the "leave it on after last xfer" hint */
-		if (t->cs_change) {
-			omap2_mcspi_force_cs(spi, 0);
-			cs_active = 0;
-		}
+	/* ignore the "leave it on after last xfer" hint */
+	if (t->cs_change) {
+		omap2_mcspi_force_cs(spi, 0);
+		cs_active = 0;
+	}
 
-		omap2_mcspi_set_enable(spi, 0);
+	omap2_mcspi_set_enable(spi, 0);
 
-		if (mcspi->fifo_depth > 0)
-			omap2_mcspi_set_fifo(spi, t, 0);
-	}
+	if (mcspi->fifo_depth > 0)
+		omap2_mcspi_set_fifo(spi, t, 0);
+
+out:
 	/* Restore defaults if they were overriden */
 	if (par_override) {
 		par_override = 0;
@@ -1200,75 +1200,58 @@ static void omap2_mcspi_work(struct omap2_mcspi *mcspi, struct spi_message *m)
 	if (mcspi->fifo_depth > 0 && t)
 		omap2_mcspi_set_fifo(spi, t, 0);
 
-	m->status = status;
+	return status;
 }
 
-static int omap2_mcspi_transfer_one_message(struct spi_master *master,
-		struct spi_message *m)
+static int omap2_mcspi_transfer_one(struct spi_master *master,
+		struct spi_device *spi, struct spi_transfer *t)
 {
-	struct spi_device	*spi;
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_dma	*mcspi_dma;
-	struct spi_transfer	*t;
-	int status;
+	const void	*tx_buf = t->tx_buf;
+	void		*rx_buf = t->rx_buf;
+	unsigned	len = t->len;
 
-	spi = m->spi;
 	mcspi = spi_master_get_devdata(master);
 	mcspi_dma = mcspi->dma_channels + spi->chip_select;
-	m->actual_length = 0;
-	m->status = 0;
-
-	list_for_each_entry(t, &m->transfers, transfer_list) {
-		const void	*tx_buf = t->tx_buf;
-		void		*rx_buf = t->rx_buf;
-		unsigned	len = t->len;
-
-		if ((len && !(rx_buf || tx_buf))) {
-			dev_dbg(mcspi->dev, "transfer: %d Hz, %d %s%s, %d bpw\n",
-					t->speed_hz,
-					len,
-					tx_buf ? "tx" : "",
-					rx_buf ? "rx" : "",
-					t->bits_per_word);
-			status = -EINVAL;
-			goto out;
-		}
 
-		if (m->is_dma_mapped || len < DMA_MIN_BYTES)
-			continue;
-
-		if (mcspi_dma->dma_tx && tx_buf != NULL) {
-			t->tx_dma = dma_map_single(mcspi->dev, (void *) tx_buf,
-					len, DMA_TO_DEVICE);
-			if (dma_mapping_error(mcspi->dev, t->tx_dma)) {
-				dev_dbg(mcspi->dev, "dma %cX %d bytes error\n",
-						'T', len);
-				status = -EINVAL;
-				goto out;
-			}
+	if ((len && !(rx_buf || tx_buf))) {
+		dev_dbg(mcspi->dev, "transfer: %d Hz, %d %s%s, %d bpw\n",
+				t->speed_hz,
+				len,
+				tx_buf ? "tx" : "",
+				rx_buf ? "rx" : "",
+				t->bits_per_word);
+		return -EINVAL;
+	}
+
+	if (len < DMA_MIN_BYTES)
+		goto skip_dma_map;
+
+	if (mcspi_dma->dma_tx && tx_buf != NULL) {
+		t->tx_dma = dma_map_single(mcspi->dev, (void *) tx_buf,
+				len, DMA_TO_DEVICE);
+		if (dma_mapping_error(mcspi->dev, t->tx_dma)) {
+			dev_dbg(mcspi->dev, "dma %cX %d bytes error\n",
+					'T', len);
+			return -EINVAL;
 		}
-		if (mcspi_dma->dma_rx && rx_buf != NULL) {
-			t->rx_dma = dma_map_single(mcspi->dev, rx_buf, t->len,
-					DMA_FROM_DEVICE);
-			if (dma_mapping_error(mcspi->dev, t->rx_dma)) {
-				dev_dbg(mcspi->dev, "dma %cX %d bytes error\n",
-						'R', len);
-				if (tx_buf != NULL)
-					dma_unmap_single(mcspi->dev, t->tx_dma,
-							len, DMA_TO_DEVICE);
-				status = -EINVAL;
-				goto out;
-			}
+	}
+	if (mcspi_dma->dma_rx && rx_buf != NULL) {
+		t->rx_dma = dma_map_single(mcspi->dev, rx_buf, t->len,
+				DMA_FROM_DEVICE);
+		if (dma_mapping_error(mcspi->dev, t->rx_dma)) {
+			dev_dbg(mcspi->dev, "dma %cX %d bytes error\n",
+					'R', len);
+			if (tx_buf != NULL)
+				dma_unmap_single(mcspi->dev, t->tx_dma,
+						len, DMA_TO_DEVICE);
+			return -EINVAL;
 		}
 	}
 
-	omap2_mcspi_work(mcspi, m);
-	/* spi_finalize_current_message() changes the status inside the
-	 * spi_message, save the status here. */
-	status = m->status;
-out:
-	spi_finalize_current_message(master);
-	return status;
+skip_dma_map:
+	return omap2_mcspi_work_one(mcspi, spi, t);
 }
 
 static int omap2_mcspi_master_setup(struct omap2_mcspi *mcspi)
@@ -1347,7 +1330,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	master->setup = omap2_mcspi_setup;
 	master->auto_runtime_pm = true;
-	master->transfer_one_message = omap2_mcspi_transfer_one_message;
+	master->transfer_one = omap2_mcspi_transfer_one;
 	master->cleanup = omap2_mcspi_cleanup;
 	master->dev.of_node = node;
 	master->max_speed_hz = OMAP2_MCSPI_MAX_FREQ;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
