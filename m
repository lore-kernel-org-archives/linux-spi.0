From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH v3 5/8] spi: loopback-test: spi_check_rx_ranges can get always done
Date: Tue, 22 Dec 2015 18:03:25 +0000
Message-ID: <1450807408-2422-6-git-send-email-kernel@martin.sperl.org>
References: <1450807408-2422-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450807408-2422-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

The spi_check_rx_ranges can always get executed independent of
if we have a real loopback situation.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 75cea07..c26ffa1 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -441,7 +441,18 @@ static int spi_test_check_loopback_result(struct spi_device *spi,
 	struct spi_transfer *xfer;
 	u8 rxb, txb;
 	size_t i;
+	int ret;
+
+	/* checks rx_buffer pattern are valid with loopback or without */
+	ret = spi_check_rx_ranges(spi, msg, rx);
+	if (ret)
+		return ret;
 
+	/* if we run without loopback, then return now */
+	if (!loopback)
+		return 0;
+
+	/* if applicable to transfer check that rx_buf is equal to tx_buf */
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		/* if there is no rx, then no check is needed */
 		if (!xfer->rx_buf)
@@ -473,7 +484,7 @@ static int spi_test_check_loopback_result(struct spi_device *spi,
 		}
 	}
 
-	return spi_check_rx_ranges(spi, msg, rx);
+	return 0;
 
 mismatch_error:
 	dev_err(&spi->dev,
@@ -806,10 +817,8 @@ int spi_test_execute_msg(struct spi_device *spi, struct spi_test *test,
 			goto exit;
 		}
 
-		/* run rx-tests when in loopback mode */
-		if (loopback)
-			ret = spi_test_check_loopback_result(spi, msg,
-							     tx, rx);
+		/* run rx-buffer tests */
+		ret = spi_test_check_loopback_result(spi, msg, tx, rx);
 	}
 
 	/* if requested or on error dump message (including data) */
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
