From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi-summary: document set_cs_timing" to the spi tree
Date: Mon,  8 Apr 2019 14:31:39 +0700 (+07)
Message-ID: <20190408073139.B4C2C441D3B@finisterre.ee.mobilebroadband>
References: <1554423259-26056-16-git-send-email-skomatineni@nvidia.com>
Cc: Mark Brown <broonie@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, talho@nvidia.com, skomatineni@nvidia.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554423259-26056-16-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi-summary: document set_cs_timing

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

>From 24496da6927fa7399f7f60ab31b4cea27ec3ed00 Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Thu, 4 Apr 2019 17:14:15 -0700
Subject: [PATCH] spi-summary: document set_cs_timing

This patch documents set_cs_timing SPI master method.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/spi/spi-summary | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/spi/spi-summary b/Documentation/spi/spi-summary
index 1721c1b570c3..1a63194b74d7 100644
--- a/Documentation/spi/spi-summary
+++ b/Documentation/spi/spi-summary
@@ -572,6 +572,12 @@ SPI MASTER METHODS
 	0: transfer is finished
 	1: transfer is still in progress
 
+    master->set_cs_timing(struct spi_device *spi, u8 setup_clk_cycles,
+			      u8 hold_clk_cycles, u8 inactive_clk_cycles)
+	This method allows SPI client drivers to request SPI master controller
+	for configuring device specific CS setup, hold and inactive timing
+	requirements.
+
     DEPRECATED METHODS
 
     master->transfer(struct spi_device *spi, struct spi_message *message)
-- 
2.20.1
