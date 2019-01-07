From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: dw: fix potential variable assignment error" to the spi tree
Date: Mon,  7 Jan 2019 18:59:20 +0000 (GMT)
Message-ID: <20190107185920.562411127491@debutante.sirena.org.uk>
References: <20181228083312.14928-1-shol@livemail.tw>
Cc: shaftarger <shol@livemail.tw>, Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, shaftarger <shol@livemail.tw>,
        linux-spi@vger.kernel.org
To: shaftarger <sholchen@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181228083312.14928-1-shol@livemail.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: dw: fix potential variable assignment error

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

>From e1bc204894eae69b153eb63d9fd65414466fb639 Mon Sep 17 00:00:00 2001
From: shaftarger <sholchen@gmail.com>
Date: Fri, 28 Dec 2018 16:33:12 +0800
Subject: [PATCH] spi: dw: fix potential variable assignment error

spi::mode is defined by framework for several SPI capabilities,
such as polarity, phase, bit-endian, wire number. Directly use this
variable for setting controller's polarity and phase causes other
bit in register being set. Since SPI framework has its definition,
SPI_CPOL and SPI_CPHA offset may be changed by framwork change.
Instead of just mask off the relevant bits,
fetch required bit in spi::mode and set to register.

Signed-off-by: shaftarger <shol@livemail.tw>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 2e822a56576a..a945fad3db62 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -317,7 +317,8 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	/* Default SPI mode is SCPOL = 0, SCPH = 0 */
 	cr0 = (transfer->bits_per_word - 1)
 		| (chip->type << SPI_FRF_OFFSET)
-		| (spi->mode << SPI_MODE_OFFSET)
+		| ((((spi->mode & SPI_CPOL) ? 1 : 0) << SPI_SCOL_OFFSET) |
+			(((spi->mode & SPI_CPHA) ? 1 : 0) << SPI_SCPH_OFFSET))
 		| (chip->tmode << SPI_TMOD_OFFSET);
 
 	/*
-- 
2.20.1
