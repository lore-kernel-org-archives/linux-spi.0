From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/6] spi: loopback-test: correct mismatched test description and configuration
Date: Sat, 18 Mar 2017 03:17:26 +0900
Message-ID: <1489774651-30170-2-git-send-email-akinobu.mita@gmail.com>
References: <1489774651-30170-1-git-send-email-akinobu.mita@gmail.com>
Cc: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489774651-30170-1-git-send-email-akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The test "two tx-transfers - alter first" actually alters the second
not the first transfer.  Similarly the test "two tx-transfers - alter
second" actually alters the first not the second transfer.

The mismatches for the two symmetrical tests cancel each other's
mistakes.  But it's better to fix the mismatches to avoid confusion.

Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 50e620f..99422f3 100644
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
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
