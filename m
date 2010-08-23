From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH] spi/spi_s3c64xx: Warn if PIO transfers
	time out
Date: Mon, 23 Aug 2010 17:40:56 +0100
Message-ID: <1282581656-26137-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
To: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
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

When using PIO we have a timeout for the TX and RX FIFOs to ensure that
the data actually gets transferred. Warn if we hit that timeout - it
should never happen, but this makes sure we'll find out if it does.

Signed-off-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 drivers/spi/spi_s3c64xx.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
index 7e627f7..f72e1c0 100644
--- a/drivers/spi/spi_s3c64xx.c
+++ b/drivers/spi/spi_s3c64xx.c
@@ -200,6 +200,9 @@ static void flush_fifo(struct s3c64xx_spi_driver_data *sdd)
 		val = readl(regs + S3C64XX_SPI_STATUS);
 	} while (TX_FIFO_LVL(val, sci) && loops--);
 
+	if (loops == 0)
+		dev_warn(&sdd->pdev->dev, "Timed out flushing TX FIFO\n");
+
 	/* Flush RxFIFO*/
 	loops = msecs_to_loops(1);
 	do {
@@ -210,6 +213,9 @@ static void flush_fifo(struct s3c64xx_spi_driver_data *sdd)
 			break;
 	} while (loops--);
 
+	if (loops == 0)
+		dev_warn(&sdd->pdev->dev, "Timed out flushing RX FIFO\n");
+
 	val = readl(regs + S3C64XX_SPI_CH_CFG);
 	val &= ~S3C64XX_SPI_CH_SW_RST;
 	writel(val, regs + S3C64XX_SPI_CH_CFG);
-- 
1.7.1


------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
