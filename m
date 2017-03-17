From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 6/6] spi: loopback-test: add test spi_message with delay after transfers
Date: Sat, 18 Mar 2017 03:17:31 +0900
Message-ID: <1489774651-30170-7-git-send-email-akinobu.mita@gmail.com>
References: <1489774651-30170-1-git-send-email-akinobu.mita@gmail.com>
Cc: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489774651-30170-1-git-send-email-akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This adds a new test to check whether the spi_transfer.delay_usecs
setting has properly taken effect.

Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 66e8cfd0..fcae337 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -273,6 +273,25 @@ static struct spi_test spi_tests[] = {
 			},
 		},
 	},
+	{
+		.description	= "two tx+rx transfers - delay after transfer",
+		.fill_option	= FILL_COUNT_8,
+		.iterate_len    = { ITERATE_MAX_LEN },
+		.iterate_transfer_mask = BIT(0) | BIT(1),
+		.transfer_count = 2,
+		.transfers		= {
+			{
+				.tx_buf = TX(0),
+				.rx_buf = RX(0),
+				.delay_usecs = 1000,
+			},
+			{
+				.tx_buf = TX(0),
+				.rx_buf = RX(0),
+				.delay_usecs = 1000,
+			},
+		},
+	},
 
 	{ /* end of tests sequence */ }
 };
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
