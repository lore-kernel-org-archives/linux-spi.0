From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 02/49] spi: davinci: whitespace cleanup
Date: Wed, 17 Nov 2010 16:13:34 +0530
Message-ID: <1289990661-30126-3-git-send-email-nsekhar@ti.com>
References: <1289990661-30126-1-git-send-email-nsekhar@ti.com>
	<1289990661-30126-2-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-2-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
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

Cleanup unnecessary white space from various
parts of the file.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/davinci_spi.c |   22 ++++++++++------------
 1 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 6b04762..2fa5bec 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -175,7 +175,7 @@ struct davinci_spi {
 	u8			*tmp_buf;
 	int			count;
 	struct davinci_spi_dma	*dma_channels;
-	struct			davinci_spi_platform_data *pdata;
+	struct davinci_spi_platform_data *pdata;
 
 	void			(*get_rx)(u32 rx_data, struct davinci_spi *);
 	u32			(*get_tx)(struct davinci_spi *);
@@ -435,7 +435,6 @@ static int davinci_spi_request_dma(struct spi_device *spi)
  *
  * This functions sets the default transfer method.
  */
-
 static int davinci_spi_setup(struct spi_device *spi)
 {
 	int retval;
@@ -1096,7 +1095,6 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	}
 	clk_enable(davinci_spi->clk);
 
-
 	master->bus_num = pdev->id;
 	master->num_chipselect = pdata->num_chipselect;
 	master->setup = davinci_spi_setup;
@@ -1113,15 +1111,15 @@ static int davinci_spi_probe(struct platform_device *pdev)
 		davinci_spi->bitbang.flags |= SPI_READY;
 
 	if (use_dma) {
-			r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-			if (r)
-				dma_rx_chan = r->start;
-			r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-			if (r)
-				dma_tx_chan = r->start;
-			r = platform_get_resource(pdev, IORESOURCE_DMA, 2);
-			if (r)
-				dma_eventq = r->start;
+		r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+		if (r)
+			dma_rx_chan = r->start;
+		r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+		if (r)
+			dma_tx_chan = r->start;
+		r = platform_get_resource(pdev, IORESOURCE_DMA, 2);
+		if (r)
+			dma_eventq = r->start;
 	}
 
 	if (!use_dma ||
-- 
1.7.3.2
