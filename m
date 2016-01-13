From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: [PATCH] spi: fix counting in spi-loopback-test code
Date: Wed, 13 Jan 2016 21:51:29 +0100
Message-ID: <7416604.jejCLcpcOT@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

These variables are always used uninitialized:

drivers/spi/spi-loopback-test.c: In function 'spi_test_run_iter':
drivers/spi/spi-loopback-test.c:768:17: warning: 'rx_count' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/spi/spi-loopback-test.c:762:17: warning: 'tx_count' may be used uninitialized in this function [-Wmaybe-uninitialized]

Adding an explicit initialization seems to be the only
workable solution here, to make the code behave correctly
and build without warning.

Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Fixes: 84e0c4e5e2c4 ("spi: add loopback test driver to allow for spi_master regression tests")
---
The warning is hidden in allmodconfig at the moment because we build
that with -Os rather than -O2, which shows it.

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 894616f687b0..cf4bb36bee25 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -761,6 +761,7 @@ static int spi_test_run_iter(struct spi_device *spi,
 		test.iterate_transfer_mask = 1;
 
 	/* count number of transfers with tx/rx_buf != NULL */
+	rx_count = tx_count = 0;
 	for (i = 0; i < test.transfer_count; i++) {
 		if (test.transfers[i].tx_buf)
 			tx_count++;

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
