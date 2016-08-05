From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: rspi: Increase accuracy of bit rate for RZ" to the spi tree
Date: Fri, 05 Aug 2016 15:50:56 +0100
Message-ID: <E1bVgSe-00058k-CZ@debutante>
References: <1470404163-27427-1-git-send-email-chris.brandt@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
	linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Daniel Palmer <danieruru@gmail.com>
To: Chris Brandt <chris.brandt@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1470404163-27427-1-git-send-email-chris.brandt@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: rspi: Increase accuracy of bit rate for RZ

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

>From ed66b659f95717432b7ede24efd8b2a34f479d32 Mon Sep 17 00:00:00 2001
From: Chris Brandt <chris.brandt@renesas.com>
Date: Fri, 5 Aug 2016 09:36:03 -0400
Subject: [PATCH] spi: rspi: Increase accuracy of bit rate for RZ

When you leave the clock divider at 0, 130kHz is the lowest you can go.
Also, by adjusting the clock divider you can get more accurate resolutions
for clock speeds lower than 16MHz. This patch uses the clock divider as
part of the bit rate setup.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rspi.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 818843336932..a816f07e168e 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -295,14 +295,24 @@ static int rspi_set_config_register(struct rspi_data *rspi, int access_size)
 static int rspi_rz_set_config_register(struct rspi_data *rspi, int access_size)
 {
 	int spbr;
+	int div = 0;
+	unsigned long clksrc;
 
 	/* Sets output mode, MOSI signal, and (optionally) loopback */
 	rspi_write8(rspi, rspi->sppcr, RSPI_SPPCR);
 
+	clksrc = clk_get_rate(rspi->clk);
+	while (div < 3) {
+		if (rspi->max_speed_hz >= clksrc/4) /* 4=(CLK/2)/2 */
+			break;
+		div++;
+		clksrc /= 2;
+	}
+
 	/* Sets transfer bit rate */
-	spbr = DIV_ROUND_UP(clk_get_rate(rspi->clk),
-			    2 * rspi->max_speed_hz) - 1;
+	spbr = DIV_ROUND_UP(clksrc, 2 * rspi->max_speed_hz) - 1;
 	rspi_write8(rspi, clamp(spbr, 0, 255), RSPI_SPBR);
+	rspi->spcmd |= div << 2;
 
 	/* Disable dummy transmission, set byte access */
 	rspi_write8(rspi, SPDCR_SPLBYTE, RSPI_SPDCR);
-- 
2.8.1
