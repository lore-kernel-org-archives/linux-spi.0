From: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH v1 2/3] spi: mpc512x: improve throughput in the RX/TX func
Date: Mon,  3 Jun 2013 14:03:50 +0200
Message-ID: <1370261031-28572-3-git-send-email-gsi@denx.de>
References: <1370261031-28572-1-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, dzu-ynQEQJNshbs@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1370261031-28572-1-git-send-email-gsi-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

change the MPC512x SPI controller's transmission routine to increase
throughput: allow the RX byte counter to "lag behind" the TX byte
counter while iterating over the transfer's data, only wait for the
remaining RX bytes at the very end of the transfer

this approach eliminates delays in the milliseconds range, transfer
times for e.g. 16MB of SPI flash data dropped from 31s to 9s, correct
operation was tested by continuously transferring and comparing data
from an SPI flash (more than 200GB in some 45 hours)

background information on the motivation:

one might assume that all the RX data should have been received when the
TX data was sent, given the fact that we are the SPI master and provide
all of the clock, but in practise there's a difference

the ISR is triggered when the TX FIFO became empty, while transmission
of the last item still occurs (from the TX hold and shift registers),
sampling RX data on the opposite clock edge compared to the TX data adds
another delay (half a bit period), and RX data needs to propagate from
the reception buffer to the RX FIFO depending on the specific SoC
implementation

to cut it short: a difference between TX and RX byte counters during
transmission is not just acceptable but should be considered the regular
case, only the very end of the transfer needs to make sure that all of
the RX data was received before deasserting the chip select and telling
the caller that transmission has completed

Signed-off-by: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
---
 drivers/spi/spi-mpc512x-psc.c |  141 +++++++++++++++++++++++++++++++----------
 1 file changed, 107 insertions(+), 34 deletions(-)


remaining style question:

shall this background information and the discussion on the motivation
be considered common knowledge which is not worth keeping around?  or
shall the comments at least not spread across the code but instead get
concentrated in a central spot (like right above the routine)?

I feel that the current form of inline comments is appropriate since it
closely relates the comments to the actions taken, but others might
disagree -- I'm fine with both approaches and happily accept feedback on
the matter


diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 759a937..53c7899 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -137,6 +137,7 @@ static int mpc512x_psc_spi_transfer_rxtx(struct spi_device *spi,
 	struct mpc52xx_psc __iomem *psc = mps->psc;
 	struct mpc512x_psc_fifo __iomem *fifo = mps->fifo;
 	size_t tx_len = t->len;
+	size_t rx_len = t->len;
 	u8 *tx_buf = (u8 *)t->tx_buf;
 	u8 *rx_buf = (u8 *)t->rx_buf;
 
@@ -150,57 +151,129 @@ static int mpc512x_psc_spi_transfer_rxtx(struct spi_device *spi,
 	/* enable transmiter/receiver */
 	out_8(&psc->command, MPC52xx_PSC_TX_ENABLE | MPC52xx_PSC_RX_ENABLE);
 
-	while (tx_len) {
+	while (rx_len || tx_len) {
 		size_t txcount;
-		int i;
 		u8 data;
 		size_t fifosz;
 		size_t rxcount;
+		int rxtries;
 
 		/*
-		 * The number of bytes that can be sent at a time
-		 * depends on the fifo size.
+		 * send the TX bytes in as large a chunk as possible
+		 * but neither exceed the TX nor the RX FIFOs
 		 */
 		fifosz = MPC512x_PSC_FIFO_SZ(in_be32(&fifo->txsz));
 		txcount = min(fifosz, tx_len);
+		fifosz = MPC512x_PSC_FIFO_SZ(in_be32(&fifo->rxsz));
+		fifosz -= in_be32(&fifo->rxcnt) + 1;
+		txcount = min(fifosz, txcount);
+		if (txcount) {
+
+			/* fill the TX FIFO */
+			while (txcount-- > 0) {
+				data = tx_buf ? *tx_buf++ : 0;
+				if (tx_len == EOFBYTE && t->cs_change)
+					setbits32(&fifo->txcmd,
+						  MPC512x_PSC_FIFO_EOF);
+				out_8(&fifo->txdata_8, data);
+				tx_len--;
+			}
 
-		for (i = txcount; i > 0; i--) {
-			data = tx_buf ? *tx_buf++ : 0;
-			if (tx_len == EOFBYTE && t->cs_change)
-				setbits32(&fifo->txcmd, MPC512x_PSC_FIFO_EOF);
-			out_8(&fifo->txdata_8, data);
-			tx_len--;
+			/* have the ISR trigger when the TX FIFO is empty */
+			INIT_COMPLETION(mps->txisrdone);
+			out_be32(&fifo->txisr, MPC512x_PSC_FIFO_EMPTY);
+			out_be32(&fifo->tximr, MPC512x_PSC_FIFO_EMPTY);
+			wait_for_completion(&mps->txisrdone);
 		}
 
-		INIT_COMPLETION(mps->txisrdone);
-
-		/* interrupt on tx fifo empty */
-		out_be32(&fifo->txisr, MPC512x_PSC_FIFO_EMPTY);
-		out_be32(&fifo->tximr, MPC512x_PSC_FIFO_EMPTY);
-
-		wait_for_completion(&mps->txisrdone);
-
-		mdelay(1);
+		/*
+		 * consume as much RX data as the FIFO holds, while we
+		 * iterate over the transfer's TX data length
+		 *
+		 * only insist in draining all the remaining RX bytes
+		 * when the TX bytes were exhausted (that's at the very
+		 * end of this transfer, not when still iterating over
+		 * the transfer's chunks)
+		 */
+		rxtries = 50;
+		do {
+
+			/*
+			 * grab whatever was in the FIFO when we started
+			 * looking, don't bother fetching what was added to
+			 * the FIFO while we read from it -- we'll return
+			 * here eventually and prefer sending out remaining
+			 * TX data
+			 */
+			fifosz = in_be32(&fifo->rxcnt);
+			rxcount = min(fifosz, rx_len);
+			while (rxcount-- > 0) {
+				data = in_8(&fifo->rxdata_8);
+				if (rx_buf)
+					*rx_buf++ = data;
+				rx_len--;
+			}
 
-		/* rx fifo should have txcount bytes in it */
-		rxcount = in_be32(&fifo->rxcnt);
-		if (rxcount != txcount)
-			mdelay(1);
+			/*
+			 * come back later if there still is TX data to send,
+			 * bail out of the RX drain loop if all of the TX data
+			 * was sent and all of the RX data was received (i.e.
+			 * when the transmission has completed)
+			 */
+			if (tx_len)
+				break;
+			if (!rx_len)
+				break;
 
-		rxcount = in_be32(&fifo->rxcnt);
-		if (rxcount != txcount) {
-			dev_warn(&spi->dev, "expected %d bytes in rx fifo "
-				 "but got %d\n", txcount, rxcount);
+			/*
+			 * TX data transmission has completed while RX data
+			 * is still pending -- that's a transient situation
+			 * which depends on wire speed and specific
+			 * hardware implementation details (buffering) yet
+			 * should resolve very quickly
+			 *
+			 * just yield for a moment to not hog the CPU for
+			 * too long when running SPI at low speed
+			 *
+			 * the timeout range is rather arbitrary and tries
+			 * to balance throughput against system load; the
+			 * chosen values result in a minimal timeout of 50
+			 * times 10us and thus work at speeds as low as
+			 * some 20kbps, while the maximum timeout at the
+			 * transfer's end could be 5ms _if_ nothing else
+			 * ticks in the system _and_ RX data still wasn't
+			 * received, which only occurs in situations that
+			 * are exceptional; removing the unpredictability
+			 * of the timeout either decreases throughput
+			 * (longer timeouts), or puts more load on the
+			 * system (fixed short timeouts) or requires the
+			 * use of a timeout API instead of a counter and an
+			 * unknown inner delay
+			 */
+			usleep_range(10, 100);
+
+		} while (--rxtries > 0);
+		if (!tx_len && rx_len && !rxtries) {
+			/*
+			 * not enough RX bytes even after several retries
+			 * and the resulting rather long timeout?
+			 */
+			rxcount = in_be32(&fifo->rxcnt);
+			dev_warn(&spi->dev,
+				 "short xfer, missing %zd RX bytes, FIFO level %zd\n",
+				 rx_len, rxcount);
 		}
 
-		rxcount = min(rxcount, txcount);
-		for (i = rxcount; i > 0; i--) {
-			data = in_8(&fifo->rxdata_8);
-			if (rx_buf)
-				*rx_buf++ = data;
+		/*
+		 * drain and drop RX data which "should not be there" in
+		 * the first place, for undisturbed transmission this turns
+		 * into a NOP (except for the FIFO level fetch)
+		 */
+		if (!tx_len && !rx_len) {
+			while (in_be32(&fifo->rxcnt))
+				in_8(&fifo->rxdata_8);
 		}
-		while (in_be32(&fifo->rxcnt))
-			in_8(&fifo->rxdata_8);
+
 	}
 	/* disable transmiter/receiver and fifo interrupt */
 	out_8(&psc->command, MPC52xx_PSC_TX_DISABLE | MPC52xx_PSC_RX_DISABLE);
-- 
1.7.10.4


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
