From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: dw: Fix Designware SPI loopback" to the spi tree
Date: Tue,  5 Nov 2019 23:51:29 +0000 (GMT)
Message-ID: <20191105235129.CEADC274301E@ypsilon.sirena.org.uk>
References: <1572985330-5525-1-git-send-email-thor.thayer@linux.intel.com>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
To: Thor Thayer <thor.thayer@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1572985330-5525-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: dw: Fix Designware SPI loopback

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

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

>From 1403cfa69d310781f9548951c97725c67ffcf613 Mon Sep 17 00:00:00 2001
From: Thor Thayer <thor.thayer@linux.intel.com>
Date: Tue, 5 Nov 2019 14:22:10 -0600
Subject: [PATCH] spi: dw: Fix Designware SPI loopback

The SPI_LOOP is set in spi->mode but not propagated to the register.
A previous patch removed the bit during a cleanup.

Fixes: e1bc204894ea ("spi: dw: fix potential variable assignment error")
Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
Link: https://lore.kernel.org/r/1572985330-5525-1-git-send-email-thor.thayer@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 9a49e073e8b7..076652d3d051 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -308,7 +308,8 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	cr0 = (transfer->bits_per_word - 1)
 		| (chip->type << SPI_FRF_OFFSET)
 		| ((((spi->mode & SPI_CPOL) ? 1 : 0) << SPI_SCOL_OFFSET) |
-			(((spi->mode & SPI_CPHA) ? 1 : 0) << SPI_SCPH_OFFSET))
+			(((spi->mode & SPI_CPHA) ? 1 : 0) << SPI_SCPH_OFFSET) |
+			(((spi->mode & SPI_LOOP) ? 1 : 0) << SPI_SRL_OFFSET))
 		| (chip->tmode << SPI_TMOD_OFFSET);
 
 	/*
-- 
2.20.1
