From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: loopback-test: fix spelling mistake: "reruning" -> "rerunning"" to the spi tree
Date: Wed, 28 Jun 2017 20:24:53 +0100
Message-ID: <E1dQIa5-0004YN-MP@finisterre>
References: <20170626134231.23958-1-colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170626134231.23958-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: loopback-test: fix spelling mistake: "reruning" -> "rerunning"

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

>From 478de2ba0d2dafcd460b17f032139e2b6b4eb1ac Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Mon, 26 Jun 2017 14:42:31 +0100
Subject: [PATCH] spi: loopback-test: fix spelling mistake: "reruning" ->
 "rerunning"

trivial fix to spelling mistake in dev_info error message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-loopback-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index f4875f177df0..514997a143dc 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -894,7 +894,7 @@ int spi_test_execute_msg(struct spi_device *spi, struct spi_test *test,
 		test->elapsed_time = ktime_to_ns(ktime_sub(ktime_get(), start));
 		if (ret == -ETIMEDOUT) {
 			dev_info(&spi->dev,
-				 "spi-message timed out - reruning...\n");
+				 "spi-message timed out - rerunning...\n");
 			/* rerun after a few explicit schedules */
 			for (i = 0; i < 16; i++)
 				schedule();
-- 
2.13.2
