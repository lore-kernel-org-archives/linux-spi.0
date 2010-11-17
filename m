From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 14/49] spi: davinci: setup chip-select timers values only if
	timer enabled
Date: Wed, 17 Nov 2010 16:13:46 +0530
Message-ID: <1289990661-30126-15-git-send-email-nsekhar@ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-14-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>

Setup chip-select timers values only if timer is enabled
(timer_disbled in spi configuration is false).

As a nice side effect, this patch removes code duplicated in
davinci_spi_bufs_pio() and davinci_spi_bufs_dma().

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/davinci_spi.c |   21 ++++-----------------
 1 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 34b28fe..d09b63c 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -374,6 +374,10 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 
 		if (spicfg->timer_disable)
 			spifmt |= SPIFMT_DISTIMER_MASK;
+		else
+			iowrite32((spicfg->c2tdelay << SPI_C2TDELAY_SHIFT) |
+				  (spicfg->t2cdelay << SPI_T2CDELAY_SHIFT),
+				  davinci_spi->base + SPIDELAY);
 
 		if (spi->mode & SPI_READY)
 			spifmt |= SPIFMT_WAITENA_MASK;
@@ -607,13 +611,9 @@ static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
 	u32 tx_data, data1_reg_val;
 	u32 buf_val, flg_val;
 	struct davinci_spi_platform_data *pdata;
-	struct davinci_spi_config *spicfg;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
 	pdata = davinci_spi->pdata;
-	spicfg = (struct davinci_spi_config *)spi->controller_data;
-	if (!spicfg)
-		spicfg = &davinci_spi_default_cfg;
 
 	davinci_spi->tx = t->tx_buf;
 	davinci_spi->rx = t->rx_buf;
@@ -633,10 +633,6 @@ static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
 	/* Enable SPI */
 	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_MASK);
 
-	iowrite32((spicfg->c2tdelay << SPI_C2TDELAY_SHIFT) |
-			(spicfg->t2cdelay << SPI_T2CDELAY_SHIFT),
-			davinci_spi->base + SPIDELAY);
-
 	count = davinci_spi->count;
 
 	/* Determine the command to execute READ or WRITE */
@@ -741,14 +737,10 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 	struct davinci_spi_dma *davinci_spi_dma;
 	int word_len, data_type, ret;
 	unsigned long tx_reg, rx_reg;
-	struct davinci_spi_config *spicfg;
 	struct device *sdev;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
 	sdev = davinci_spi->bitbang.master->dev.parent;
-	spicfg = (struct davinci_spi_config *)spi->controller_data;
-	if (!spicfg)
-		spicfg = &davinci_spi_default_cfg;
 
 	davinci_spi_dma = &davinci_spi->dma_channels[spi->chip_select];
 
@@ -784,11 +776,6 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 	if (ret)
 		return ret;
 
-	/* Put delay val if required */
-	iowrite32((spicfg->c2tdelay << SPI_C2TDELAY_SHIFT) |
-			(spicfg->t2cdelay << SPI_T2CDELAY_SHIFT),
-			davinci_spi->base + SPIDELAY);
-
 	count = davinci_spi->count;	/* the number of elements */
 
 	/* disable all interrupts for dma transfers */
-- 
1.7.3.2
