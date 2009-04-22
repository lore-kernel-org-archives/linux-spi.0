From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v6] spi: Add PPC4xx SPI driver
Date: Tue, 21 Apr 2009 22:36:12 -0700
Message-ID: <200904212236.12904.david-b@pacbell.net>
References: <1231411250-25380-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1231411250-25380-1-git-send-email-sr-ynQEQJNshbs@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thursday 08 January 2009, Stefan Roese wrote:
> This adds a SPI driver for the SPI controller found in the IBM/AMCC
> 4xx PowerPC's.

Note that given some patches now in the mm tree, this needs
something like the appended fixup.  Some common code has now
moved into the spi core.

- Dave


---
 drivers/spi/spi_ppc4xx.c |   19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

--- a/drivers/spi/spi_ppc4xx.c
+++ b/drivers/spi/spi_ppc4xx.c
@@ -61,9 +61,6 @@
 /* RxD ready */
 #define SPI_PPC4XX_SR_RBR	(0x80 >> 7)
 
-/* the spi->mode bits understood by this driver: */
-#define MODEBITS	(SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST)
-
 /* clock settings (SCP and CI) for various SPI modes */
 #define SPI_CLK_MODE0	SPI_PPC4XX_MODE_SCP
 #define SPI_CLK_MODE1	0
@@ -198,9 +195,6 @@ static int spi_ppc4xx_setup(struct spi_d
 	struct spi_ppc4xx_cs *cs = spi->controller_state;
 	int init = 0;
 
-	if (!spi->bits_per_word)
-		spi->bits_per_word = 8;
-
 	if (spi->bits_per_word != 8) {
 		dev_err(&spi->dev, "invalid bits-per-word (%d)\n",
 			spi->bits_per_word);
@@ -212,12 +206,6 @@ static int spi_ppc4xx_setup(struct spi_d
 		return -EINVAL;
 	}
 
-	if (spi->mode & ~MODEBITS) {
-		dev_dbg(&spi->dev, "setup: unsupported mode bits %x\n",
-			spi->mode & ~MODEBITS);
-		return -EINVAL;
-	}
-
 	if (cs == NULL) {
 		cs = kzalloc(sizeof *cs, GFP_KERNEL);
 		if (!cs)
@@ -268,10 +256,6 @@ static int spi_ppc4xx_setup(struct spi_d
 		}
 	}
 
-	dev_dbg(&spi->dev, "%s: mode %d, %u bpw, %d hz\n",
-		__func__, spi->mode, spi->bits_per_word,
-		spi->max_speed_hz);
-
 	return 0;
 }
 
@@ -442,6 +426,9 @@ static int __init spi_ppc4xx_of_probe(st
 		}
 	}
 
+	/* the spi->mode bits understood by this driver: */
+	master->modebits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST;
+
 	/* Setup the state for the bitbang driver */
 	bbp = &hw->bitbang;
 	bbp->master = hw->master;

------------------------------------------------------------------------------
Stay on top of everything new and different, both inside and 
around Java (TM) technology - register by April 22, and save
$200 on the JavaOne (SM) conference, June 2-5, 2009, San Francisco.
300 plus technical and hands-on sessions. Register today. 
Use priority code J9JMT32. http://p.sf.net/sfu/p
