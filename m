From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: npcm: fix u32 csgpio being checked for less than zero" to the spi tree
Date: Wed, 14 Nov 2018 22:12:34 +0000 (GMT)
Message-ID: <20181114221234.2F1A9440078@finisterre.ee.mobilebroadband>
References: <20181114214246.15591-1-colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Mark Brown <broonie@kernel.org>, openbmc@lists.ozlabs.org,
        linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114214246.15591-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: npcm: fix u32 csgpio being checked for less than zero

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

>From 757ec116c9bce4278fa4423039736c832cc63b6f Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 14 Nov 2018 21:42:46 +0000
Subject: [PATCH] spi: npcm: fix u32 csgpio being checked for less than zero

The u32 variable csgpio is being checked for an error return
from the call to of_get_named_gpio, however, since this is unsigned
this comparison will always be false. Fix this by making csgpio an
int and fix up the %u format specifiers to %d accordingly.

Detected by CoverityScan, CID#1475476 ("Unsigned compared against 0")

Fixes: 2a22f1b30cee ("spi: npcm: add NPCM PSPI controller driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-npcm-pspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index 51777515c83f..6dae91091143 100644
--- a/drivers/spi/spi-npcm-pspi.c
+++ b/drivers/spi/spi-npcm-pspi.c
@@ -329,7 +329,7 @@ static int npcm_pspi_probe(struct platform_device *pdev)
 	unsigned long clk_hz;
 	struct device_node *np = pdev->dev.of_node;
 	int num_cs, i;
-	u32 csgpio;
+	int csgpio;
 	int irq;
 	int ret;
 
@@ -417,12 +417,12 @@ static int npcm_pspi_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "failed to get csgpio#%u\n", i);
 			goto out_disable_clk;
 		}
-		dev_dbg(&pdev->dev, "csgpio#%u = %u\n", i, csgpio);
+		dev_dbg(&pdev->dev, "csgpio#%u = %d\n", i, csgpio);
 		ret = devm_gpio_request_one(&pdev->dev, csgpio,
 					    GPIOF_OUT_INIT_HIGH, DRIVER_NAME);
 		if (ret < 0) {
 			dev_err(&pdev->dev,
-				"failed to configure csgpio#%u %u\n"
+				"failed to configure csgpio#%u %d\n"
 				, i, csgpio);
 			goto out_disable_clk;
 		}
-- 
2.19.1
