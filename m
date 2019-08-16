From: Vladimir Oltean <olteanv@gmail.com>
Subject: [RFC PATCH net-next 06/11] spi: spi-fsl-dspi: Implement the PTP system timestamping
Date: Fri, 16 Aug 2019 03:44:44 +0300
Message-ID: <20190816004449.10100-7-olteanv@gmail.com>
References: <20190816004449.10100-1-olteanv@gmail.com>
Cc: linux-spi@vger.kernel.org, netdev@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>
To: h.feurstein@gmail.com, mlichvar@redhat.com,
        richardcochran@gmail.com, andrew@lunn.ch, f.fainelli@gmail.com,
        broonie@kernel.org
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190816004449.10100-1-olteanv@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This adds a snapshotting software feature for TCFQ and EOQ modes of
operation. Due to my lack of proper understanding of the DMA mode,
the latter mode is left as an exercise for future developers.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 41c45ee2bb2d..3fc266d8263a 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -184,6 +184,9 @@ struct fsl_dspi {
 	int			irq;
 	struct clk		*clk;
 
+	struct ptp_system_timestamp *ptp_sts;
+	const void		*ptp_sts_word;
+	bool			take_snapshot;
 	struct spi_transfer	*cur_transfer;
 	struct spi_message	*cur_msg;
 	struct chip_data	*cur_chip;
@@ -658,6 +661,9 @@ static int dspi_rxtx(struct fsl_dspi *dspi)
 	u16 spi_tcnt;
 	u32 spi_tcr;
 
+	if (dspi->take_snapshot)
+		ptp_read_system_postts(dspi->ptp_sts);
+
 	/* Get transfer counter (in number of SPI transfers). It was
 	 * reset to 0 when transfer(s) were started.
 	 */
@@ -675,6 +681,11 @@ static int dspi_rxtx(struct fsl_dspi *dspi)
 		/* Success! */
 		return 0;
 
+	dspi->take_snapshot = (dspi->tx == dspi->ptp_sts_word);
+
+	if (dspi->take_snapshot)
+		ptp_read_system_prets(dspi->ptp_sts);
+
 	if (dspi->devtype_data->trans_mode == DSPI_EOQ_MODE)
 		dspi_eoq_write(dspi);
 	else
@@ -764,6 +775,8 @@ static int dspi_transfer_one_message(struct spi_master *master,
 		dspi->rx = transfer->rx_buf;
 		dspi->rx_end = dspi->rx + transfer->len;
 		dspi->len = transfer->len;
+		dspi->ptp_sts = transfer->ptp_sts;
+		dspi->ptp_sts_word = dspi->tx + transfer->ptp_sts_word_offset;
 		/* Validated transfer specific frame size (defaults applied) */
 		dspi->bits_per_word = transfer->bits_per_word;
 		if (transfer->bits_per_word <= 8)
@@ -784,6 +797,11 @@ static int dspi_transfer_one_message(struct spi_master *master,
 				     SPI_FRAME_EBITS(transfer->bits_per_word) |
 				     SPI_CTARE_DTCP(1));
 
+		dspi->take_snapshot = (dspi->tx == dspi->ptp_sts_word);
+
+		if (dspi->take_snapshot)
+			ptp_read_system_prets(dspi->ptp_sts);
+
 		trans_mode = dspi->devtype_data->trans_mode;
 		switch (trans_mode) {
 		case DSPI_EOQ_MODE:
-- 
2.17.1
