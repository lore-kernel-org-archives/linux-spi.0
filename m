From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi/ppc4xx: Use kcalloc() in spi_ppc4xx_of_probe()" to the spi tree
Date: Tue, 17 Jan 2017 18:45:54 +0000
Message-ID: <E1cTYlW-0000LX-PS@debutante>
References: <777d3bd9-4817-d688-d496-b871edbbc937@users.sourceforge.net>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <777d3bd9-4817-d688-d496-b871edbbc937@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi/ppc4xx: Use kcalloc() in spi_ppc4xx_of_probe()

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

>From 797236f10a095a1742373bca5f284c5ec8afb446 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 13 Jan 2017 14:30:43 +0100
Subject: [PATCH] spi/ppc4xx: Use kcalloc() in spi_ppc4xx_of_probe()

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus reuse the corresponding function "kcalloc".

  This issue was detected by using the Coccinelle software.

* Replace the specification of a data type by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-ppc4xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index b2df63c66494..967d94844b30 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -411,7 +411,7 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 	if (num_gpios > 0) {
 		int i;
 
-		hw->gpios = kzalloc(sizeof(int) * num_gpios, GFP_KERNEL);
+		hw->gpios = kcalloc(num_gpios, sizeof(*hw->gpios), GFP_KERNEL);
 		if (!hw->gpios) {
 			ret = -ENOMEM;
 			goto free_master;
-- 
2.11.0
