From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: rspi: Add support for multiple native chip selects" to the spi tree
Date: Wed, 08 Jan 2020 15:59:10 +0000
Message-ID: <applied-20200102133822.29346-6-geert+renesas@glider.be>
References: <20200102133822.29346-6-geert+renesas@glider.be>
Cc: Chris Brandt <chris.brandt@renesas.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200102133822.29346-6-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: rspi: Add support for multiple native chip selects

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

>From 9815ed8714d26560d09b41f906b96a97f9bc3e3f Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 2 Jan 2020 14:38:21 +0100
Subject: [PATCH] spi: rspi: Add support for multiple native chip selects

RSPI variants on some SuperH or R-Mobile SoCs support multiple native
chip selects. Add support for this by configuring the SSL Assert Signal
Setting.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20200102133822.29346-6-geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rspi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 9eabef3d6cc4..2f5a856a9319 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -159,7 +159,7 @@
 #define SPCMD_SPIMOD_DUAL	SPCMD_SPIMOD0
 #define SPCMD_SPIMOD_QUAD	SPCMD_SPIMOD1
 #define SPCMD_SPRW		0x0010	/* SPI Read/Write Access (Dual/Quad) */
-#define SPCMD_SSLA_MASK		0x0030	/* SSL Assert Signal Setting (RSPI) */
+#define SPCMD_SSLA(i)		((i) << 4)	/* SSL Assert Signal Setting */
 #define SPCMD_BRDV_MASK		0x000c	/* Bit Rate Division Setting */
 #define SPCMD_CPOL		0x0002	/* Clock Polarity Setting */
 #define SPCMD_CPHA		0x0001	/* Clock Phase Setting */
@@ -933,6 +933,9 @@ static int rspi_prepare_message(struct spi_controller *ctlr,
 	if (spi->mode & SPI_CPHA)
 		rspi->spcmd |= SPCMD_CPHA;
 
+	/* Configure slave signal to assert */
+	rspi->spcmd |= SPCMD_SSLA(spi->chip_select);
+
 	/* CMOS output mode and MOSI signal from previous transfer */
 	rspi->sppcr = 0;
 	if (spi->mode & SPI_LOOP)
-- 
2.20.1
