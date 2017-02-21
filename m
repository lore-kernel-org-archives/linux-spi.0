From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi/bcm63xx: make spi subsystem aware of message size limits" to the spi tree
Date: Tue, 21 Feb 2017 09:52:06 -0800
Message-ID: <E1cgEbe-0002Jp-RH@finisterre>
References: <20170220105009.7944-1-jonas.gorski@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170220105009.7944-1-jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi/bcm63xx: make spi subsystem aware of message size limits

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

>From 0135c03df914f0481c61f097c78d37cece84f330 Mon Sep 17 00:00:00 2001
From: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Mon, 20 Feb 2017 11:50:09 +0100
Subject: [PATCH] spi/bcm63xx: make spi subsystem aware of message size limits

The bcm63xx SPI controller does not allow manual control of the CS
lines and will toggle it automatically before and after sending data,
so we are limited to messages that fit in the FIFO buffer. Since the CS
lines aren't available as GPIOs either, we will need to make slave
drivers aware of this limitation so they can handle them accordingly.

Signed-off-by: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-bcm63xx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index fee747030ee6..caa733ec405c 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -428,6 +428,13 @@ static irqreturn_t bcm63xx_spi_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static size_t bcm63xx_spi_max_length(struct spi_device *dev)
+{
+	struct bcm63xx_spi *bs = spi_master_get_devdata(spi->master);
+
+	return bs->fifo_size;
+}
+
 static const unsigned long bcm6348_spi_reg_offsets[] = {
 	[SPI_CMD]		= SPI_6348_CMD,
 	[SPI_INT_STATUS]	= SPI_6348_INT_STATUS,
@@ -541,6 +548,8 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	master->transfer_one_message = bcm63xx_spi_transfer_one;
 	master->mode_bits = MODEBITS;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
+	master->max_transfer_size = bcm63xx_spi_max_length;
+	master->max_message_size = bcm63xx_spi_max_length;
 	master->auto_runtime_pm = true;
 	bs->msg_type_shift = bs->reg_offsets[SPI_MSG_TYPE_SHIFT];
 	bs->msg_ctl_width = bs->reg_offsets[SPI_MSG_CTL_WIDTH];
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
