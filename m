From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: fsl: Use kmalloc_array() in of_fsl_spi_get_chipselects()" to the spi tree
Date: Tue, 17 Jan 2017 18:46:14 +0000
Message-ID: <E1cTYlq-0000SM-KS@debutante>
References: <2abbbc08-f5bf-28de-e513-5f1074996189@users.sourceforge.net>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2abbbc08-f5bf-28de-e513-5f1074996189@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: fsl: Use kmalloc_array() in of_fsl_spi_get_chipselects()

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

>From d9bc4a8539a518636cd70d498e94787e32ea8fbe Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 13 Jan 2017 13:37:25 +0100
Subject: [PATCH] spi: fsl: Use kmalloc_array() in of_fsl_spi_get_chipselects()

A multiplication for the size determination of a memory allocation
indicated that an array data structure should be processed.
Thus use the corresponding function "kmalloc_array".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 8b290d9d7935..9873d39d1a95 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -727,7 +727,8 @@ static int of_fsl_spi_get_chipselects(struct device *dev)
 		return 0;
 	}
 
-	pinfo->gpios = kmalloc(ngpios * sizeof(*pinfo->gpios), GFP_KERNEL);
+	pinfo->gpios = kmalloc_array(ngpios, sizeof(*pinfo->gpios),
+				     GFP_KERNEL);
 	if (!pinfo->gpios)
 		return -ENOMEM;
 	memset(pinfo->gpios, -1, ngpios * sizeof(*pinfo->gpios));
-- 
2.11.0
