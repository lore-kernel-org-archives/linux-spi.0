From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi: Use bitfields for multiple data lines
Date: Fri, 10 Jan 2014 17:19:03 +0000
Message-ID: <1389374343-393-1-git-send-email-broonie@kernel.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org,
	Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Trent Piepho observed that since the current realistic maximum number of
data lines is four we can pack the spi_transfer struct more efficiently
if we use a bitfield for the number of bits, allowing the fields to fit
in a single byte along with cs_change.

If space becomes an issue further optimiation is possible by only using
the constants and packing the values chosen for them.

Reported-by: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 include/linux/spi/spi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 27a882978c15..77b529e418d5 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -576,8 +576,8 @@ struct spi_transfer {
 	dma_addr_t	rx_dma;
 
 	unsigned	cs_change:1;
-	u8		tx_nbits;
-	u8		rx_nbits;
+	unsigned	tx_nbits:3;
+	unsigned	rx_nbits:3;
 #define	SPI_NBITS_SINGLE	0x01 /* 1bit transfer */
 #define	SPI_NBITS_DUAL		0x02 /* 2bits transfer */
 #define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
-- 
1.8.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
