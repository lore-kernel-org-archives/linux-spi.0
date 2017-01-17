From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi/mpc52xx: Use kmalloc_array() in mpc52xx_spi_probe()" to the spi tree
Date: Tue, 17 Jan 2017 18:46:03 +0000
Message-ID: <E1cTYlf-0000ON-Nl@debutante>
References: <eb433c31-35b0-14a6-8ded-6b14ba8752c2@users.sourceforge.net>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <eb433c31-35b0-14a6-8ded-6b14ba8752c2@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi/mpc52xx: Use kmalloc_array() in mpc52xx_spi_probe()

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

>From 8b6c8955b5dc21358cb1f67cadc5514d2353375d Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 13 Jan 2017 14:06:10 +0100
Subject: [PATCH] spi/mpc52xx: Use kmalloc_array() in mpc52xx_spi_probe()

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus use the corresponding function "kmalloc_array".

  This issue was detected by using the Coccinelle software.

* Replace the specification of a data type by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mpc52xx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index c36002110c30..8cc129efe7ba 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -437,8 +437,9 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 	ms->gpio_cs_count = of_gpio_count(op->dev.of_node);
 	if (ms->gpio_cs_count > 0) {
 		master->num_chipselect = ms->gpio_cs_count;
-		ms->gpio_cs = kmalloc(ms->gpio_cs_count * sizeof(unsigned int),
-				GFP_KERNEL);
+		ms->gpio_cs = kmalloc_array(ms->gpio_cs_count,
+					    sizeof(*ms->gpio_cs),
+					    GFP_KERNEL);
 		if (!ms->gpio_cs) {
 			rc = -ENOMEM;
 			goto err_alloc_gpio;
-- 
2.11.0
