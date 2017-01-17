From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: fsl: Combine substrings for two messages" to the spi tree
Date: Tue, 17 Jan 2017 18:46:06 +0000
Message-ID: <E1cTYli-0000PH-O0@debutante>
References: <0ff54345-a877-fe39-0aa2-a3db617fba38@users.sourceforge.net>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <0ff54345-a877-fe39-0aa2-a3db617fba38@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: fsl: Combine substrings for two messages

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

>From 31ae779421098e9a58a3f10e1e09b2c63f4514fa Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 13 Jan 2017 13:50:21 +0100
Subject: [PATCH] spi: fsl: Combine substrings for two messages

The script "checkpatch.pl" pointed information out like the following.

WARNING: quoted string split across lines

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-spi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index cdee556037f9..0fc3452652ae 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -267,10 +267,9 @@ static int fsl_spi_setup_transfer(struct spi_device *spi,
 	if ((mpc8xxx_spi->spibrg / hz) > 64) {
 		cs->hw_mode |= SPMODE_DIV16;
 		pm = (mpc8xxx_spi->spibrg - 1) / (hz * 64) + 1;
-
-		WARN_ONCE(pm > 16, "%s: Requested speed is too low: %d Hz. "
-			  "Will use %d Hz instead.\n", dev_name(&spi->dev),
-			  hz, mpc8xxx_spi->spibrg / 1024);
+		WARN_ONCE(pm > 16,
+			  "%s: Requested speed is too low: %d Hz. Will use %d Hz instead.\n",
+			  dev_name(&spi->dev), hz, mpc8xxx_spi->spibrg / 1024);
 		if (pm > 16)
 			pm = 16;
 	} else {
@@ -763,8 +762,9 @@ static int of_fsl_spi_get_chipselects(struct device *dev)
 		ret = gpio_direction_output(pinfo->gpios[i],
 					    pinfo->alow_flags[i]);
 		if (ret) {
-			dev_err(dev, "can't set output direction for gpio "
-				"#%d: %d\n", i, ret);
+			dev_err(dev,
+				"can't set output direction for gpio #%d: %d\n",
+				i, ret);
 			goto err_loop;
 		}
 	}
-- 
2.11.0

