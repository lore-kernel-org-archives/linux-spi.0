From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 19/49] spi: davinci: simplify calculation of edma acount value
Date: Wed, 17 Nov 2010 16:13:51 +0530
Message-ID: <1289990661-30126-20-git-send-email-nsekhar@ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-19-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
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

The EDMA acount (called data_type in davinci_spi_bufs_dma())
is simply the bytes_per_word obtained in the transfer setup
function. The current code calculates the acount value from
bytes_per_word in a convoluted manner. Simplify the code.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/davinci_spi.c |   25 +++----------------------
 1 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index f1c3502..b0b338f 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -39,9 +39,6 @@
 #define CS_DEFAULT	0xFF
 
 #define SPI_BUFSIZ	(SMP_CACHE_BYTES + 1)
-#define DAVINCI_DMA_DATA_TYPE_S8	0x01
-#define DAVINCI_DMA_DATA_TYPE_S16	0x02
-#define DAVINCI_DMA_DATA_TYPE_S32	0x04
 
 #define SPIFMT_PHASE_MASK	BIT(16)
 #define SPIFMT_POLARITY_MASK	BIT(17)
@@ -729,19 +726,14 @@ static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
 	return t->len;
 }
 
-#define DAVINCI_DMA_DATA_TYPE_S8	0x01
-#define DAVINCI_DMA_DATA_TYPE_S16	0x02
-#define DAVINCI_DMA_DATA_TYPE_S32	0x04
-
 static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct davinci_spi *davinci_spi;
 	int int_status = 0;
 	int count, temp_count;
-	u8 conv = 1;
 	u32 data1_reg_val;
 	struct davinci_spi_dma *davinci_spi_dma;
-	int word_len, data_type, ret;
+	int data_type, ret;
 	unsigned long tx_reg, rx_reg;
 	struct device *sdev;
 
@@ -757,8 +749,8 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 	davinci_spi->rx = t->rx_buf;
 
 	/* convert len to words based on bits_per_word */
-	conv = davinci_spi->bytes_per_word[spi->chip_select];
-	davinci_spi->count = t->len / conv;
+	data_type = davinci_spi->bytes_per_word[spi->chip_select];
+	davinci_spi->count = t->len / data_type;
 
 	data1_reg_val = ioread32(davinci_spi->base + SPIDAT1);
 
@@ -767,17 +759,6 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 	init_completion(&davinci_spi_dma->dma_rx_completion);
 	init_completion(&davinci_spi_dma->dma_tx_completion);
 
-	word_len = conv * 8;
-
-	if (word_len <= 8)
-		data_type = DAVINCI_DMA_DATA_TYPE_S8;
-	else if (word_len <= 16)
-		data_type = DAVINCI_DMA_DATA_TYPE_S16;
-	else if (word_len <= 32)
-		data_type = DAVINCI_DMA_DATA_TYPE_S32;
-	else
-		return -EINVAL;
-
 	ret = davinci_spi_bufs_prep(spi, davinci_spi);
 	if (ret)
 		return ret;
-- 
1.7.3.2
