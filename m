From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: tegra: fix spelling mistake: "trasfer" -> "transfer"" to the spi tree
Date: Mon, 24 Apr 2017 19:21:08 +0100
Message-ID: <E1d2ibk-0000s7-7P@debutante>
References: <20170423171436.6717-1-colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170423171436.6717-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: tegra: fix spelling mistake: "trasfer" -> "transfer"

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

>From bfca76185d9bd5b3de562bf5023e5d3dddaa9dce Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Sun, 23 Apr 2017 18:14:36 +0100
Subject: [PATCH] spi: tegra: fix spelling mistake: "trasfer" -> "transfer"

trivial fix to spelling mistake in dbg_err messages

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c       | 2 +-
 drivers/spi/spi-tegra20-sflash.c | 2 +-
 drivers/spi/spi-tegra20-slink.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 73779cecc3bb..08012ae5aa66 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -837,7 +837,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 						SPI_DMA_TIMEOUT);
 		if (WARN_ON(ret == 0)) {
 			dev_err(tspi->dev,
-				"spi trasfer timeout, err %d\n", ret);
+				"spi transfer timeout, err %d\n", ret);
 			ret = -EIO;
 			goto complete_xfer;
 		}
diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index b6558bb6f9df..2c797ee2664d 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -341,7 +341,7 @@ static int tegra_sflash_transfer_one_message(struct spi_master *master,
 						SPI_DMA_TIMEOUT);
 		if (WARN_ON(ret == 0)) {
 			dev_err(tsd->dev,
-				"spi trasfer timeout, err %d\n", ret);
+				"spi transfer timeout, err %d\n", ret);
 			ret = -EIO;
 			goto exit;
 		}
diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 85c91f58b42f..0c06ce424210 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -824,7 +824,7 @@ static int tegra_slink_transfer_one(struct spi_master *master,
 					  SLINK_DMA_TIMEOUT);
 	if (WARN_ON(ret == 0)) {
 		dev_err(tspi->dev,
-			"spi trasfer timeout, err %d\n", ret);
+			"spi transfer timeout, err %d\n", ret);
 		return -EIO;
 	}
 
-- 
2.11.0
