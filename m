From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spidev: remove unused completion" to the spi tree
Date: Mon, 15 May 2017 09:05:06 +0100
Message-ID: <E1dAB06-0002jK-Uw@finisterre>
References: <20170505123049.7500-1-kirkseraph@gmail.com>
Cc: Seraphime Kirkovski (Haapie) <kirkseraph@gmail.com>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Seraphime Kirkovski <kirkseraph@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170505123049.7500-1-kirkseraph@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spidev: remove unused completion

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

>From 76bf569466c68fb3705a3b38cdee026df9861101 Mon Sep 17 00:00:00 2001
From: Seraphime Kirkovski <kirkseraph@gmail.com>
Date: Fri, 5 May 2017 14:30:49 +0200
Subject: [PATCH] spi: spidev: remove unused completion

This removes an unused completion from spidev_sync.

It was introduced in

	commit 25d5cb4b0375e ("spi: remove some spidev oops-on-rmmod paths")

and it was no longer used after:

	commit 98d6f47958001 ("spi: spidev: use spi_sync instead of spi_async")

Signed-off-by: Seraphime Kirkovski (Haapie) <kirkseraph@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spidev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 9a2a79a871ba..3b570018705c 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -99,7 +99,6 @@ MODULE_PARM_DESC(bufsiz, "data bytes in biggest supported SPI message");
 static ssize_t
 spidev_sync(struct spidev_data *spidev, struct spi_message *message)
 {
-	DECLARE_COMPLETION_ONSTACK(done);
 	int status;
 	struct spi_device *spi;
 
-- 
2.11.0
