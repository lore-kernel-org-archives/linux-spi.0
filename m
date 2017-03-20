From: Colin King <colin.king@canonical.com>
Subject: [PATCH] spi: loopback-test: fix potential integer overflow on multiple
Date: Mon, 20 Mar 2017 13:58:05 +0000
Message-ID: <20170320135805.10182-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

A multiplication of 8U * xfer-len with the type of a 32 bit unsigned int
is evaluated using 32 bit arithmetic and then used in a context that
expects an expression of type unsigned long long (64 bits).  Avoid any
potential overflow by casting BITS_PER_BYTE to unsigned long long.

Detected by CoverityScan, CID#1419691 ("Unintentional integer overflow")

Fixes: ea9936f324356 ("spi: loopback-test: add elapsed time check")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/spi/spi-loopback-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 0d0739142cd3..51c0ceab04cc 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -521,7 +521,8 @@ static int spi_test_check_elapsed_time(struct spi_device *spi,
 
 	for (i = 0; i < test->transfer_count; i++) {
 		struct spi_transfer *xfer = test->transfers + i;
-		unsigned long long nbits = BITS_PER_BYTE * xfer->len;
+		unsigned long long nbits = (unsigned long long)BITS_PER_BYTE *
+					   xfer->len;
 
 		delay_usecs += xfer->delay_usecs;
 		if (!xfer->speed_hz)
-- 
2.11.0
