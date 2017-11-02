From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: orion: remove redundant assignment of status to zero" to the spi tree
Date: Thu, 02 Nov 2017 13:21:11 +0000
Message-ID: <E1eAFQl-0005xp-IX@debutante>
References: <20171102121625.20387-1-colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171102121625.20387-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: orion: remove redundant assignment of status to zero

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From f747c3104efd1e21528d368910afd978fbcd6a78 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 2 Nov 2017 12:16:25 +0000
Subject: [PATCH] spi: orion: remove redundant assignment of status to zero

The assignment of status to zero is never read, status is either
updated in the next iteration of the of the loop or several
lines after the end of the loop.  Remove it, cleans up clang warning:

drivers/spi/spi-orion.c:674:4: warning: Value stored to 'status'
is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-orion.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 4b6dd73b80da..8974bb340b3a 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -671,7 +671,6 @@ static int orion_spi_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"%pOF has no valid 'reg' property (%d)\n",
 				np, status);
-			status = 0;
 			continue;
 		}
 
-- 
2.15.0
