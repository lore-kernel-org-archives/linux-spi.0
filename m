From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] spi: conditional checking of mode and transfer bits.
Date: Thu, 22 Aug 2013 21:20:48 +0530
Message-ID: <1377186648-16616-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

There is a bug in the following patch:
http://comments.gmane.org/gmane.linux.kernel.spi.devel/14420

spi: DUAL and QUAD support

    fix the previous patch some mistake below:
    1. DT in slave node, use "spi-tx-nbits = <1/2/4>" in place of using
       "spi-tx-dual, spi-tx-quad" directly, same to rx. So correct the
       previous way to get the property in @of_register_spi_devices().
    2. Change the value of transfer bit macro(SPI_NBITS_SINGLE, SPI_NBITS_DUAL
       SPI_NBITS_QUAD) to 0x01, 0x02 and 0x04 to match the actual wires.
    3. Add the following check
       (1)keep the tx_nbits and rx_nbits in spi_transfer is not beyond the
          single, dual and quad.
       (2)keep tx_nbits and rx_nbits are contained by @spi_device->mode
          example: if @spi_device->mode = DUAL, then tx/rx_nbits can not be set
                   to QUAD(SPI_NBITS_QUAD)
       (3)if "@spi_device->mode & SPI_3WIRE", then tx/rx_nbits should be in
          single(SPI_NBITS_SINGLE)

Checking of the tx/rx transfer bits and mode bits should be done conditionally
based on type of buffer filled else EINVAL condition will
always get hit either for rx or tx.

Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
---
This patch is developed on top of Mark Brown SPI tree[1]:
[1]: git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
branch: remotes/brownspi/topic/quad
This branch has the parent patch with the bug.
 drivers/spi/spi.c |   56 ++++++++++++++++++++++++++++------------------------
 1 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 39d3875..50f7fc3 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1473,33 +1473,37 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
 		 * 2. keep tx/rx_nbits is contained by mode in spi_device
 		 * 3. if SPI_3WIRE, tx/rx_nbits should be in single
 		 */
-		if (xfer->tx_nbits != SPI_NBITS_SINGLE &&
-			xfer->tx_nbits != SPI_NBITS_DUAL &&
-			xfer->tx_nbits != SPI_NBITS_QUAD)
-			return -EINVAL;
-		if ((xfer->tx_nbits == SPI_NBITS_DUAL) &&
-			!(spi->mode & (SPI_TX_DUAL | SPI_TX_QUAD)))
-			return -EINVAL;
-		if ((xfer->tx_nbits == SPI_NBITS_QUAD) &&
-			!(spi->mode & SPI_TX_QUAD))
-			return -EINVAL;
-		if ((spi->mode & SPI_3WIRE) &&
-			(xfer->tx_nbits != SPI_NBITS_SINGLE))
-			return -EINVAL;
+		if (xfer->tx_buf) {
+			if (xfer->tx_nbits != SPI_NBITS_SINGLE &&
+				xfer->tx_nbits != SPI_NBITS_DUAL &&
+				xfer->tx_nbits != SPI_NBITS_QUAD)
+				return -EINVAL;
+			if ((xfer->tx_nbits == SPI_NBITS_DUAL) &&
+				!(spi->mode & (SPI_TX_DUAL | SPI_TX_QUAD)))
+				return -EINVAL;
+			if ((xfer->tx_nbits == SPI_NBITS_QUAD) &&
+				!(spi->mode & SPI_TX_QUAD))
+				return -EINVAL;
+			if ((spi->mode & SPI_3WIRE) &&
+				(xfer->tx_nbits != SPI_NBITS_SINGLE))
+				return -EINVAL;
+		}
 		/* check transfer rx_nbits */
-		if (xfer->rx_nbits != SPI_NBITS_SINGLE &&
-			xfer->rx_nbits != SPI_NBITS_DUAL &&
-			xfer->rx_nbits != SPI_NBITS_QUAD)
-			return -EINVAL;
-		if ((xfer->rx_nbits == SPI_NBITS_DUAL) &&
-			!(spi->mode & (SPI_RX_DUAL | SPI_RX_QUAD)))
-			return -EINVAL;
-		if ((xfer->rx_nbits == SPI_NBITS_QUAD) &&
-			!(spi->mode & SPI_RX_QUAD))
-			return -EINVAL;
-		if ((spi->mode & SPI_3WIRE) &&
-			(xfer->rx_nbits != SPI_NBITS_SINGLE))
-			return -EINVAL;
+		if (xfer->rx_buf) {
+			if (xfer->rx_nbits != SPI_NBITS_SINGLE &&
+				xfer->rx_nbits != SPI_NBITS_DUAL &&
+				xfer->rx_nbits != SPI_NBITS_QUAD)
+				return -EINVAL;
+			if ((xfer->rx_nbits == SPI_NBITS_DUAL) &&
+				!(spi->mode & (SPI_RX_DUAL | SPI_RX_QUAD)))
+				return -EINVAL;
+			if ((xfer->rx_nbits == SPI_NBITS_QUAD) &&
+				!(spi->mode & SPI_RX_QUAD))
+				return -EINVAL;
+			if ((spi->mode & SPI_3WIRE) &&
+				(xfer->rx_nbits != SPI_NBITS_SINGLE))
+				return -EINVAL;
+		}
 	}
 
 	message->spi = spi;
-- 
1.7.1


------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
