From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH v2 2/8] spi: loopback-test: write rx pattern also when running without tx_buf
Date: Mon, 21 Dec 2015 11:52:44 +0000
Message-ID: <1450698772-2379-2-git-send-email-kernel@martin.sperl.org>
References: <1450698772-2379-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450698772-2379-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Currently the rx_buf does not get set with the
SPI_TEST_PATTERN_UNWRITTEN when tx_buf == NULL in the transfer.

Reorder code so that it gets done also under this specific condition.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 7f497ac..8af2e40 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -591,6 +591,10 @@ static int spi_test_fill_tx(struct spi_device *spi, struct spi_test *test)
 
 	/* fill all transfers with the pattern requested */
 	for (i = 0; i < test->transfer_count; i++) {
+		/* fill rx_buf with SPI_TEST_PATTERN_UNWRITTEN */
+		if (xfers[i].rx_buf)
+			memset(xfers[i].rx_buf, SPI_TEST_PATTERN_UNWRITTEN,
+			       xfers[i].len);
 		/* if tx_buf is NULL then skip */
 		tx_buf = (u8 *)xfers[i].tx_buf;
 		if (!tx_buf)
@@ -648,10 +652,6 @@ static int spi_test_fill_tx(struct spi_device *spi, struct spi_test *test)
 				return -EINVAL;
 			}
 		}
-		/* fill rx_buf with SPI_TEST_PATTERN_UNWRITTEN */
-		if (xfers[i].rx_buf)
-			memset(xfers[i].rx_buf, SPI_TEST_PATTERN_UNWRITTEN,
-			       xfers[i].len);
 	}
 
 	return 0;
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
