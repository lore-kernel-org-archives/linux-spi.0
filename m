From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: tegra114: use packed mode for 32 bits per word" to the spi tree
Date: Mon,  1 Apr 2019 09:54:15 +0100 (BST)
Message-ID: <20190401085415.BEEC5440083@finisterre.ee.mobilebroadband>
References: <1553666207-11414-4-git-send-email-skomatineni@nvidia.com>
Cc: Mark Brown <broonie@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, talho@nvidia.com, skomatineni@nvidia.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553666207-11414-4-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: tegra114: use packed mode for 32 bits per word

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

>From fc9ba6e3e28afcedf3bb3105b1d8cbc5c183c2a3 Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Tue, 26 Mar 2019 22:56:25 -0700
Subject: [PATCH] spi: tegra114: use packed mode for 32 bits per word

Fixes: Use packed mode for 32 bits per word transfers to increase
performance as each packet is a full 32-bit word.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index a76acedd7e2f..929358e3487a 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -259,7 +259,7 @@ static unsigned tegra_spi_calculate_curr_xfer_param(
 
 	tspi->bytes_per_word = DIV_ROUND_UP(bits_per_word, 8);
 
-	if (bits_per_word == 8 || bits_per_word == 16) {
+	if (bits_per_word == 8 || bits_per_word == 16 || bits_per_word == 32) {
 		tspi->is_packed = 1;
 		tspi->words_per_32bit = 32/bits_per_word;
 	} else {
-- 
2.20.1
