From: =?UTF-8?q?J=C3=BCrg=20Billeter?= <j@bitron.ch>
Subject: [PATCH] spi: sh-sci: fix use-after-free in sh_sci_spi_remove()
Date: Mon, 16 Jun 2014 16:39:29 +0200
Message-ID: <1402929569-14500-1-git-send-email-j@bitron.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	=?UTF-8?q?J=C3=BCrg=20Billeter?= <j@bitron.ch>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

setbits() uses sp->membase.

Signed-off-by: J=C3=BCrg Billeter <j@bitron.ch>
---
 drivers/spi/spi-sh-sci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sh-sci.c b/drivers/spi/spi-sh-sci.c
index 1f56ef6..b83dd73 100644
--- a/drivers/spi/spi-sh-sci.c
+++ b/drivers/spi/spi-sh-sci.c
@@ -175,9 +175,9 @@ static int sh_sci_spi_remove(struct platform_device=
 *dev)
 {
 	struct sh_sci_spi *sp =3D platform_get_drvdata(dev);
=20
-	iounmap(sp->membase);
-	setbits(sp, PIN_INIT, 0);
 	spi_bitbang_stop(&sp->bitbang);
+	setbits(sp, PIN_INIT, 0);
+	iounmap(sp->membase);
 	spi_master_put(sp->bitbang.master);
 	return 0;
 }
--=20
2.0.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
