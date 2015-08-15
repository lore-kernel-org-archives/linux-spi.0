From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: bcm2835: set up spi-mode before asserting cs-gpio" to the spi tree
Date: Sat, 15 Aug 2015 09:22:54 -0700
Message-ID: <E1ZQeEQ-0007bk-4u@finisterre>
References: <1438092193-31799-1-git-send-email-kernel@martin.sperl.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Noralf Tronnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438092193-31799-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: bcm2835: set up spi-mode before asserting cs-gpio

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

>From ca861dd0c5e36c4a2cf454049a45a961c855290a Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Date: Tue, 28 Jul 2015 14:03:12 +0000
Subject: [PATCH] spi: bcm2835: set up spi-mode before asserting cs-gpio

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
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

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
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
