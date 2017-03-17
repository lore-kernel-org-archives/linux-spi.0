From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: loopback-test: correct mismatched test description and configuration" to the spi tree
Date: Fri, 17 Mar 2017 21:55:02 +0000
Message-ID: <E1cozpu-00029Q-RH@debutante>
References: <1489774651-30170-2-git-send-email-akinobu.mita@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489774651-30170-2-git-send-email-akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: loopback-test: correct mismatched test description and configuration

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

>From c4e121aeb754f1ac5f2bcc791aa4177dcfb3b401 Mon Sep 17 00:00:00 2001
From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sat, 18 Mar 2017 03:17:26 +0900
Subject: [PATCH] spi: loopback-test: correct mismatched test description and
 configuration

The test "two tx-transfers - alter first" actually alters the second
not the first transfer.  Similarly the test "two tx-transfers - alter
second" actually alters the first not the second transfer.

The mismatches for the two symmetrical tests cancel each other's
mistakes.  But it's better to fix the mismatches to avoid confusion.

Signed-off-by: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 50e620f4e8fe..99422f3a15e0 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -132,7 +132,7 @@ static struct spi_test spi_tests[] = {
 		.fill_option	= FILL_COUNT_8,
 		.iterate_len    = { ITERATE_MAX_LEN },
 		.iterate_tx_align = ITERATE_ALIGN,
-		.iterate_transfer_mask = BIT(1),
+		.iterate_transfer_mask = BIT(0),
 		.transfers		= {
 			{
 				.len = 1,
@@ -149,7 +149,7 @@ static struct spi_test spi_tests[] = {
 		.fill_option	= FILL_COUNT_8,
 		.iterate_len    = { ITERATE_MAX_LEN },
 		.iterate_tx_align = ITERATE_ALIGN,
-		.iterate_transfer_mask = BIT(0),
+		.iterate_transfer_mask = BIT(1),
 		.transfers		= {
 			{
 				.len = 16,
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
