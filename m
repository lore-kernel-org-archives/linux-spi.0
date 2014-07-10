From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH 2/2] spi: cadence: Configure SPI clock in the prepare_message() callback
Date: Thu, 10 Jul 2014 11:26:29 +0200
Message-ID: <1404984389-12802-2-git-send-email-lars@metafoo.de>
References: <1404984389-12802-1-git-send-email-lars@metafoo.de>
Cc: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1404984389-12802-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Currently the cadence SPI driver does the SPI clock configuration (setup CPOL
and CPHA) in the prepare_transfer_hardware() callback. The
prepare_transfer_hardware() callback is only called though when the controller
transitions from a idle state to a non-idle state. Such a transitions happens
when the message queue goes from empty to non-empty. If multiple messages from
different SPI slaves with different clock settings are in the message queue the
clock settings will not be properly updated when switching from one slave device
to another. Instead do the updating of the clock configuration in the
prepare_message() callback which will be called for each individual message.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 drivers/spi/spi-cadence.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 03f4d5e..562ff83 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -382,6 +382,12 @@ static irqreturn_t cdns_spi_irq(int irq, void *dev_id)
 
 	return status;
 }
+static int cdns_prepare_message(struct spi_master *master,
+				struct spi_message *msg)
+{
+	cdns_spi_config_clock_mode(msg->spi);
+	return 0;
+}
 
 /**
  * cdns_transfer_one - Initiates the SPI transfer
@@ -428,8 +434,6 @@ static int cdns_prepare_transfer_hardware(struct spi_master *master)
 {
 	struct cdns_spi *xspi = spi_master_get_devdata(master);
 
-	cdns_spi_config_clock_mode(master->cur_msg->spi);
-
 	cdns_spi_write(xspi, CDNS_SPI_ER_OFFSET,
 		       CDNS_SPI_ER_ENABLE_MASK);
 
@@ -544,6 +548,7 @@ static int cdns_spi_probe(struct platform_device *pdev)
 		xspi->is_decoded_cs = 0;
 
 	master->prepare_transfer_hardware = cdns_prepare_transfer_hardware;
+	master->prepare_message = cdns_prepare_message;
 	master->transfer_one = cdns_transfer_one;
 	master->unprepare_transfer_hardware = cdns_unprepare_transfer_hardware;
 	master->set_cs = cdns_spi_chipselect;
-- 
1.8.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
