From: takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org
Subject: [PATCH 07/11] spi: spi-sh-msiof: RSCR register may absent
Date: Mon,  2 Dec 2013 03:19:18 +0900
Message-ID: <1385921962-19843-7-git-send-email-takasi-y@ops.dti.ne.jp>
References: <20131202031557.162e78d407d82effdee627ac@ops.dti.ne.jp>
 <1385921962-19843-1-git-send-email-takasi-y@ops.dti.ne.jp>
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385921962-19843-1-git-send-email-takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Takashi Yoshii <takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>

On Ape6, Rcar-H2, and Rcar-M2,
MSIOF lacks RSCR(Receive Clock Select Register).
I guess this is a part of .rx_need_dummy_tx case, and use same flag.

Signed-off-by: Takashi Yoshii <takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>
---
 drivers/spi/spi-sh-msiof.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index b0334b6..bbd989f 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -164,7 +164,8 @@ static void sh_msiof_spi_set_clk_regs(struct sh_msiof_spi_priv *p,
 	k = min_t(int, k, ARRAY_SIZE(sh_msiof_spi_clk_table) - 1);
 
 	sh_msiof_write(p, TSCR, sh_msiof_spi_clk_table[k].scr);
-	sh_msiof_write(p, RSCR, sh_msiof_spi_clk_table[k].scr);
+	if (!p->info->rx_need_dummy_tx)
+		sh_msiof_write(p, RSCR, sh_msiof_spi_clk_table[k].scr);
 }
 
 static void sh_msiof_spi_set_pin_regs(struct sh_msiof_spi_priv *p,
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
