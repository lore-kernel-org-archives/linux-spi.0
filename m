From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: tools: enable CROSS_COMPILE in Makefile" to the spi tree
Date: Mon, 12 Sep 2016 20:07:48 +0100
Message-ID: <E1bjWa4-0002kx-Df@debutante>
References: <1473262980-20103-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, jorge.ramirez-ortiz@linaro.org,
        daniel.thompson@linaro.org, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473262980-20103-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: tools: enable CROSS_COMPILE in Makefile

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

>From 2a4635ea1d39affd8bc9d33b062b03f33c910889 Mon Sep 17 00:00:00 2001
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Date: Wed, 7 Sep 2016 17:43:00 +0200
Subject: [PATCH] spi: tools: enable CROSS_COMPILE in Makefile

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/spi/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/spi/Makefile b/tools/spi/Makefile
index cd0db62e4d9d..3815b18ba070 100644
--- a/tools/spi/Makefile
+++ b/tools/spi/Makefile
@@ -1,3 +1,5 @@
+CC = $(CROSS_COMPILE)gcc
+
 all: spidev_test spidev_fdx
 
 clean:
-- 
2.8.1
