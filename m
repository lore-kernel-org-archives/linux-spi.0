From: Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/2] spi: imx: set spi_bus_clk for mx1, mx31 and mx35
Date: Thu, 1 Sep 2016 22:38:40 +0200
Message-ID: <20160901203840.GA7972@reykholt.kaiser.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Modify spi_imx_clkdiv_2() to return the resulting bus clock frequency
when the selected clock divider is applied. Set spi_imx->spi_bus_clk to
this frequency.

If spi_bus_clk is unset, spi_imx_calculate_timeout() causes a
division by 0.

[   90.356106] Division by zero in kernel.
[   90.362631] CPU: 0 PID: 130 Comm: spidev_test Not tainted 4.8.0-rc3-next-20160825+ #105
[   90.372461] Hardware name: Freescale i.MX25 (Device Tree Support)
[   90.378708] Backtrace:
[...]
[   90.409251] [<c000dda0>] (__div0) from [<c0175b3c>] (Ldiv0+0x8/0x10)
[   90.415783] [<bf007c8c>] (spi_imx_calculate_timeout [spi_imx]) from [<bf007ee8>] (spi_imx_transfer+0x220/0x278 [spi_imx])
[   90.426924] [<bf007cc8>] (spi_imx_transfer [spi_imx]) from [<c01f1560>] (spi_bitbang_transfer_one+0x60/0x8c)
[   90.436864]  r8:d3ad52c8 r7:d3ad5800 r6:d3ad5000 r5:d3ae4f40 r4:00000000
[   90.443737] [<c01f1500>] (spi_bitbang_transfer_one) from [<c01edcb0>] (spi_transfer_one_message+0x12c/0x37c)
[   90.453668]  r8:c0a530e4 r7:d3ad5178 r6:d3ad5800 r5:d3ad5000 r4:d3b13e88 r3:00000000
[   90.461633] [<c01edb84>] (spi_transfer_one_message) from [<c01ee428>] (__spi_pump_messages+0x528/0x568)

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/spi/spi-imx.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index f63cb30..5cc72be 100644
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
1.7.10.4
