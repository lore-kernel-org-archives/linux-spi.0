From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: loopback-test: fix spelling mistake: "minimam" -> "minimum"" to the spi tree
Date: Thu, 30 Mar 2017 22:23:29 +0100
Message-ID: <E1cthXV-0008LK-3V@debutante>
References: <20170330100125.19703-1-colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170330100125.19703-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: loopback-test: fix spelling mistake: "minimam" -> "minimum"

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

>From 905e0b5ef9690c5433b642f46f1d756bb374da17 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 30 Mar 2017 11:01:25 +0100
Subject: [PATCH] spi: loopback-test: fix spelling mistake: "minimam" ->
 "minimum"

trivial fix to spelling mistake in dev_err error message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-loopback-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 6888d5c34ac4..e6041539afed 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -520,7 +520,7 @@ static int spi_test_check_elapsed_time(struct spi_device *spi,
 	estimated_time += delay_usecs * NSEC_PER_USEC;
 	if (test->elapsed_time < estimated_time) {
 		dev_err(&spi->dev,
-			"elapsed time %lld ns is shorter than minimam estimated time %lld ns\n",
+			"elapsed time %lld ns is shorter than minimum estimated time %lld ns\n",
 			test->elapsed_time, estimated_time);
 
 		return -EINVAL;
-- 
2.11.0
