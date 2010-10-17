From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 13/28] Blackfin SPI: use the SPI
	namespaced bit names
Date: Sun, 17 Oct 2010 18:59:26 -0400
Message-ID: <1287356381-31495-14-git-send-email-vapier@gentoo.org>
References: <1287356381-31495-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1287356381-31495-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This lets us push the short SPI MMR bit names out of the global namespace.

Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index ffff099..07044d7 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -504,8 +504,8 @@ static irqreturn_t bfin_spi_dma_irq_handler(int irq, void *dev_id)
 	 * register until it goes low for 2 successive reads
 	 */
 	if (drv_data->tx != NULL) {
-		while ((read_STAT(drv_data) & TXS) ||
-		       (read_STAT(drv_data) & TXS))
+		while ((read_STAT(drv_data) & BIT_STAT_TXS) ||
+		       (read_STAT(drv_data) & BIT_STAT_TXS))
 			cpu_relax();
 	}
 
@@ -514,14 +514,14 @@ static irqreturn_t bfin_spi_dma_irq_handler(int irq, void *dev_id)
 		dmastat, read_STAT(drv_data));
 
 	timeout = jiffies + HZ;
-	while (!(read_STAT(drv_data) & SPIF))
+	while (!(read_STAT(drv_data) & BIT_STAT_SPIF))
 		if (!time_before(jiffies, timeout)) {
 			dev_warn(&drv_data->pdev->dev, "timeout waiting for SPIF");
 			break;
 		} else
 			cpu_relax();
 
-	if ((dmastat & DMA_ERR) && (spistat & RBSY)) {
+	if ((dmastat & DMA_ERR) && (spistat & BIT_STAT_RBSY)) {
 		msg->state = ERROR_STATE;
 		dev_err(&drv_data->pdev->dev, "dma receive: fifo/buffer overflow\n");
 	} else {
@@ -1000,11 +1000,12 @@ static int bfin_spi_setup(struct spi_device *spi)
 	if (chip_info) {
 		/* Make sure people stop trying to set fields via ctl_reg
 		 * when they should actually be using common SPI framework.
-		 * Currently we let through: WOM EMISO PSSE GM SZ TIMOD.
+		 * Currently we let through: WOM EMISO PSSE GM SZ.
 		 * Not sure if a user actually needs/uses any of these,
 		 * but let's assume (for now) they do.
 		 */
-		if (chip_info->ctl_reg & (SPE|MSTR|CPOL|CPHA|LSBF|SIZE)) {
+		if (chip_info->ctl_reg & ~(BIT_CTL_OPENDRAIN | BIT_CTL_EMISO | \
+		                           BIT_CTL_PSSE | BIT_CTL_GM | BIT_CTL_SZ)) {
 			dev_err(&spi->dev, "do not set bits in ctl_reg "
 				"that the SPI framework manages\n");
 			goto error;
@@ -1022,13 +1023,13 @@ static int bfin_spi_setup(struct spi_device *spi)
 
 	/* translate common spi framework into our register */
 	if (spi->mode & SPI_CPOL)
-		chip->ctl_reg |= CPOL;
+		chip->ctl_reg |= BIT_CTL_CPOL;
 	if (spi->mode & SPI_CPHA)
-		chip->ctl_reg |= CPHA;
+		chip->ctl_reg |= BIT_CTL_CPHA;
 	if (spi->mode & SPI_LSB_FIRST)
-		chip->ctl_reg |= LSBF;
+		chip->ctl_reg |= BIT_CTL_LSBF;
 	/* we dont support running in slave mode (yet?) */
-	chip->ctl_reg |= MSTR;
+	chip->ctl_reg |= BIT_CTL_MASTER;
 
 	/*
 	 * Notice: for blackfin, the speed_hz is the value of register
-- 
1.7.3.1
