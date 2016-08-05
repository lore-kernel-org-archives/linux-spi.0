From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: sh-msiof: Avoid invalid clock generator parameters
Date: Fri,  5 Aug 2016 10:17:52 +0200
Message-ID: <1470385072-1313-1-git-send-email-geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
	Ulrich Hecht <ulrich.hecht@gmail.com>,
	linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The conversion from a look-up table to a calculation for clock generator
parameters forgot to take into account that BRDV x 1/1 is valid only if
BRPS is x 1/1 or x 1/2, leading to undefined behavior (e.g. arbitrary
clock rates).

This limitation is documented for the MSIOF module in all supported
SH/R-Mobile and R-Car Gen2/Gen3 ARM SoCs.

Tested on r8a7791/koelsch and r8a7795/salvator-x.

Fixes: 65d5665bb260b034 ("spi: sh-msiof: Update calculation of frequency dividing")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
I think this is suitable for stable, so please add

    Cc: stable@vger.kernel.org

when applying.

 drivers/spi/spi-sh-msiof.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 8d1120931f343776..91dc730880264fe8 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -301,6 +301,9 @@ static void sh_msiof_spi_set_clk_regs(struct sh_msiof_spi_priv *p,
 
 	for (k = 0; k < ARRAY_SIZE(sh_msiof_spi_div_table); k++) {
 		brps = DIV_ROUND_UP(div, sh_msiof_spi_div_table[k].div);
+		/* SCR_BRDV_DIV_1 is valid only if BRPS is x 1/1 or x 1/2 */
+		if (sh_msiof_spi_div_table[k].div == 1 && brps > 2)
+			continue;
 		if (brps <= 32) /* max of brdv is 32 */
 			break;
 	}
-- 
1.9.1
