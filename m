From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi/mpc52xx: Combine substrings for two messages" to the spi tree
Date: Tue, 17 Jan 2017 18:46:00 +0000
Message-ID: <E1cTYlc-0000NO-NT@debutante>
References: <5c12cdac-8887-e5d0-ce80-ca4795354956@users.sourceforge.net>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5c12cdac-8887-e5d0-ce80-ca4795354956@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi/mpc52xx: Combine substrings for two messages

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

>From 9c4f0440ba8f3ad57bebb46cfa29a18333fe4860 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 13 Jan 2017 14:14:45 +0100
Subject: [PATCH] spi/mpc52xx: Combine substrings for two messages

The script "checkpatch.pl" pointed information out like the following.

WARNING: quoted string split across lines

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mpc52xx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index 8cc129efe7ba..e8b59ce4dc3a 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -449,8 +449,7 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 			gpio_cs = of_get_gpio(op->dev.of_node, i);
 			if (gpio_cs < 0) {
 				dev_err(&op->dev,
-					"could not parse the gpio field "
-					"in oftree\n");
+					"could not parse the gpio field in oftree\n");
 				rc = -ENODEV;
 				goto err_gpio;
 			}
@@ -458,8 +457,8 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 			rc = gpio_request(gpio_cs, dev_name(&op->dev));
 			if (rc) {
 				dev_err(&op->dev,
-					"can't request spi cs gpio #%d "
-					"on gpio line %d\n", i, gpio_cs);
+					"can't request spi cs gpio #%d on gpio line %d\n",
+					i, gpio_cs);
 				goto err_gpio;
 			}
 
-- 
2.11.0
