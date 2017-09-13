From: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 2/2] spi: armada-3700: Fix padding when sending not 4-byte aligned data
Date: Wed, 13 Sep 2017 18:21:39 +0200
Message-ID: <20170913162139.17598-3-miquel.raynal@free-electrons.com>
References: <20170913162139.17598-1-miquel.raynal@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
        Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Zachary Zhang <zhangzg-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170913162139.17598-1-miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Zachary Zhang <zhangzg-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

In 4-byte transfer mode, extra padding/dummy bytes '0xff' would be
sent in write operation if TX data is not 4-byte aligned since the
SPI data register is always shifted out as whole 4 bytes.

Fix this by using the header count feature that allows to transfer 0 to
4 bytes. Use it to actually send the first 1 to 3 bytes of data before
the rest of the buffer that will hence be 4-byte aligned.

Signed-off-by: Zachary Zhang <zhangzg-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/spi/spi-armada-3700.c | 135 +++++++++++++-----------------------------
 1 file changed, 41 insertions(+), 94 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index a28702b1fa05..9172cb2d2e7a 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -99,11 +99,6 @@
 /* A3700_SPI_IF_TIME_REG */
 #define A3700_SPI_CLK_CAPT_EDGE		BIT(7)
 
-/* Flags and macros for struct a3700_spi */
-#define A3700_INSTR_CNT			1
-#define A3700_ADDR_CNT			3
-#define A3700_DUMMY_CNT			1
-
 struct a3700_spi {
 	struct spi_master *master;
 	void __iomem *base;
@@ -117,9 +112,6 @@ struct a3700_spi {
 	u8 byte_len;
 	u32 wait_mask;
 	struct completion done;
-	u32 addr_cnt;
-	u32 instr_cnt;
-	size_t hdr_cnt;
 };
 
 static u32 spireg_read(struct a3700_spi *a3700_spi, u32 offset)
@@ -449,59 +441,43 @@ static void a3700_spi_set_cs(struct spi_device *spi, bool enable)
 
 static void a3700_spi_header_set(struct a3700_spi *a3700_spi)
 {
-	u32 instr_cnt = 0, addr_cnt = 0, dummy_cnt = 0;
+	unsigned int addr_cnt;
 	u32 val = 0;
 
 	/* Clear the header registers */
 	spireg_write(a3700_spi, A3700_SPI_IF_INST_REG, 0);
 	spireg_write(a3700_spi, A3700_SPI_IF_ADDR_REG, 0);
 	spireg_write(a3700_spi, A3700_SPI_IF_RMODE_REG, 0);
+	spireg_write(a3700_spi, A3700_SPI_IF_HDR_CNT_REG, 0);
 
 	/* Set header counters */
 	if (a3700_spi->tx_buf) {
-		if (a3700_spi->buf_len <= a3700_spi->instr_cnt) {
-			instr_cnt = a3700_spi->buf_len;
-		} else if (a3700_spi->buf_len <= (a3700_spi->instr_cnt +
-						  a3700_spi->addr_cnt)) {
-			instr_cnt = a3700_spi->instr_cnt;
-			addr_cnt = a3700_spi->buf_len - instr_cnt;
-		} else if (a3700_spi->buf_len <= a3700_spi->hdr_cnt) {
-			instr_cnt = a3700_spi->instr_cnt;
-			addr_cnt = a3700_spi->addr_cnt;
-			/* Need to handle the normal write case with 1 byte
-			 * data
-			 */
-			if (!a3700_spi->tx_buf[instr_cnt + addr_cnt])
-				dummy_cnt = a3700_spi->buf_len - instr_cnt -
-					    addr_cnt;
+		/*
+		 * when tx data is not 4 bytes aligned, there will be unexpected
+		 * bytes out of SPI output register, since it always shifts out
+		 * as whole 4 bytes. This might cause incorrect transaction with
+		 * some devices. To avoid that, use SPI header count feature to
+		 * transfer up to 3 bytes of data first, and then make the rest
+		 * of data 4-byte aligned.
+		 */
+		addr_cnt = a3700_spi->buf_len % 4;
+		if (addr_cnt) {
+			val = (addr_cnt & A3700_SPI_ADDR_CNT_MASK)
+				<< A3700_SPI_ADDR_CNT_BIT;
+			spireg_write(a3700_spi, A3700_SPI_IF_HDR_CNT_REG, val);
+
+			/* Update the buffer length to be transferred */
+			a3700_spi->buf_len -= addr_cnt;
+
+			/* transfer 1~3 bytes through address count */
+			val = 0;
+			while (addr_cnt--) {
+				val = (val << 8) | a3700_spi->tx_buf[0];
+				a3700_spi->tx_buf++;
+			}
+			spireg_write(a3700_spi, A3700_SPI_IF_ADDR_REG, val);
 		}
-		val |= ((instr_cnt & A3700_SPI_INSTR_CNT_MASK)
-			<< A3700_SPI_INSTR_CNT_BIT);
-		val |= ((addr_cnt & A3700_SPI_ADDR_CNT_MASK)
-			<< A3700_SPI_ADDR_CNT_BIT);
-		val |= ((dummy_cnt & A3700_SPI_DUMMY_CNT_MASK)
-			<< A3700_SPI_DUMMY_CNT_BIT);
 	}
-	spireg_write(a3700_spi, A3700_SPI_IF_HDR_CNT_REG, val);
-
-	/* Update the buffer length to be transferred */
-	a3700_spi->buf_len -= (instr_cnt + addr_cnt + dummy_cnt);
-
-	/* Set Instruction */
-	val = 0;
-	while (instr_cnt--) {
-		val = (val << 8) | a3700_spi->tx_buf[0];
-		a3700_spi->tx_buf++;
-	}
-	spireg_write(a3700_spi, A3700_SPI_IF_INST_REG, val);
-
-	/* Set Address */
-	val = 0;
-	while (addr_cnt--) {
-		val = (val << 8) | a3700_spi->tx_buf[0];
-		a3700_spi->tx_buf++;
-	}
-	spireg_write(a3700_spi, A3700_SPI_IF_ADDR_REG, val);
 }
 
 static int a3700_is_wfifo_full(struct a3700_spi *a3700_spi)
@@ -515,35 +491,12 @@ static int a3700_is_wfifo_full(struct a3700_spi *a3700_spi)
 static int a3700_spi_fifo_write(struct a3700_spi *a3700_spi)
 {
 	u32 val;
-	int i = 0;
 
 	while (!a3700_is_wfifo_full(a3700_spi) && a3700_spi->buf_len) {
-		val = 0;
-		if (a3700_spi->buf_len >= 4) {
-			val = cpu_to_le32(*(u32 *)a3700_spi->tx_buf);
-			spireg_write(a3700_spi, A3700_SPI_DATA_OUT_REG, val);
-
-			a3700_spi->buf_len -= 4;
-			a3700_spi->tx_buf += 4;
-		} else {
-			/*
-			 * If the remained buffer length is less than 4-bytes,
-			 * we should pad the write buffer with all ones. So that
-			 * it avoids overwrite the unexpected bytes following
-			 * the last one.
-			 */
-			val = GENMASK(31, 0);
-			while (a3700_spi->buf_len) {
-				val &= ~(0xff << (8 * i));
-				val |= *a3700_spi->tx_buf++ << (8 * i);
-				i++;
-				a3700_spi->buf_len--;
-
-				spireg_write(a3700_spi, A3700_SPI_DATA_OUT_REG,
-					     val);
-			}
-			break;
-		}
+		val = cpu_to_le32(*(u32 *)a3700_spi->tx_buf);
+		spireg_write(a3700_spi, A3700_SPI_DATA_OUT_REG, val);
+		a3700_spi->buf_len -= 4;
+		a3700_spi->tx_buf += 4;
 	}
 
 	return 0;
@@ -648,9 +601,6 @@ static int a3700_spi_transfer_one(struct spi_master *master,
 	a3700_spi->rx_buf  = xfer->rx_buf;
 	a3700_spi->buf_len = xfer->len;
 
-	/* SPI transfer headers */
-	a3700_spi_header_set(a3700_spi);
-
 	if (xfer->tx_buf)
 		nbits = xfer->tx_nbits;
 	else if (xfer->rx_buf)
@@ -658,6 +608,12 @@ static int a3700_spi_transfer_one(struct spi_master *master,
 
 	a3700_spi_pin_mode_set(a3700_spi, nbits, xfer->rx_buf ? true : false);
 
+	/* Flush the FIFOs */
+	a3700_spi_fifo_flush(a3700_spi);
+
+	/* Transfer first bytes of data when buffer is not 4-byte aligned */
+	a3700_spi_header_set(a3700_spi);
+
 	if (xfer->rx_buf) {
 		/* Set read data length */
 		spireg_write(a3700_spi, A3700_SPI_IF_DIN_CNT_REG,
@@ -736,16 +692,11 @@ static int a3700_spi_transfer_one(struct spi_master *master,
 				dev_err(&spi->dev, "wait wfifo empty timed out\n");
 				return -ETIMEDOUT;
 			}
-		} else {
-			/*
-			 * If the instruction in SPI_INSTR does not require data
-			 * to be written to the SPI device, wait until SPI_RDY
-			 * is 1 for the SPI interface to be in idle.
-			 */
-			if (!a3700_spi_transfer_wait(spi, A3700_SPI_XFER_RDY)) {
-				dev_err(&spi->dev, "wait xfer ready timed out\n");
-				return -ETIMEDOUT;
-			}
+		}
+
+		if (!a3700_spi_transfer_wait(spi, A3700_SPI_XFER_RDY)) {
+			dev_err(&spi->dev, "wait xfer ready timed out\n");
+			return -ETIMEDOUT;
 		}
 
 		val = spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
@@ -837,10 +788,6 @@ static int a3700_spi_probe(struct platform_device *pdev)
 	memset(spi, 0, sizeof(struct a3700_spi));
 
 	spi->master = master;
-	spi->instr_cnt = A3700_INSTR_CNT;
-	spi->addr_cnt = A3700_ADDR_CNT;
-	spi->hdr_cnt = A3700_INSTR_CNT + A3700_ADDR_CNT +
-		       A3700_DUMMY_CNT;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	spi->base = devm_ioremap_resource(dev, res);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
