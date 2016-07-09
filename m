From: Prahlad V <prahlad.eee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: spi-ti-qspi: clear wlen field while setting word length.
Date: Sun, 10 Jul 2016 01:35:53 +0530
Message-ID: <1468094753-8327-1-git-send-email-prahlad.eee@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	vigneshr-l0cyMroinI0@public.gmane.org, Prahlad V <prahlad.eee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

When a word length of 1 byte is selected and writing data of length
more than QSPI_WLEN_MAX_BYTES, first MAX_BYTES will be transfered
and remaining will be transfered byte by byte. In that case wlen
field should be cleared before setting.

Signed-off-by: Prahlad V <prahlad.eee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-ti-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 29ea8d2..6c61f54 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -276,9 +276,9 @@ static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t,
 				cmd |= QSPI_WLEN(QSPI_WLEN_MAX_BITS);
 			} else {
 				writeb(*txbuf, qspi->base + QSPI_SPI_DATA_REG);
-				cmd = qspi->cmd | QSPI_WR_SNGL;
 				xfer_len = wlen;
-				cmd |= QSPI_WLEN(wlen);
+				cmd = ((qspi->cmd & ~QSPI_WLEN_MASK) |
+					     QSPI_WLEN(wlen));
 			}
 			break;
 		case 2:
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
