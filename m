From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH] spi: bugfix: spi_message.transfer_length does not get reset
Date: Fri, 27 Nov 2015 12:31:09 +0000
Message-ID: <1448627469-2240-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

When submitting an identical spi_message multiple times via spi_sync
the spi_message.frame_length does not get reset to 0 in __spi_validate
before adding up all spi_transfer.len resulting in
frame_length > actual_length on all but the first spi_sync call.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi.c |    1 +
 1 file changed, 1 insertion(+)

Found this by chance while finishing the spi_loopback_test driver,
which I am about to submit.

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 20ef469..2b0a8ec 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2131,6 +2131,7 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 	 * Set transfer tx_nbits and rx_nbits as single transfer default
 	 * (SPI_NBITS_SINGLE) if it is not set for this transfer.
 	 */
+	message->frame_length = 0;
 	list_for_each_entry(xfer, &message->transfers, transfer_list) {
 		message->frame_length += xfer->len;
 		if (!xfer->bits_per_word)
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
