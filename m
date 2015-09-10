From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 6/6] spi/bcm63xx: move message control word description to register offsets
Date: Thu, 10 Sep 2015 16:11:44 +0200
Message-ID: <1441894304-22316-7-git-send-email-jogo@openwrt.org>
References: <1441894304-22316-1-git-send-email-jogo@openwrt.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441894304-22316-1-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Make the message control word parameters part of the register offsets
array so we have them all in one struct.

Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
 drivers/spi/spi-bcm63xx.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 6353607..42f33bc 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -128,6 +128,9 @@ enum bcm63xx_regs_spi {
 	SPI_MSG_CTL,
 	SPI_MSG_DATA,
 	SPI_RX_DATA,
+	SPI_MSG_TYPE_SHIFT,
+	SPI_MSG_CTL_WIDTH,
+	SPI_MSG_DATA_SIZE,
 };
 
 #define BCM63XX_SPI_MAX_PREPEND		15
@@ -439,6 +442,9 @@ static const unsigned long bcm6348_spi_reg_offsets[] = {
 	[SPI_MSG_CTL]		= SPI_6348_MSG_CTL,
 	[SPI_MSG_DATA]		= SPI_6348_MSG_DATA,
 	[SPI_RX_DATA]		= SPI_6348_RX_DATA,
+	[SPI_MSG_TYPE_SHIFT]	= SPI_6348_MSG_TYPE_SHIFT,
+	[SPI_MSG_CTL_WIDTH]	= SPI_6348_MSG_CTL_WIDTH,
+	[SPI_MSG_DATA_SIZE]	= SPI_6348_MSG_DATA_SIZE,
 };
 
 static const unsigned long bcm6358_spi_reg_offsets[] = {
@@ -454,6 +460,9 @@ static const unsigned long bcm6358_spi_reg_offsets[] = {
 	[SPI_MSG_CTL]		= SPI_6358_MSG_CTL,
 	[SPI_MSG_DATA]		= SPI_6358_MSG_DATA,
 	[SPI_RX_DATA]		= SPI_6358_RX_DATA,
+	[SPI_MSG_TYPE_SHIFT]	= SPI_6358_MSG_TYPE_SHIFT,
+	[SPI_MSG_CTL_WIDTH]	= SPI_6358_MSG_CTL_WIDTH,
+	[SPI_MSG_DATA_SIZE]	= SPI_6358_MSG_DATA_SIZE,
 };
 
 static int bcm63xx_spi_probe(struct platform_device *pdev)
@@ -517,15 +526,9 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	switch (resource_size(r)) {
 	case SPI_6348_RSET_SIZE:
 		bs->reg_offsets = bcm6348_spi_reg_offsets;
-		bs->msg_type_shift = SPI_6348_MSG_TYPE_SHIFT;
-		bs->msg_ctl_width = SPI_6348_MSG_CTL_WIDTH;
-		bs->fifo_size = SPI_6348_MSG_DATA_SIZE;
 		break;
 	case SPI_6358_RSET_SIZE:
 		bs->reg_offsets = bcm6358_spi_reg_offsets;
-		bs->msg_type_shift = SPI_6358_MSG_TYPE_SHIFT;
-		bs->msg_ctl_width = SPI_6358_MSG_CTL_WIDTH;
-		bs->fifo_size = SPI_6358_MSG_DATA_SIZE;
 		break;
 	default:
 		ret = -EINVAL;
@@ -534,6 +537,10 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 		goto out_err;
 	}
 
+	bs->msg_type_shift = bs->reg_offsets[SPI_MSG_TYPE_SHIFT];
+	bs->msg_ctl_width = bs->reg_offsets[SPI_MSG_CTL_WIDTH];
+	bs->fifo_size = bs->reg_offsets[SPI_MSG_DATA_SIZE];
+
 	bs->tx_io = (u8 *)(bs->regs + bs->reg_offsets[SPI_MSG_DATA]);
 	bs->rx_io = (const u8 *)(bs->regs + bs->reg_offsets[SPI_RX_DATA]);
 
-- 
2.1.4
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
