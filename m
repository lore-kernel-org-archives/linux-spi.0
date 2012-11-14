From: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi/bcm63xx: fix multi transfer messages
Date: Wed, 14 Nov 2012 23:22:26 +0100
Message-ID: <1352931747-19893-1-git-send-email-jonas.gorski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The BCM63XX SPI controller does not support keeping CS asserted after
sending its buffer. This breaks common usages like spi_write_then_read,
where it is expected to be kept active during the whole transfers.

Work around this by combining the transfers into one if the buffer
allows. For spi_write_then_read, use the prepend byte feature to write
to "prepend" the write if it is less than 15 bytes, allowing the whole
fifo size for the read.

Signed-off-by: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Tested on a SPI conntected switch which required keeping CS active between
the register read command and reading the register contents.

Based on Mark's spi/next.

Not sure if this is stable material, as it's quite invasive.

 drivers/spi/spi-bcm63xx.c |  172 ++++++++++++++++++++++++++++++---------------
 1 file changed, 117 insertions(+), 55 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 6d97047..da557f9 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -37,6 +37,8 @@
 
 #define PFX		KBUILD_MODNAME
 
+#define BCM63XX_SPI_MAX_PREPEND		15
+
 struct bcm63xx_spi {
 	struct completion	done;
 
@@ -49,16 +51,10 @@ struct bcm63xx_spi {
 	unsigned int		msg_type_shift;
 	unsigned int		msg_ctl_width;
 
-	/* Data buffers */
-	const unsigned char	*tx_ptr;
-	unsigned char		*rx_ptr;
-
 	/* data iomem */
 	u8 __iomem		*tx_io;
 	const u8 __iomem	*rx_io;
 
-	int			remaining_bytes;
-
 	struct clk		*clk;
 	struct platform_device	*pdev;
 };
@@ -175,50 +171,60 @@ static int bcm63xx_spi_setup(struct spi_device *spi)
 	return 0;
 }
 
-/* Fill the TX FIFO with as many bytes as possible */
-static void bcm63xx_spi_fill_tx_fifo(struct bcm63xx_spi *bs)
-{
-	u8 size;
-
-	/* Fill the Tx FIFO with as many bytes as possible */
-	size = bs->remaining_bytes < bs->fifo_size ? bs->remaining_bytes :
-		bs->fifo_size;
-	memcpy_toio(bs->tx_io, bs->tx_ptr, size);
-	bs->remaining_bytes -= size;
-}
-
 static unsigned int bcm63xx_txrx_bufs(struct spi_device *spi,
-					struct spi_transfer *t)
+					struct spi_transfer *first,
+					unsigned int n_transfers)
 {
 	struct bcm63xx_spi *bs = spi_master_get_devdata(spi->master);
 	u16 msg_ctl;
 	u16 cmd;
+	unsigned int i, timeout, total_len = 0, prepend_len = 0, len = 0;
+	struct spi_transfer *t = first;
+	u8 rx_tail;
+	bool do_rx = false;
+	bool do_tx = false;
 
 	/* Disable the CMD_DONE interrupt */
 	bcm_spi_writeb(bs, 0, SPI_INT_MASK);
 
-	dev_dbg(&spi->dev, "txrx: tx %p, rx %p, len %d\n",
-		t->tx_buf, t->rx_buf, t->len);
+	if (n_transfers > 1 && t->tx_buf && t->len <= BCM63XX_SPI_MAX_PREPEND)
+		prepend_len = t->len;
 
-	/* Transmitter is inhibited */
-	bs->tx_ptr = t->tx_buf;
-	bs->rx_ptr = t->rx_buf;
+	/* prepare the buffer */
+	for (i = 0; i < n_transfers; i++) {
+		if (t->tx_buf) {
+			do_tx = true;
+			memcpy_toio(bs->tx_io + total_len, t->tx_buf, t->len);
+
+			/* don't prepend more than one tx */
+			if (t != first)
+				prepend_len = 0;
+		}
 
-	if (t->tx_buf) {
-		bs->remaining_bytes = t->len;
-		bcm63xx_spi_fill_tx_fifo(bs);
+		if (t->rx_buf) {
+			do_rx = true;
+			if (t == first)
+				prepend_len = 0;
+		}
+
+		total_len += t->len;
+
+		t = list_entry(t->transfer_list.next, struct spi_transfer,
+			       transfer_list);
 	}
 
+	len = total_len - prepend_len;
+
 	init_completion(&bs->done);
 
 	/* Fill in the Message control register */
-	msg_ctl = (t->len << SPI_BYTE_CNT_SHIFT);
+	msg_ctl = (len << SPI_BYTE_CNT_SHIFT);
 
-	if (t->rx_buf && t->tx_buf)
+	if (do_rx && do_tx && prepend_len == 0)
 		msg_ctl |= (SPI_FD_RW << bs->msg_type_shift);
-	else if (t->rx_buf)
+	else if (do_rx)
 		msg_ctl |= (SPI_HD_R << bs->msg_type_shift);
-	else if (t->tx_buf)
+	else if (do_tx)
 		msg_ctl |= (SPI_HD_W << bs->msg_type_shift);
 
 	switch (bs->msg_ctl_width) {
@@ -232,14 +238,41 @@ static unsigned int bcm63xx_txrx_bufs(struct spi_device *spi,
 
 	/* Issue the transfer */
 	cmd = SPI_CMD_START_IMMEDIATE;
-	cmd |= (0 << SPI_CMD_PREPEND_BYTE_CNT_SHIFT);
+	cmd |= (prepend_len << SPI_CMD_PREPEND_BYTE_CNT_SHIFT);
 	cmd |= (spi->chip_select << SPI_CMD_DEVICE_ID_SHIFT);
 	bcm_spi_writew(bs, cmd, SPI_CMD);
 
 	/* Enable the CMD_DONE interrupt */
 	bcm_spi_writeb(bs, SPI_INTR_CMD_DONE, SPI_INT_MASK);
 
-	return t->len - bs->remaining_bytes;
+	timeout = wait_for_completion_timeout(&bs->done, HZ);
+	if (!timeout)
+		return -ETIMEDOUT;
+
+	/* read out all data */
+	rx_tail = bcm_spi_readb(bs, SPI_RX_TAIL);
+
+	if (do_rx && rx_tail != len)
+		return -EINVAL;
+
+	if (!rx_tail)
+		return total_len;
+
+	len = 0;
+	t = first;
+	/* Read out all the data */
+	for (i = 0; i < n_transfers; i++) {
+		if (t->rx_buf)
+			memcpy_fromio(t->rx_buf, bs->rx_io + len, t->len);
+
+		if (t != first || prepend_len == 0)
+			len += t->len;
+
+		t = list_entry(t->transfer_list.next, struct spi_transfer,
+			       transfer_list);
+	}
+
+	return total_len;
 }
 
 static int bcm63xx_spi_prepare_transfer(struct spi_master *master)
@@ -264,42 +297,71 @@ static int bcm63xx_spi_transfer_one(struct spi_master *master,
 					struct spi_message *m)
 {
 	struct bcm63xx_spi *bs = spi_master_get_devdata(master);
-	struct spi_transfer *t;
+	struct spi_transfer *t, *first = NULL;
 	struct spi_device *spi = m->spi;
 	int status = 0;
-	unsigned int timeout = 0;
-
+	unsigned int n_transfers = 0, total_len = 0;
+	bool can_use_prepend = false;
+
+	/*
+	 * This SPI controller does not support keeping CS active after a
+	 * transfer, so we need to combine the transfers into one until we may
+	 * deassert CS.
+	 */
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		unsigned int len = t->len;
-		u8 rx_tail;
-
 		status = bcm63xx_spi_check_transfer(spi, t);
 		if (status < 0)
 			goto exit;
 
-		/* configure adapter for a new transfer */
-		bcm63xx_spi_setup_transfer(spi, t);
+		if (!first)
+			first = t;
 
-		while (len) {
-			/* send the data */
-			len -= bcm63xx_txrx_bufs(spi, t);
+		n_transfers++;
+		total_len += t->len;
 
-			timeout = wait_for_completion_timeout(&bs->done, HZ);
-			if (!timeout) {
-				status = -ETIMEDOUT;
-				goto exit;
-			}
+		if (n_transfers == 2 && !first->rx_buf && !t->tx_buf &&
+		    first->len <= BCM63XX_SPI_MAX_PREPEND)
+			can_use_prepend = true;
+		else if (can_use_prepend && t->tx_buf)
+			can_use_prepend = false;
+
+		if ((can_use_prepend &&
+		     total_len > (bs->fifo_size + BCM63XX_SPI_MAX_PREPEND)) ||
+		    (!can_use_prepend && total_len > bs->fifo_size)) {
+			status = -EINVAL;
+			goto exit;
+		}
 
-			/* read out all data */
-			rx_tail = bcm_spi_readb(bs, SPI_RX_TAIL);
+		/* all transfers have to be made at the same speed */
+		if (t->speed_hz != first->speed_hz) {
+			status = -EINVAL;
+			goto exit;
+		}
 
-			/* Read out all the data */
-			if (rx_tail)
-				memcpy_fromio(bs->rx_ptr, bs->rx_io, rx_tail);
+		/* CS will be deasserted directly after the transfer */
+		if (t->delay_usecs) {
+			status = -EINVAL;
+			goto exit;
 		}
 
-		m->actual_length += t->len;
+		if (t->cs_change ||
+		    list_is_last(&t->transfer_list, &m->transfers)) {
+			/* configure adapter for a new transfer */
+			bcm63xx_spi_setup_transfer(spi, first);
+
+			status = bcm63xx_txrx_bufs(spi, first, n_transfers);
+			if (status < 0)
+				goto exit;
+
+			m->actual_length += status;
+			first = NULL;
+			status = 0;
+			n_transfers = 0;
+			total_len = 0;
+			can_use_prepend = false;
+		}
 	}
+
 exit:
 	m->status = status;
 	spi_finalize_current_message(master);
-- 
1.7.10.4


------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
