From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: imx: set spi_bus_clk for mx1, mx31 and mx35" to the spi tree
Date: Wed, 14 Sep 2016 18:16:21 +0100
Message-ID: <E1bkDnJ-0001v5-2W@debutante>
References: <20160901203840.GA7972@reykholt.kaiser.cx>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Martin Kaiser <martin@kaiser.cx>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160901203840.GA7972@reykholt.kaiser.cx>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: imx: set spi_bus_clk for mx1, mx31 and mx35

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

>From 2636ba8fa39915c7b8d73166961ebbb4c14251cd Mon Sep 17 00:00:00 2001
From: Martin Kaiser <martin@kaiser.cx>
Date: Thu, 1 Sep 2016 22:38:40 +0200
Subject: [PATCH] spi: imx: set spi_bus_clk for mx1, mx31 and mx35

Modify spi_imx_clkdiv_2() to return the resulting bus clock frequency
when the selected clock divider is applied. Set spi_imx->spi_bus_clk to
this frequency.

If spi_bus_clk is unset, spi_imx_calculate_timeout() causes a
division by 0.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index f63cb30f9010..5cc72be30744 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -186,17 +186,19 @@ static unsigned int spi_imx_clkdiv_1(unsigned int fin,
 
 /* MX1, MX31, MX35, MX51 CSPI */
 static unsigned int spi_imx_clkdiv_2(unsigned int fin,
-		unsigned int fspi)
+		unsigned int fspi, unsigned int *fres)
 {
 	int i, div = 4;
 
 	for (i = 0; i < 7; i++) {
 		if (fspi * div >= fin)
-			return i;
+			goto out;
 		div <<= 1;
 	}
 
-	return 7;
+out:
+	*fres = fin / div;
+	return i;
 }
 
 static int spi_imx_bytes_per_word(const int bpw)
@@ -482,9 +484,11 @@ static int mx31_config(struct spi_device *spi, struct spi_imx_config *config)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
 	unsigned int reg = MX31_CSPICTRL_ENABLE | MX31_CSPICTRL_MASTER;
+	unsigned int clk;
 
-	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, config->speed_hz) <<
+	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, config->speed_hz, &clk) <<
 		MX31_CSPICTRL_DR_SHIFT;
+	spi_imx->spi_bus_clk = clk;
 
 	if (is_imx35_cspi(spi_imx)) {
 		reg |= (config->bpw - 1) << MX35_CSPICTRL_BL_SHIFT;
@@ -625,9 +629,12 @@ static int mx1_config(struct spi_device *spi, struct spi_imx_config *config)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
 	unsigned int reg = MX1_CSPICTRL_ENABLE | MX1_CSPICTRL_MASTER;
+	unsigned int clk;
 
-	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, config->speed_hz) <<
+	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, config->speed_hz, &clk) <<
 		MX1_CSPICTRL_DR_SHIFT;
+	spi_imx->spi_bus_clk = clk;
+
 	reg |= config->bpw - 1;
 
 	if (spi->mode & SPI_CPHA)
-- 
2.8.1
