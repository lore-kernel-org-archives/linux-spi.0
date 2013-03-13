From: Girish K S <girishks2000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V3 1/5] spi: s3c64xx: modified error interrupt handling and
	init
Date: Wed, 13 Mar 2013 12:13:30 +0530
Message-ID: <1363157014-9615-2-git-send-email-ks.giri@samsung.com>
References: <1363157014-9615-1-git-send-email-ks.giri@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
	Girish K S <girishks2000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1363157014-9615-1-git-send-email-ks.giri-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Girish K S <girishks2000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

The status of the interrupt is available in the status register,
so reading the clear pending register and writing back the same
value will not actually clear the pending interrupts. This patch
modifies the interrupt handler to read the status register and
clear the corresponding pending bit in the clear pending register.

Modified the hwInit function to clear all the pending interrupts.

Signed-off-by: Girish K S <ks.giri-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-s3c64xx.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index e862ab8..4188b2f 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -994,25 +994,30 @@ static irqreturn_t s3c64xx_spi_irq(int irq, void *data)
 {
 	struct s3c64xx_spi_driver_data *sdd = data;
 	struct spi_master *spi = sdd->master;
-	unsigned int val;
+	unsigned int val, clr = 0;
 
-	val = readl(sdd->regs + S3C64XX_SPI_PENDING_CLR);
+	val = readl(sdd->regs + S3C64XX_SPI_STATUS);
 
-	val &= S3C64XX_SPI_PND_RX_OVERRUN_CLR |
-		S3C64XX_SPI_PND_RX_UNDERRUN_CLR |
-		S3C64XX_SPI_PND_TX_OVERRUN_CLR |
-		S3C64XX_SPI_PND_TX_UNDERRUN_CLR;
-
-	writel(val, sdd->regs + S3C64XX_SPI_PENDING_CLR);
-
-	if (val & S3C64XX_SPI_PND_RX_OVERRUN_CLR)
+	if (val & S3C64XX_SPI_ST_RX_OVERRUN_ERR) {
+		clr = S3C64XX_SPI_PND_RX_OVERRUN_CLR;
 		dev_err(&spi->dev, "RX overrun\n");
-	if (val & S3C64XX_SPI_PND_RX_UNDERRUN_CLR)
+	}
+	if (val & S3C64XX_SPI_ST_RX_UNDERRUN_ERR) {
+		clr |= S3C64XX_SPI_PND_RX_UNDERRUN_CLR;
 		dev_err(&spi->dev, "RX underrun\n");
-	if (val & S3C64XX_SPI_PND_TX_OVERRUN_CLR)
+	}
+	if (val & S3C64XX_SPI_ST_TX_OVERRUN_ERR) {
+		clr |= S3C64XX_SPI_PND_TX_OVERRUN_CLR;
 		dev_err(&spi->dev, "TX overrun\n");
-	if (val & S3C64XX_SPI_PND_TX_UNDERRUN_CLR)
+	}
+	if (val & S3C64XX_SPI_ST_TX_UNDERRUN_ERR) {
+		clr |= S3C64XX_SPI_PND_TX_UNDERRUN_CLR;
 		dev_err(&spi->dev, "TX underrun\n");
+	}
+
+	/* Clear the pending irq by setting and then clearing it */
+	writel(clr, sdd->regs + S3C64XX_SPI_PENDING_CLR);
+	writel(0, sdd->regs + S3C64XX_SPI_PENDING_CLR);
 
 	return IRQ_HANDLED;
 }
@@ -1036,9 +1041,13 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd, int channel)
 	writel(0, regs + S3C64XX_SPI_MODE_CFG);
 	writel(0, regs + S3C64XX_SPI_PACKET_CNT);
 
-	/* Clear any irq pending bits */
-	writel(readl(regs + S3C64XX_SPI_PENDING_CLR),
-				regs + S3C64XX_SPI_PENDING_CLR);
+	/* Clear any irq pending bits, should set and clear the bits */
+	val = S3C64XX_SPI_PND_RX_OVERRUN_CLR |
+		S3C64XX_SPI_PND_RX_UNDERRUN_CLR |
+		S3C64XX_SPI_PND_TX_OVERRUN_CLR |
+		S3C64XX_SPI_PND_TX_UNDERRUN_CLR;
+	writel(val, regs + S3C64XX_SPI_PENDING_CLR);
+	writel(0, regs + S3C64XX_SPI_PENDING_CLR);
 
 	writel(0, regs + S3C64XX_SPI_SWAP_CFG);
 
-- 
1.8.0


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
