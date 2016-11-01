From: Robert Baldyga <r.baldyga-anjuHVi6/WSaMJb+Lgu22Q@public.gmane.org>
Subject: [PATCH] spi: imx: set spi_bus_clk for mx21 and mx27
Date: Tue,  1 Nov 2016 22:18:39 +0100
Message-ID: <1478035119-21731-1-git-send-email-r.baldyga@hackerion.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Robert Baldyga <r.baldyga-anjuHVi6/WSaMJb+Lgu22Q@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Introduce additional output parameter in spi_imx_clkdiv_1()
function to return result frequency and set it to spi_bus_clk.

This fixes division by zero bug, which occurred in
spi_imx_calculate_timeout() function.

Signed-off-by: Robert Baldyga <r.baldyga-anjuHVi6/WSaMJb+Lgu22Q@public.gmane.org>
---
 drivers/spi/spi-imx.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index deb782f..088828c 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -173,15 +173,16 @@ static int mxc_clkdivs[] = {0, 3, 4, 6, 8, 12, 16, 24, 32, 48, 64, 96, 128, 192,
 
 /* MX21, MX27 */
 static unsigned int spi_imx_clkdiv_1(unsigned int fin,
-		unsigned int fspi, unsigned int max)
+		unsigned int fspi, unsigned int max, unsigned int *fres)
 {
 	int i;
 
 	for (i = 2; i < max; i++)
 		if (fspi * mxc_clkdivs[i] >= fin)
-			return i;
+			break;
 
-	return max;
+	*fres = fin / mxc_clkdivs[i];
+	return i;
 }
 
 /* MX1, MX31, MX35, MX51 CSPI */
@@ -574,9 +575,12 @@ static int mx21_config(struct spi_device *spi, struct spi_imx_config *config)
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
 	unsigned int reg = MX21_CSPICTRL_ENABLE | MX21_CSPICTRL_MASTER;
 	unsigned int max = is_imx27_cspi(spi_imx) ? 16 : 18;
+	unsigned int clk;
+
+	reg |= spi_imx_clkdiv_1(spi_imx->spi_clk, config->speed_hz, max, &clk)
+		<< MX21_CSPICTRL_DR_SHIFT;
+	spi_imx->spi_bus_clk = clk;
 
-	reg |= spi_imx_clkdiv_1(spi_imx->spi_clk, config->speed_hz, max) <<
-		MX21_CSPICTRL_DR_SHIFT;
 	reg |= config->bpw - 1;
 
 	if (spi->mode & SPI_CPHA)
-- 
2.7.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
