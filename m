From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 17/49] spi: davinci: eliminate the single member structure
	davinci_spi_slave
Date: Wed, 17 Nov 2010 16:13:49 +0530
Message-ID: <1289990661-30126-18-git-send-email-nsekhar@ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-17-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
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

The struct davinci_spi_slave has a single member. Eliminate it
and store the per-chipselect data in struct davinci_spi directly.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/davinci_spi.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 31b9c22..3dac2038 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -118,10 +118,6 @@
 #define SPIDEF		0x4c
 #define SPIFMT0		0x50
 
-struct davinci_spi_slave {
-	u32	bytes_per_word;
-};
-
 /* We have 2 DMA channels per CS, one for RX and one for TX */
 struct davinci_spi_dma {
 	int			dma_tx_channel;
@@ -156,7 +152,7 @@ struct davinci_spi {
 	void			(*get_rx)(u32 rx_data, struct davinci_spi *);
 	u32			(*get_tx)(struct davinci_spi *);
 
-	struct davinci_spi_slave slave[SPI_MAX_CHIPSELECT];
+	u8			bytes_per_word[SPI_MAX_CHIPSELECT];
 };
 
 static struct davinci_spi_config davinci_spi_default_cfg;
@@ -324,11 +320,11 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 	if (bits_per_word <= 8 && bits_per_word >= 2) {
 		davinci_spi->get_rx = davinci_spi_rx_buf_u8;
 		davinci_spi->get_tx = davinci_spi_tx_buf_u8;
-		davinci_spi->slave[spi->chip_select].bytes_per_word = 1;
+		davinci_spi->bytes_per_word[spi->chip_select] = 1;
 	} else if (bits_per_word <= 16 && bits_per_word >= 2) {
 		davinci_spi->get_rx = davinci_spi_rx_buf_u16;
 		davinci_spi->get_tx = davinci_spi_tx_buf_u16;
-		davinci_spi->slave[spi->chip_select].bytes_per_word = 2;
+		davinci_spi->bytes_per_word[spi->chip_select] = 2;
 	} else
 		return -EINVAL;
 
@@ -632,7 +628,7 @@ static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
 	davinci_spi->rx = t->rx_buf;
 
 	/* convert len to words based on bits_per_word */
-	conv = davinci_spi->slave[spi->chip_select].bytes_per_word;
+	conv = davinci_spi->bytes_per_word[spi->chip_select];
 	davinci_spi->count = t->len / conv;
 
 	data1_reg_val = ioread32(davinci_spi->base + SPIDAT1);
@@ -764,7 +760,7 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 	davinci_spi->rx = t->rx_buf;
 
 	/* convert len to words based on bits_per_word */
-	conv = davinci_spi->slave[spi->chip_select].bytes_per_word;
+	conv = davinci_spi->bytes_per_word[spi->chip_select];
 	davinci_spi->count = t->len / conv;
 
 	data1_reg_val = ioread32(davinci_spi->base + SPIDAT1);
-- 
1.7.3.2
