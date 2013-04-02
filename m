From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V2 01/12] spi/mxs: Always set LOCK_CS
Date: Tue,  2 Apr 2013 05:19:44 -0700
Message-ID: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

There are two bits which control the CS line in the CTRL0 register:
LOCK_CS and IGNORE_CRC.  The latter would be better named DEASSERT_CS
in SPI mode.

LOCK_CS keeps CS asserted though the entire transfer.  This should
always be set.  The DMA code will always set it, explicitly on the
first segment of the first transfer, and then implicitly on all the
rest by never clearing the bit from the value read from the ctrl0
register.

The only reason to not set LOCK_CS would be to attempt an altered
protocol where CS pulses between each word.  Though don't get your
hopes up if you want to do this, as the hardware doesn't appear to do
this in any sane manner.

The code can be simplified by just setting LOCK_CS once and then not
needing to deal with it in the PIO and DMA transfer functions.

Signed-off-by: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mxs.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 22a0af0..9334167 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -91,6 +91,8 @@ static int mxs_spi_setup_transfer(struct spi_device *dev,
 
 	mxs_ssp_set_clk_rate(ssp, hz);
 
+	writel(BM_SSP_CTRL0_LOCK_CS,
+		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
 	writel(BF_SSP_CTRL1_SSP_MODE(BV_SSP_CTRL1_SSP_MODE__SPI) |
 		     BF_SSP_CTRL1_WORD_LENGTH
 		     (BV_SSP_CTRL1_WORD_LENGTH__EIGHT_BITS) |
@@ -159,8 +161,6 @@ static inline void mxs_spi_enable(struct mxs_spi *spi)
 {
 	struct mxs_ssp *ssp = &spi->ssp;
 
-	writel(BM_SSP_CTRL0_LOCK_CS,
-		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
 	writel(BM_SSP_CTRL0_IGNORE_CRC,
 		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
 }
@@ -169,8 +169,6 @@ static inline void mxs_spi_disable(struct mxs_spi *spi)
 {
 	struct mxs_ssp *ssp = &spi->ssp;
 
-	writel(BM_SSP_CTRL0_LOCK_CS,
-		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
 	writel(BM_SSP_CTRL0_IGNORE_CRC,
 		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
 }
@@ -244,8 +242,6 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
 	ctrl0 &= ~BM_SSP_CTRL0_XFER_COUNT;
 	ctrl0 |= BM_SSP_CTRL0_DATA_XFER | mxs_spi_cs_to_reg(cs);
 
-	if (*first)
-		ctrl0 |= BM_SSP_CTRL0_LOCK_CS;
 	if (!write)
 		ctrl0 |= BM_SSP_CTRL0_READ;
 
-- 
1.7.10.4


------------------------------------------------------------------------------
Own the Future-Intel(R) Level Up Game Demo Contest 2013
Rise to greatness in Intel's independent game demo contest. Compete 
for recognition, cash, and the chance to get your game on Steam. 
$5K grand prize plus 10 genre and skill prizes. Submit your demo 
by 6/6/13. http://altfarm.mediaplex.com/ad/ck/12124-176961-30367-2
