From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: bcm2835: no dev_err() on clk_get() -EPROBE_DEFER" to the spi tree
Date: Tue, 17 Dec 2019 12:39:33 +0000
Message-ID: <applied-20191216230802.45715-2-jquinlan@broadcom.com>
References: <20191216230802.45715-2-jquinlan@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jquinlan@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
To: Jim Quinlan <james.quinlan@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191216230802.45715-2-jquinlan@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: bcm2835: no dev_err() on clk_get() -EPROBE_DEFER

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

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

>From f4dc4abdce4cc290555604107c04854a911b9441 Mon Sep 17 00:00:00 2001
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Mon, 16 Dec 2019 18:08:02 -0500
Subject: [PATCH] spi: bcm2835: no dev_err() on clk_get() -EPROBE_DEFER

Use dev_dbg() on -EPROBE_DEFER and dev_err() on all
other errors.

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Link: https://lore.kernel.org/r/20191216230802.45715-2-jquinlan@broadcom.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm2835.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 69df79914504..b784c9fdf9ec 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1317,7 +1317,10 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	bs->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(bs->clk)) {
 		err = PTR_ERR(bs->clk);
-		dev_err(&pdev->dev, "could not get clk: %d\n", err);
+		if (err == -EPROBE_DEFER)
+			dev_dbg(&pdev->dev, "could not get clk: %d\n", err);
+		else
+			dev_err(&pdev->dev, "could not get clk: %d\n", err);
 		goto out_controller_put;
 	}
 
-- 
2.20.1
