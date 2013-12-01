From: takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org
Subject: [PATCH 06/11] spi: spi-sh-msiof: RMDIR1[15:0] may should be zero
Date: Mon,  2 Dec 2013 03:19:17 +0900
Message-ID: <1385921962-19843-6-git-send-email-takasi-y@ops.dti.ne.jp>
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
RMDR1(Receive Mode Register 1) has no FLD, CONT, RXSTP bits.
HW manual says "The write value should always be 0" for RMDR1[15:0].
I guess this is a part of .rx_need_dummy_tx case, and use same flag.

Signed-off-by: Takashi Yoshii <takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>
---
 drivers/spi/spi-sh-msiof.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 936d8ab..b0334b6 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -183,11 +183,13 @@ static void sh_msiof_spi_set_pin_regs(struct sh_msiof_spi_priv *p,
 	 */
 	sh_msiof_write(p, FCTR, 0);
 
-	tmp = 0;
+	tmp = 0x00000005;
 	tmp |= !cs_high << 25;
 	tmp |= lsb_first << 24;
-	sh_msiof_write(p, TMDR1, 0xe0000005 | tmp);
-	sh_msiof_write(p, RMDR1, 0x20000005 | tmp);
+	sh_msiof_write(p, TMDR1, 0xe0000000 | tmp);
+	if (p->info->rx_need_dummy_tx)
+		tmp &= ~0x0000ffff;
+	sh_msiof_write(p, RMDR1, 0x20000000 | tmp);
 
 	tmp = 0xa0000000;
 	tmp |= cpol << 30; /* TSCKIZ */
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
