From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [REGRESSION] d7b4394e breaks bi-directional DMA transfers on
	omap2-mcspi
Date: Wed, 31 Oct 2012 20:59:23 +0530
Message-ID: <CAM=Q2ctLtGneTfuALDQBk68mEnOxHseZ1fkvcoTks-0j+VyTxQ@mail.gmail.com>
References: <651D981E4B29F74ABD63CE74C2E4788E08A612E22A@SLOMAILPRD01.polycom.com>
	<CAM=Q2ctN8nGvmbzO8K-hMeUKsp9kVbPxvO=OidkJZcLBfqOTLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org"
	<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	"shubhrajyoti-l0cyMroinI0@public.gmane.org" <shubhrajyoti-l0cyMroinI0@public.gmane.org>
To: =?ISO-8859-1?Q?S=F8rensen=2C_Stefan?= <Stefan.Sorensen-I0ystx/e7NpBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAM=Q2ctN8nGvmbzO8K-hMeUKsp9kVbPxvO=OidkJZcLBfqOTLQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Oct 31, 2012 at 7:27 PM, Shubhrajyoti Datta
<omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Wed, Oct 31, 2012 at 5:46 PM, S=F8rensen, Stefan
[...]
>
> Will test and get back with a proper patch.

Let me know if this solves.

>From 07a59cb82955c37eff6fe06ba25958dc1b5c5f56 Mon Sep 17 00:00:00 2001
From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Date: Wed, 31 Oct 2012 19:15:25 +0530
Subject: [PATCH] spi: omap2-mcspi: Reorder the wait_for_completion for tx

The commit  d7b4394e[Cleanup the omap2_mcspi_txrx_dma function]
changed the wait_for_completion order. Move the wait so that the
rx doesnot wait for the tx to complete.

Reported-by: S=F8rensen, Stefan <Sorensen-I0ystx/e7NpBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c |   39 +++++++++++++++++++------------------=
--
 1 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index bcfd062..251f6d0 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -323,18 +323,13 @@ static void omap2_mcspi_tx_dma(struct spi_device *spi,
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_dma  *mcspi_dma;
 	unsigned int		count;
-	u8			* rx;
 	const u8		* tx;
-	void __iomem		*chstat_reg;
-	struct omap2_mcspi_cs	*cs =3D spi->controller_state;

 	mcspi =3D spi_master_get_devdata(spi->master);
 	mcspi_dma =3D &mcspi->dma_channels[spi->chip_select];
 	count =3D xfer->len;

-	rx =3D xfer->rx_buf;
 	tx =3D xfer->tx_buf;
-	chstat_reg =3D cs->base + OMAP2_MCSPI_CHSTAT0;

 	if (mcspi_dma->dma_tx) {
 		struct dma_async_tx_descriptor *tx;
@@ -359,19 +354,6 @@ static void omap2_mcspi_tx_dma(struct spi_device *spi,
 	dma_async_issue_pending(mcspi_dma->dma_tx);
 	omap2_mcspi_set_dma_req(spi, 0, 1);

-	wait_for_completion(&mcspi_dma->dma_tx_completion);
-	dma_unmap_single(mcspi->dev, xfer->tx_dma, count,
-			 DMA_TO_DEVICE);
-
-	/* for TX_ONLY mode, be sure all words have shifted out */
-	if (rx =3D=3D NULL) {
-		if (mcspi_wait_for_reg_bit(chstat_reg,
-					OMAP2_MCSPI_CHSTAT_TXS) < 0)
-			dev_err(&spi->dev, "TXS timed out\n");
-		else if (mcspi_wait_for_reg_bit(chstat_reg,
-					OMAP2_MCSPI_CHSTAT_EOT) < 0)
-			dev_err(&spi->dev, "EOT timed out\n");
-	}
 }

 static unsigned
@@ -492,6 +474,7 @@ omap2_mcspi_txrx_dma(struct spi_device *spi,
struct spi_transfer *xfer)
 	struct dma_slave_config	cfg;
 	enum dma_slave_buswidth width;
 	unsigned es;
+	void __iomem		*chstat_reg;

 	mcspi =3D spi_master_get_devdata(spi->master);
 	mcspi_dma =3D &mcspi->dma_channels[spi->chip_select];
@@ -526,8 +509,24 @@ omap2_mcspi_txrx_dma(struct spi_device *spi,
struct spi_transfer *xfer)
 		omap2_mcspi_tx_dma(spi, xfer, cfg);

 	if (rx !=3D NULL)
-		return omap2_mcspi_rx_dma(spi, xfer, cfg, es);
-
+		count =3D omap2_mcspi_rx_dma(spi, xfer, cfg, es);
+
+	if (tx !=3D NULL) {
+		chstat_reg =3D cs->base + OMAP2_MCSPI_CHSTAT0;
+		wait_for_completion(&mcspi_dma->dma_tx_completion);
+		dma_unmap_single(mcspi->dev, xfer->tx_dma, xfer->len,
+				 DMA_TO_DEVICE);
+
+		/* for TX_ONLY mode, be sure all words have shifted out */
+		if (rx =3D=3D NULL) {
+			if (mcspi_wait_for_reg_bit(chstat_reg,
+						OMAP2_MCSPI_CHSTAT_TXS) < 0)
+				dev_err(&spi->dev, "TXS timed out\n");
+			else if (mcspi_wait_for_reg_bit(chstat_reg,
+						OMAP2_MCSPI_CHSTAT_EOT) < 0)
+				dev_err(&spi->dev, "EOT timed out\n");
+		}
+	}
 	return count;
 }

-- =

1.7.5.4

---------------------------------------------------------------------------=
---
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
