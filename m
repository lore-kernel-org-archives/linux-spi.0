From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi/ppc4xx: Combine substrings for a message in spi_ppc4xx_of_probe()" to the spi tree
Date: Tue, 17 Jan 2017 18:45:57 +0000
Message-ID: <E1cTYlZ-0000MR-P0@debutante>
References: <e5ef99cc-fa83-8001-aeba-5d2f7852bd40@users.sourceforge.net>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e5ef99cc-fa83-8001-aeba-5d2f7852bd40@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi/ppc4xx: Combine substrings for a message in spi_ppc4xx_of_probe()

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

>From ffcaef5ac27b62b480b94036615b3ae4f1b725fe Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 13 Jan 2017 14:43:06 +0100
Subject: [PATCH] spi/ppc4xx: Combine substrings for a message in
 spi_ppc4xx_of_probe()

The script "checkpatch.pl" pointed information out like the following.

WARNING: quoted string split across lines

Thus fix the affected source code place.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-ppc4xx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index dd3d0a218d8b..b2df63c66494 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -428,8 +428,9 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 				/* Real CS - set the initial state. */
 				ret = gpio_request(gpio, np->name);
 				if (ret < 0) {
-					dev_err(dev, "can't request gpio "
-							"#%d: %d\n", i, ret);
+					dev_err(dev,
+						"can't request gpio #%d: %d\n",
+						i, ret);
 					goto free_gpios;
 				}
 
-- 
2.11.0
