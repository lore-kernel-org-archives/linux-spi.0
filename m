From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: sh-msiof: Avoid invalid clock generator parameters" to the spi tree
Date: Fri, 05 Aug 2016 12:19:12 +0100
Message-ID: <E1bVd9k-0001RH-Qo@debutante>
References: <1470385072-1313-1-git-send-email-geert+renesas@glider.be>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>,
	Ulrich Hecht <ulrich.hecht-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1470385072-1313-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: sh-msiof: Avoid invalid clock generator parameters

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

>From c3ccf357c3d75bd2924e049b6a991f7c0c111068 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Date: Fri, 5 Aug 2016 10:17:52 +0200
Subject: [PATCH] spi: sh-msiof: Avoid invalid clock generator parameters

The conversion from a look-up table to a calculation for clock generator
parameters forgot to take into account that BRDV x 1/1 is valid only if
BRPS is x 1/1 or x 1/2, leading to undefined behavior (e.g. arbitrary
clock rates).

This limitation is documented for the MSIOF module in all supported
SH/R-Mobile and R-Car Gen2/Gen3 ARM SoCs.

Tested on r8a7791/koelsch and r8a7795/salvator-x.

Fixes: 65d5665bb260b034 ("spi: sh-msiof: Update calculation of frequency dividing")
Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-sh-msiof.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 0f83ad1d5a58..1de3a772eb7d 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -262,6 +262,9 @@ static void sh_msiof_spi_set_clk_regs(struct sh_msiof_spi_priv *p,
 
 	for (k = 0; k < ARRAY_SIZE(sh_msiof_spi_div_table); k++) {
 		brps = DIV_ROUND_UP(div, sh_msiof_spi_div_table[k].div);
+		/* SCR_BRDV_DIV_1 is valid only if BRPS is x 1/1 or x 1/2 */
+		if (sh_msiof_spi_div_table[k].div == 1 && brps > 2)
+			continue;
 		if (brps <= 32) /* max of brdv is 32 */
 			break;
 	}
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
