From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: tegra20-sflash: use to new `spi_transfer_delay_exec`" to the spi tree
Date: Tue, 15 Oct 2019 12:12:24 +0100 (BST)
Message-ID: <20191015111224.6B0342741CD7@ypsilon.sirena.org.uk>
References: <20190926105147.7839-12-alexandru.ardelean@analog.com>
Cc: baolin.wang@linaro.org, bcm-kernel-feedback-list@broadcom.com,
        broonie@kernel.org, f.fainelli@gmail.com, jic23@kernel.org,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926105147.7839-12-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: tegra20-sflash: use to new `spi_transfer_delay_exec`

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

>From b883d5eda6c49a807e925b257bf9687d5c351004 Mon Sep 17 00:00:00 2001
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Date: Thu, 26 Sep 2019 13:51:39 +0300
Subject: [PATCH] spi: tegra20-sflash: use to new `spi_transfer_delay_exec`

This conversion to the spi_transfer_delay_exec() helper is not
straightforward, as it seems that when a delay is present, the controller
issues a command, and then a delay is followed.

This change adds support for the new `delay` field which is of type
`spi_delay` and keeps backwards compatibility with the old `delay_usecs`
field.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20190926105147.7839-12-alexandru.ardelean@analog.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra20-sflash.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index a841a7250d14..514429379206 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -341,10 +341,11 @@ static int tegra_sflash_transfer_one_message(struct spi_master *master,
 			goto exit;
 		}
 		msg->actual_length += xfer->len;
-		if (xfer->cs_change && xfer->delay_usecs) {
+		if (xfer->cs_change &&
+		    (xfer->delay_usecs || xfer->delay.value)) {
 			tegra_sflash_writel(tsd, tsd->def_command_reg,
 					SPI_COMMAND);
-			udelay(xfer->delay_usecs);
+			spi_transfer_delay_exec(xfer);
 		}
 	}
 	ret = 0;
-- 
2.20.1
