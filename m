From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 22/49] spi: davinci: remove unnecessary 'count' variable in
	driver private data
Date: Wed, 17 Nov 2010 16:13:54 +0530
Message-ID: <1289990661-30126-23-git-send-email-nsekhar@ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1289990661-30126-22-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>

The variable count in DaVinci SPI driver's private data is
largely unused and its minor use can easily be eliminated.

Remove the variable.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/davinci_spi.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 1169e8e..ad814f2 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -142,7 +142,6 @@ struct davinci_spi {
 	const void		*tx;
 	void			*rx;
 	u8			*tmp_buf;
-	int			count;
 	struct davinci_spi_dma	*dma_channels;
 	struct davinci_spi_platform_data *pdata;
 
@@ -630,8 +629,6 @@ static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
 
 	/* convert len to words based on bits_per_word */
 	conv = davinci_spi->bytes_per_word[spi->chip_select];
-	davinci_spi->count = t->len / conv;
-
 	data1_reg_val = ioread32(davinci_spi->base + SPIDAT1);
 
 	INIT_COMPLETION(davinci_spi->done);
@@ -643,7 +640,7 @@ static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
 	/* Enable SPI */
 	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_MASK);
 
-	count = davinci_spi->count;
+	count = t->len / conv;
 
 	/* Determine the command to execute READ or WRITE */
 	if (t->tx_buf) {
@@ -699,7 +696,7 @@ static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
 		} else {	/* Receive in Interrupt mode */
 			int i;
 
-			for (i = 0; i < davinci_spi->count; i++) {
+			for (i = 0; i < count; i++) {
 				set_io_bits(davinci_spi->base + SPIINT,
 						SPIINT_BITERR_INTR
 						| SPIINT_OVRRUN_INTR
@@ -754,7 +751,6 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 
 	/* convert len to words based on bits_per_word */
 	data_type = davinci_spi->bytes_per_word[spi->chip_select];
-	davinci_spi->count = t->len / data_type;
 
 	data1_reg_val = ioread32(davinci_spi->base + SPIDAT1);
 
@@ -767,7 +763,7 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 	if (ret)
 		return ret;
 
-	count = davinci_spi->count;	/* the number of elements */
+	count = t->len / data_type;	/* the number of elements */
 
 	/* disable all interrupts for dma transfers */
 	clear_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKALL);
-- 
1.7.3.2


------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
