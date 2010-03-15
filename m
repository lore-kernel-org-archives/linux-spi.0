From: Roman Tereshonkov <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] omap2_mcspi: small fixes of output
	data format
Date: Mon, 15 Mar 2010 11:06:29 +0200
Message-ID: <1268643989-29688-2-git-send-email-roman.tereshonkov@nokia.com>
References: <1268643989-29688-1-git-send-email-roman.tereshonkov@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Roman Tereshonkov <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>,
	scott-oZqG5KApg2M/jFmSBShxMA@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1268643989-29688-1-git-send-email-roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Replaces %04x by %08x for 32-bits data output.

Signed-off-by: Roman Tereshonkov <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/omap2_mcspi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index 3b50d07..a9d58ce 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -532,7 +532,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 					goto out;
 				}
 #ifdef VERBOSE
-				dev_dbg(&spi->dev, "write-%d %04x\n",
+				dev_dbg(&spi->dev, "write-%d %08x\n",
 						word_len, *tx);
 #endif
 				__raw_writel(*tx++, tx_reg);
@@ -550,7 +550,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 					mcspi_write_chconf0(spi, l);
 				*rx++ = __raw_readl(rx_reg);
 #ifdef VERBOSE
-				dev_dbg(&spi->dev, "read-%d %04x\n",
+				dev_dbg(&spi->dev, "read-%d %08x\n",
 						word_len, *(rx - 1));
 #endif
 			}
-- 
1.6.2.rc1.3.g81d3f


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
