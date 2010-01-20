From: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
Subject: PATCH [1/1] SPI: AMBA_PL022: Limit TX FIFO
 fills based on current RX FIFO used
Date: Wed, 20 Jan 2010 19:38:00 +0100
Message-ID: <083DF309106F364B939360100EC290F805C4BF1E97@eu1rdcrdc1wx030.exi.nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Added logic to cap TX FIFO fill size based on current free RX
FIFO entries instead of TX status flags. This is to prevent
an issue with RX FIFO overflows 

Signed-off-by: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
---
 drivers/spi/amba-pl022.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index ff5bbb9..9aeb681 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -363,6 +363,7 @@ struct pl022 {
 	void				*rx_end;
 	enum ssp_reading		read;
 	enum ssp_writing		write;
+	u32				exp_fifo_level;
 };
 
 /**
@@ -501,6 +502,9 @@ static int flush(struct pl022 *pl022)
 		while (readw(SSP_SR(pl022->virtbase)) & SSP_SR_MASK_RNE)
 			readw(SSP_DR(pl022->virtbase));
 	} while ((readw(SSP_SR(pl022->virtbase)) & SSP_SR_MASK_BSY) && limit--);
+
+	pl022->exp_fifo_level = 0;
+
 	return limit;
 }
 
@@ -583,10 +587,9 @@ static void readwriter(struct pl022 *pl022)
 	 * errons in 8bit wide transfers on ARM variants (just 8 words
 	 * FIFO, means only 8x8 = 64 bits in FIFO) at least.
 	 *
-	 * FIXME: currently we have no logic to account for this.
-	 * perhaps there is even something broken in HW regarding
-	 * 8bit transfers (it doesn't fail on 16bit) so this needs
-	 * more investigation...
+	 * To prevent this issue, the TX FIFO is only filled to the
+	 * unused RX FIFO fill length, regardless of what the TX
+	 * FIFO status flag indicates.
 	 */
 	dev_dbg(&pl022->adev->dev,
 		"%s, rx: %p, rxend: %p, tx: %p, txend: %p\n",
@@ -613,11 +616,12 @@ static void readwriter(struct pl022 *pl022)
 			break;
 		}
 		pl022->rx += (pl022->cur_chip->n_bytes);
+		pl022->exp_fifo_level--;
 	}
 	/*
-	 * Write as much as you can, while keeping an eye on the RX FIFO!
+	 * Write as much as possible up to the RX FIFO size
 	 */
-	while ((readw(SSP_SR(pl022->virtbase)) & SSP_SR_MASK_TNF)
+	while ((pl022->exp_fifo_level < pl022->vendor->fifodepth)
 	       && (pl022->tx < pl022->tx_end)) {
 		switch (pl022->write) {
 		case WRITING_NULL:
@@ -634,6 +638,7 @@ static void readwriter(struct pl022 *pl022)
 			break;
 		}
 		pl022->tx += (pl022->cur_chip->n_bytes);
+		pl022->exp_fifo_level++;
 		/*
 		 * This inner reader takes care of things appearing in the RX
 		 * FIFO as we're transmitting. This will happen a lot since the
@@ -660,6 +665,7 @@ static void readwriter(struct pl022 *pl022)
 				break;
 			}
 			pl022->rx += (pl022->cur_chip->n_bytes);
+			pl022->exp_fifo_level--;
 		}
 	}
 	/*
-- 
1.5.6.5


------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
