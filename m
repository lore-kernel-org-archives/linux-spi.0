From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: loopback-test: add test spi_message with delay after transfers" to the spi tree
Date: Fri, 17 Mar 2017 21:54:47 +0000
Message-ID: <E1cozpg-00024t-04@debutante>
References: <1489774651-30170-7-git-send-email-akinobu.mita@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489774651-30170-7-git-send-email-akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: loopback-test: add test spi_message with delay after transfers

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 8687113e1515f4c9104a6eaedc384ec762c6550f Mon Sep 17 00:00:00 2001
From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sat, 18 Mar 2017 03:17:31 +0900
Subject: [PATCH] spi: loopback-test: add test spi_message with delay after
 transfers

This adds a new test to check whether the spi_transfer.delay_usecs
setting has properly taken effect.

Signed-off-by: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 66e8cfd04395..fcae3377ec26 100644
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
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
