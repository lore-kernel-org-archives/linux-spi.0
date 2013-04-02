From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V2 04/12] spi/mxs: Fix extra CS pulses and read mode in
	multi-transfer messages
Date: Tue,  2 Apr 2013 05:19:47 -0700
Message-ID: <1364905195-24286-4-git-send-email-tpiepho@gmail.com>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1364905195-24286-1-git-send-email-tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

Setting DEASSERT_CS causes CS to be de-asserted at the end of the
transfer.  It would normally be set on the final segment of the final
transfer.  The DMA code explicitly sets it in this case, but because
it never clears the bit from the ctrl0 register is will remain set for
all transfers in subsequent messages.  This results in a CS pulse
between transfers.

There is a similar problem with the read mode bit never being cleared
in DMA mode.

This patch fixes DEASSERT_CS and READ being left on in DMA mode.

Signed-off-by: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mxs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 3064304..86a714b 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -230,7 +230,8 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
 	INIT_COMPLETION(spi->c);
 
 	ctrl0 = readl(ssp->base + HW_SSP_CTRL0);
-	ctrl0 &= ~BM_SSP_CTRL0_XFER_COUNT;
+	ctrl0 &= ~(BM_SSP_CTRL0_XFER_COUNT | BM_SSP_CTRL0_IGNORE_CRC |
+		 BM_SSP_CTRL0_READ);
 	ctrl0 |= BM_SSP_CTRL0_DATA_XFER | mxs_spi_cs_to_reg(cs);
 
 	if (!(flags & TXRX_WRITE))
-- 
1.7.10.4


------------------------------------------------------------------------------
Own the Future-Intel(R) Level Up Game Demo Contest 2013
Rise to greatness in Intel's independent game demo contest. Compete 
for recognition, cash, and the chance to get your game on Steam. 
$5K grand prize plus 10 genre and skill prizes. Submit your demo 
by 6/6/13. http://altfarm.mediaplex.com/ad/ck/12124-176961-30367-2
