From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH v2 1/4] spi: spidev: Restore all SPI mode flags on ioctl failure
Date: Tue, 25 Feb 2014 11:40:16 +0100
Message-ID: <1393324819-3810-1-git-send-email-geert@linux-m68k.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

In commit f477b7fb13df2b843997559ff34e87d054ba6538 ("spi: DUAL and QUAD
support"), spi_device.mode was enlarged from 8 to 16 bits.

However, the spidev code still only saved 8 bits of data. If a spidev
SPI_IOC_WR_MODE or SPI_IOC_WR_LSB_FIRST request failed, only the lower 8
bits of the SPI mode were restored, inadvertently clearing the upper 8
bits, possibly disabling Quad or Dual SPI transfers for the device.

Save up to 32 bits to fix this.

For SPI_IOC_WR_MODE this is probably not so important, as it doesn't allow
setting Quad or Dual mode anyway, but SPI_IOC_WR_LSB_FIRST is used to just
set or clear a single bit.

Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
v2:
  - Split off from "spi: spidev: Add support for Dual/Quad SPI Transfers",
    as this is a bug fix.
    Mark, do you think this is worthwhile for stable (v3.12 and v3.13)?

 drivers/spi/spidev.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index d7c6e36021e8..2abc0f5a82be 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -374,7 +374,7 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case SPI_IOC_WR_MODE:
 		retval = __get_user(tmp, (u8 __user *)arg);
 		if (retval == 0) {
-			u8	save = spi->mode;
+			u32	save = spi->mode;
 
 			if (tmp & ~SPI_MODE_MASK) {
 				retval = -EINVAL;
@@ -393,7 +393,7 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case SPI_IOC_WR_LSB_FIRST:
 		retval = __get_user(tmp, (__u8 __user *)arg);
 		if (retval == 0) {
-			u8	save = spi->mode;
+			u32	save = spi->mode;
 
 			if (tmp)
 				spi->mode |= SPI_LSB_FIRST;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
