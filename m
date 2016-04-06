From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: cadence: Fix some checkpatch warnings" to the spi tree
Date: Wed, 06 Apr 2016 14:39:04 -0700
Message-ID: <E1anvAG-00084M-F2@finisterre>
References: <1459934735-40434-1-git-send-email-shubhraj@xilinx.com>
Cc: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459934735-40434-1-git-send-email-shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: cadence: Fix some checkpatch warnings

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 57bb1369de36a72e2e13fde9c88663342f729ace Mon Sep 17 00:00:00 2001
From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Date: Wed, 6 Apr 2016 14:55:35 +0530
Subject: [PATCH] spi: cadence: Fix some checkpatch warnings

No functional change.
Fixing some style related issues

CHECK: multiple assignments should be avoided
+	new_ctrl_reg = ctrl_reg = cdns_spi_read(xspi, CDNS_SPI_CR);

CHECK: Alignment should match open parenthesis
+static void cdns_spi_config_clock_freq(struct spi_device *spi,
+				  struct spi_transfer *transfer)

CHECK: Please use a blank line after function/struct/union/enum declarations
+}
+static int cdns_prepare_message(struct spi_master *master,

Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-cadence.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 07481e12d8a3..8a0bd62a5088 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -209,7 +209,8 @@ static void cdns_spi_config_clock_mode(struct spi_device *spi)
 	struct cdns_spi *xspi = spi_master_get_devdata(spi->master);
 	u32 ctrl_reg, new_ctrl_reg;
 
-	new_ctrl_reg = ctrl_reg = cdns_spi_read(xspi, CDNS_SPI_CR);
+	new_ctrl_reg = cdns_spi_read(xspi, CDNS_SPI_CR);
+	ctrl_reg = new_ctrl_reg;
 
 	/* Set the SPI clock phase and clock polarity */
 	new_ctrl_reg &= ~(CDNS_SPI_CR_CPHA | CDNS_SPI_CR_CPOL);
@@ -246,7 +247,7 @@ static void cdns_spi_config_clock_mode(struct spi_device *spi)
  * controller.
  */
 static void cdns_spi_config_clock_freq(struct spi_device *spi,
-				  struct spi_transfer *transfer)
+				       struct spi_transfer *transfer)
 {
 	struct cdns_spi *xspi = spi_master_get_devdata(spi->master);
 	u32 ctrl_reg, baud_rate_val;
@@ -380,6 +381,7 @@ static irqreturn_t cdns_spi_irq(int irq, void *dev_id)
 
 	return status;
 }
+
 static int cdns_prepare_message(struct spi_master *master,
 				struct spi_message *msg)
 {
-- 
2.8.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
