From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 26/49] spi: davinci: simplify poll mode transfers
Date: Wed, 17 Nov 2010 16:13:58 +0530
Message-ID: <1289990661-30126-27-git-send-email-nsekhar@ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-26-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
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

From: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>

Use the fact that the get_tx and get_rx can now cope with
NULL buffer pointers to simplify the poll mode transfer
code.

While at it, check for SPI errors every transfer rather than
at the end of the whole transfer.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/davinci_spi.c |   96 +++++++++++++++++++--------------------------
 1 files changed, 41 insertions(+), 55 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 198f062..cd37697 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -91,6 +91,10 @@
 #define SPIFLG_BITERR_MASK		BIT(4)
 #define SPIFLG_OVRRUN_MASK		BIT(6)
 #define SPIFLG_BUF_INIT_ACTIVE_MASK	BIT(24)
+#define SPIFLG_ERROR_MASK		(SPIFLG_DLEN_ERR_MASK \
+				| SPIFLG_TIMEOUT_MASK | SPIFLG_PARERR_MASK \
+				| SPIFLG_DESYNC_MASK | SPIFLG_BITERR_MASK \
+				| SPIFLG_OVRRUN_MASK)
 
 #define SPIINT_DMA_REQ_EN	BIT(16)
 
@@ -601,10 +605,10 @@ static int davinci_spi_check_error(struct davinci_spi *davinci_spi,
 static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct davinci_spi *davinci_spi;
-	int status, count, ret;
-	u8 conv;
+	int ret;
+	int rcount, wcount;
 	u32 tx_data, data1_reg_val;
-	u32 buf_val, flg_val;
+	u32 errors = 0;
 	struct davinci_spi_platform_data *pdata;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
@@ -612,70 +616,51 @@ static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
 
 	davinci_spi->tx = t->tx_buf;
 	davinci_spi->rx = t->rx_buf;
-
-	/* convert len to words based on bits_per_word */
-	conv = davinci_spi->bytes_per_word[spi->chip_select];
-	data1_reg_val = ioread32(davinci_spi->base + SPIDAT1);
+	wcount = t->len / davinci_spi->bytes_per_word[spi->chip_select];
+	rcount = wcount;
 
 	ret = davinci_spi_bufs_prep(spi, davinci_spi);
 	if (ret)
 		return ret;
 
+	data1_reg_val = ioread32(davinci_spi->base + SPIDAT1);
+
 	/* Enable SPI */
 	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_MASK);
 
-	count = t->len / conv;
-
 	clear_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKALL);
 
-	/* Determine the command to execute READ or WRITE */
-	if (t->tx_buf) {
+	/* start the transfer */
+	wcount--;
+	tx_data = davinci_spi->get_tx(davinci_spi);
+	data1_reg_val &= 0xFFFF0000;
+	data1_reg_val |= tx_data & 0xFFFF;
+	iowrite32(data1_reg_val, davinci_spi->base + SPIDAT1);
 
-		while (1) {
-			tx_data = davinci_spi->get_tx(davinci_spi);
+	while (rcount > 0 || wcount > 0) {
 
-			data1_reg_val &= ~(0xFFFF);
-			data1_reg_val |= (0xFFFF & tx_data);
-
-			buf_val = ioread32(davinci_spi->base + SPIBUF);
-			if ((buf_val & SPIBUF_TXFULL_MASK) == 0) {
-				iowrite32(data1_reg_val,
-						davinci_spi->base + SPIDAT1);
-
-				count--;
-			}
-			while (ioread32(davinci_spi->base + SPIBUF)
-					& SPIBUF_RXEMPTY_MASK)
-				cpu_relax();
-
-			/* getting the returned byte */
-			if (t->rx_buf) {
-				buf_val = ioread32(davinci_spi->base + SPIBUF);
-				davinci_spi->get_rx(buf_val, davinci_spi);
-			}
-			if (count <= 0)
-				break;
-		}
-	} else {
-		while (1) {
-			/* keeps the serial clock going */
-			if ((ioread32(davinci_spi->base + SPIBUF)
-					& SPIBUF_TXFULL_MASK) == 0)
-				iowrite32(data1_reg_val,
-					davinci_spi->base + SPIDAT1);
+		u32 buf, status;
 
-				while (ioread32(davinci_spi->base + SPIBUF) &
-							SPIBUF_RXEMPTY_MASK)
-					cpu_relax();
+		buf = ioread32(davinci_spi->base + SPIBUF);
 
-			flg_val = ioread32(davinci_spi->base + SPIFLG);
-			buf_val = ioread32(davinci_spi->base + SPIBUF);
+		if (!(buf & SPIBUF_RXEMPTY_MASK)) {
+			davinci_spi->get_rx(buf & 0xFFFF, davinci_spi);
+			rcount--;
+		}
 
-			davinci_spi->get_rx(buf_val, davinci_spi);
+		status = ioread32(davinci_spi->base + SPIFLG);
 
-			count--;
-			if (count <= 0)
-				break;
+		if (unlikely(status & SPIFLG_ERROR_MASK)) {
+			errors = status & SPIFLG_ERROR_MASK;
+			break;
+		}
+
+		if (wcount > 0 && !(buf & SPIBUF_TXFULL_MASK)) {
+			wcount--;
+			tx_data = davinci_spi->get_tx(davinci_spi);
+			data1_reg_val &= ~0xFFFF;
+			data1_reg_val |= 0xFFFF & tx_data;
+			iowrite32(data1_reg_val, davinci_spi->base + SPIDAT1);
 		}
 	}
 
@@ -683,11 +668,12 @@ static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
 	 * Check for bit error, desync error,parity error,timeout error and
 	 * receive overflow errors
 	 */
-	status = ioread32(davinci_spi->base + SPIFLG);
-
-	ret = davinci_spi_check_error(davinci_spi, status);
-	if (ret != 0)
+	if (errors) {
+		ret = davinci_spi_check_error(davinci_spi, errors);
+		WARN(!ret, "%s: error reported but no error found!\n",
+							dev_name(&spi->dev));
 		return ret;
+	}
 
 	return t->len;
 }
-- 
1.7.3.2
