From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH] spi: bcm2835: set up spi-mode before asserting cs-gpio
Date: Tue, 28 Jul 2015 14:03:12 +0000
Message-ID: <1438092193-31799-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	=?UTF-8?q?TeNoralf=20Tr=C3=B8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

When using reverse polarity for clock (spi-cpol) on a device
the clock line gets altered after chip-select has been asserted
resulting in an additional clock beat, which confuses hardware.

This did not show when using native-CS, as the same register
is used to control cs as well as polarity, so the changes came
into effect at the same time. Unfortunately this is not true
with gpio-cs.

To avoid this situation this patch moves the setup of polarity
(spi-cpol and spi-cpha) outside of the chip-select into
prepare_message, which is run prior to asserting chip-select.

Also fixes resetting 3-wire mode after use of rx-mode, so that
a 3-Wire sequence TX, RX, TX works as well (right now it runs
TX, RX, RX instead)

Reported-by: Noralf Tronnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c |   28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

See also the images for the effect that this patch has on the signals:
https://github.com/raspberrypi/linux/pull/1077#issuecomment-125484500

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 59705ab..c9357bb 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -553,13 +553,11 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 	spi_used_hz = cdiv ? (clk_hz / cdiv) : (clk_hz / 65536);
 	bcm2835_wr(bs, BCM2835_SPI_CLK, cdiv);
 
-	/* handle all the modes */
+	/* handle all the 3-wire mode */
 	if ((spi->mode & SPI_3WIRE) && (tfr->rx_buf))
 		cs |= BCM2835_SPI_CS_REN;
-	if (spi->mode & SPI_CPOL)
-		cs |= BCM2835_SPI_CS_CPOL;
-	if (spi->mode & SPI_CPHA)
-		cs |= BCM2835_SPI_CS_CPHA;
+	else
+		cs &= ~BCM2835_SPI_CS_REN;
 
 	/* for gpio_cs set dummy CS so that no HW-CS get changed
 	 * we can not run this in bcm2835_spi_set_cs, as it does
@@ -592,6 +590,25 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 	return bcm2835_spi_transfer_one_irq(master, spi, tfr, cs);
 }
 
+static int bcm2835_spi_prepare_message(struct spi_master *master,
+				       struct spi_message *msg)
+{
+	struct spi_device *spi = msg->spi;
+	struct bcm2835_spi *bs = spi_master_get_devdata(master);
+	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
+
+	cs &= ~(BCM2835_SPI_CS_CPOL | BCM2835_SPI_CS_CPHA);
+
+	if (spi->mode & SPI_CPOL)
+		cs |= BCM2835_SPI_CS_CPOL;
+	if (spi->mode & SPI_CPHA)
+		cs |= BCM2835_SPI_CS_CPHA;
+
+	bcm2835_wr(bs, BCM2835_SPI_CS, cs);
+
+	return 0;
+}
+
 static void bcm2835_spi_handle_err(struct spi_master *master,
 				   struct spi_message *msg)
 {
@@ -739,6 +756,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	master->set_cs = bcm2835_spi_set_cs;
 	master->transfer_one = bcm2835_spi_transfer_one;
 	master->handle_err = bcm2835_spi_handle_err;
+	master->prepare_message = bcm2835_spi_prepare_message;
 	master->dev.of_node = pdev->dev.of_node;
 
 	bs = spi_master_get_devdata(master);
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
