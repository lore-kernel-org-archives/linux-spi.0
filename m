From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 03/49] spi: davinci: remove unused variable 'pdata'
Date: Wed, 17 Nov 2010 16:13:35 +0530
Message-ID: <1289990661-30126-4-git-send-email-nsekhar@ti.com>
References: <1289990661-30126-1-git-send-email-nsekhar@ti.com>
	<1289990661-30126-2-git-send-email-nsekhar@ti.com>
	<1289990661-30126-3-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-3-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
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

The 'pdata' variable is unused in couple of routines.

Remove such occurences.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/davinci_spi.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 2fa5bec..a92f507 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -299,12 +299,10 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 {
 
 	struct davinci_spi *davinci_spi;
-	struct davinci_spi_platform_data *pdata;
 	u8 bits_per_word = 0;
 	u32 hz = 0, prescale = 0, clkspeed;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
-	pdata = davinci_spi->pdata;
 
 	if (t) {
 		bits_per_word = t->bits_per_word;
@@ -357,11 +355,9 @@ static void davinci_spi_dma_rx_callback(unsigned lch, u16 ch_status, void *data)
 	struct spi_device *spi = (struct spi_device *)data;
 	struct davinci_spi *davinci_spi;
 	struct davinci_spi_dma *davinci_spi_dma;
-	struct davinci_spi_platform_data *pdata;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
 	davinci_spi_dma = &(davinci_spi->dma_channels[spi->chip_select]);
-	pdata = davinci_spi->pdata;
 
 	if (ch_status == DMA_COMPLETE)
 		edma_stop(davinci_spi_dma->dma_rx_channel);
@@ -378,11 +374,9 @@ static void davinci_spi_dma_tx_callback(unsigned lch, u16 ch_status, void *data)
 	struct spi_device *spi = (struct spi_device *)data;
 	struct davinci_spi *davinci_spi;
 	struct davinci_spi_dma *davinci_spi_dma;
-	struct davinci_spi_platform_data *pdata;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
 	davinci_spi_dma = &(davinci_spi->dma_channels[spi->chip_select]);
-	pdata = davinci_spi->pdata;
 
 	if (ch_status == DMA_COMPLETE)
 		edma_stop(davinci_spi_dma->dma_tx_channel);
@@ -398,13 +392,11 @@ static int davinci_spi_request_dma(struct spi_device *spi)
 {
 	struct davinci_spi *davinci_spi;
 	struct davinci_spi_dma *davinci_spi_dma;
-	struct davinci_spi_platform_data *pdata;
 	struct device *sdev;
 	int r;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
 	davinci_spi_dma = &davinci_spi->dma_channels[spi->chip_select];
-	pdata = davinci_spi->pdata;
 	sdev = davinci_spi->bitbang.master->dev.parent;
 
 	r = edma_alloc_channel(davinci_spi_dma->dma_rx_sync_dev,
-- 
1.7.3.2
