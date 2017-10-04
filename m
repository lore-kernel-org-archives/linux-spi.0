From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sh-msiof: Use of_device_get_match_data() helper" to the spi tree
Date: Wed, 04 Oct 2017 15:51:42 +0100
Message-ID: <E1dzl1S-0008Uw-6i@debutante>
References: <1507119627-12865-1-git-send-email-geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1507119627-12865-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sh-msiof: Use of_device_get_match_data() helper

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

>From ecb1596aa27856a256b0698a93d7be06ce041e73 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 4 Oct 2017 14:20:27 +0200
Subject: [PATCH] spi: sh-msiof: Use of_device_get_match_data() helper

Use the of_device_get_match_data() helper instead of open coding.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sh-msiof.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 00808448cf35..2c5ea4c57508 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1211,15 +1211,13 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	struct resource	*r;
 	struct spi_master *master;
 	const struct sh_msiof_chipdata *chipdata;
-	const struct of_device_id *of_id;
 	struct sh_msiof_spi_info *info;
 	struct sh_msiof_spi_priv *p;
 	int i;
 	int ret;
 
-	of_id = of_match_device(sh_msiof_match, &pdev->dev);
-	if (of_id) {
-		chipdata = of_id->data;
+	chipdata = of_device_get_match_data(&pdev->dev);
+	if (chipdata) {
 		info = sh_msiof_spi_parse_dt(&pdev->dev);
 	} else {
 		chipdata = (const void *)pdev->id_entry->driver_data;
-- 
2.14.1
