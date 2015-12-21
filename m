From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH v2 3/8] spi: loopback-test: rename method spi_test_fill_tx to spi_test_fill_pattern
Date: Mon, 21 Dec 2015 11:52:45 +0000
Message-ID: <1450698772-2379-3-git-send-email-kernel@martin.sperl.org>
References: <1450698772-2379-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450698772-2379-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Rename method spi_test_fill_tx to spi_test_fill_pattern
to better describe what it does.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 8af2e40..81fa906 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -574,7 +574,8 @@ static int spi_test_translate(struct spi_device *spi,
 	return -EINVAL;
 }
 
-static int spi_test_fill_tx(struct spi_device *spi, struct spi_test *test)
+static int spi_test_fill_pattern(struct spi_device *spi,
+				 struct spi_test *test)
 {
 	struct spi_transfer *xfers = test->transfers;
 	u8 *tx_buf;
@@ -691,8 +692,8 @@ static int _spi_test_run_iter(struct spi_device *spi,
 		spi_message_add_tail(x, msg);
 	}
 
-	/* fill in the transfer data */
-	ret = spi_test_fill_tx(spi, test);
+	/* fill in the transfer buffers with pattern */
+	ret = spi_test_fill_pattern(spi, test);
 	if (ret)
 		return ret;
 
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
