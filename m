From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: loopback-test: test zero-length transfer" to the spi tree
Date: Fri, 17 Mar 2017 21:54:53 +0000
Message-ID: <E1cozpl-00026a-Re@debutante>
References: <1489774651-30170-5-git-send-email-akinobu.mita@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489774651-30170-5-git-send-email-akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: loopback-test: test zero-length transfer

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

>From 0bd7fda56b94002d9985040c02bb701956fa657e Mon Sep 17 00:00:00 2001
From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sat, 18 Mar 2017 03:17:29 +0900
Subject: [PATCH] spi: loopback-test: test zero-length transfer

In order to test various spi_messages including zero-length transfer,
this adds zero length into the iterate_len list.

Signed-off-by: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-test.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-test.h b/drivers/spi/spi-test.h
index 2dd569138880..82fff4a0fd94 100644
--- a/drivers/spi/spi-test.h
+++ b/drivers/spi/spi-test.h
@@ -124,7 +124,7 @@ int spi_test_execute_msg(struct spi_device *spi,
 int spi_test_run_tests(struct spi_device *spi,
 		       struct spi_test *tests);
 
-#define ITERATE_LEN_LIST 1, 2, 3, 7, 11, 16, 31, 32, 64, 97, 128, 251, 256, \
+#define ITERATE_LEN_LIST 0, 1, 2, 3, 7, 11, 16, 31, 32, 64, 97, 128, 251, 256, \
 		1021, 1024, 1031, 4093, PAGE_SIZE, 4099, 65536, 65537
 /* some of the default @spi_transfer.len to test, terminated by a -1 */
 #define ITERATE_LEN ITERATE_LEN_LIST, -1
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
