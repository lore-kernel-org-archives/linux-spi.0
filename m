From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: loopback-test: fix spelling mistake: "missmatch" -> "mismatch"" to the spi tree
Date: Tue, 28 Jun 2016 20:36:36 +0100
Message-ID: <E1bHyoG-0004aS-CG@debutante>
References: <1467116108-8047-1-git-send-email-colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467116108-8047-1-git-send-email-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: loopback-test: fix spelling mistake: "missmatch" -> "mismatch"

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

>From b7ddfb9f496e23eafccd1d630f25b68f105e0ee8 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Tue, 28 Jun 2016 13:15:08 +0100
Subject: [PATCH] spi: loopback-test: fix spelling mistake: "missmatch" ->
 "mismatch"

trivial fix to spelling mistake in dev_err message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-loopback-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index cf4bb36bee25..faa1b133b0f1 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -536,7 +536,7 @@ static int spi_test_check_loopback_result(struct spi_device *spi,
 
 mismatch_error:
 	dev_err(&spi->dev,
-		"loopback strangeness - transfer missmatch on byte %04zx - expected 0x%02x, but got 0x%02x\n",
+		"loopback strangeness - transfer mismatch on byte %04zx - expected 0x%02x, but got 0x%02x\n",
 		i, txb, rxb);
 
 	return -EINVAL;
-- 
2.8.1
