From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: xilinx: Detect stall with Unknown commands" to the spi tree
Date: Fri, 24 Nov 2017 13:04:11 +0000 (GMT)
Message-ID: <20171124130411.B88ED44005B@finisterre.ee.mobilebroadband>
References: <20171121090904.6901-1-ricardo.ribalda@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ricardo Ribalda <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171121090904.6901-1-ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: xilinx: Detect stall with Unknown commands

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From fe56ebb8b93de2593f9e200d4ea3b2714287490b Mon Sep 17 00:00:00 2001
From: Ricardo Ribalda <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Tue, 21 Nov 2017 10:09:02 +0100
Subject: [PATCH] spi: xilinx: Detect stall with Unknown commands

When the core is configured in C_SPI_MODE > 0, it integrates a
lookup table that automatically configures the core in dual or quad mode
based on the command (first byte on the tx fifo).

Unfortunately, that list mode_?_memoy_*.mif does not contain all the
supported commands by the flash.

Since 4.14 spi-nor automatically tries to probe the flash using SFDP
(command 0x5a), and that command is not part of the list_mode table.

Whit the right combination of C_SPI_MODE and C_SPI_MEMORY this leads
into a stall that can only be recovered with a soft rest.

This patch detects this kind of stall and returns -EIO to the caller on
those commands. spi-nor can handle this error properly:

m25p80 spi0.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY. 0x21 0x2404
m25p80 spi0.0: SPI transfer failed: -5
spi_master spi0: failed to transfer one message from queue
m25p80 spi0.0: s25sl064p (8192 Kbytes)

Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-xilinx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index bc7100b93dfc..e0b9fe1d0e37 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -271,6 +271,7 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 	while (remaining_words) {
 		int n_words, tx_words, rx_words;
 		u32 sr;
+		int stalled;
 
 		n_words = min(remaining_words, xspi->buffer_size);
 
@@ -299,7 +300,17 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 
 		/* Read out all the data from the Rx FIFO */
 		rx_words = n_words;
+		stalled = 10;
 		while (rx_words) {
+			if (rx_words == n_words && !(stalled--) &&
+			    !(sr & XSPI_SR_TX_EMPTY_MASK) &&
+			    (sr & XSPI_SR_RX_EMPTY_MASK)) {
+				dev_err(&spi->dev,
+					"Detected stall. Check C_SPI_MODE and C_SPI_MEMORY\n");
+				xspi_init_hw(xspi);
+				return -EIO;
+			}
+
 			if ((sr & XSPI_SR_TX_EMPTY_MASK) && (rx_words > 1)) {
 				xilinx_spi_rx(xspi);
 				rx_words--;
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
