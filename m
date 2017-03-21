From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: loopback-test: fix potential integer overflow on multiple" to the spi tree
Date: Tue, 21 Mar 2017 18:46:09 +0000
Message-ID: <E1cqOnJ-0001HU-3p@debutante>
References: <20170320135805.10182-1-colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170320135805.10182-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: loopback-test: fix potential integer overflow on multiple

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

>From d2c14c64d678713fced6f2261ce7d398b4351de5 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Mon, 20 Mar 2017 13:58:05 +0000
Subject: [PATCH] spi: loopback-test: fix potential integer overflow on
 multiple

A multiplication of 8U * xfer-len with the type of a 32 bit unsigned int
is evaluated using 32 bit arithmetic and then used in a context that
expects an expression of type unsigned long long (64 bits).  Avoid any
potential overflow by casting BITS_PER_BYTE to unsigned long long.

Detected by CoverityScan, CID#1419691 ("Unintentional integer overflow")

Fixes: ea9936f324356 ("spi: loopback-test: add elapsed time check")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-loopback-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index fcae3377ec26..6888d5c34ac4 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -508,7 +508,8 @@ static int spi_test_check_elapsed_time(struct spi_device *spi,
 
 	for (i = 0; i < test->transfer_count; i++) {
 		struct spi_transfer *xfer = test->transfers + i;
-		unsigned long long nbits = BITS_PER_BYTE * xfer->len;
+		unsigned long long nbits = (unsigned long long)BITS_PER_BYTE *
+					   xfer->len;
 
 		delay_usecs += xfer->delay_usecs;
 		if (!xfer->speed_hz)
-- 
2.11.0
