From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: bugfix: spi_message.transfer_length does not get reset" to the spi tree
Date: Fri, 27 Nov 2015 12:55:56 +0000
Message-ID: <E1a2IZA-0005xm-LX@debutante>
References: <1448627469-2240-1-git-send-email-kernel@martin.sperl.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448627469-2240-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: bugfix: spi_message.transfer_length does not get reset

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

>From 77e8058810303e5c18b462adb4f761dbb4f3b657 Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Date: Fri, 27 Nov 2015 12:31:09 +0000
Subject: [PATCH] spi: bugfix: spi_message.transfer_length does not get reset

When submitting an identical spi_message multiple times via spi_sync
the spi_message.frame_length does not get reset to 0 in __spi_validate
before adding up all spi_transfer.len resulting in
frame_length > actual_length on all but the first spi_sync call.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e2415be209d5..a0e346f3b71e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2130,6 +2130,7 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 	 * Set transfer tx_nbits and rx_nbits as single transfer default
 	 * (SPI_NBITS_SINGLE) if it is not set for this transfer.
 	 */
+	message->frame_length = 0;
 	list_for_each_entry(xfer, &message->transfers, transfer_list) {
 		message->frame_length += xfer->len;
 		if (!xfer->bits_per_word)
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
