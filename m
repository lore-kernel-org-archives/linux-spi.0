From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH] spi/bcm63xx: Move default clock configuration to kill compiler warning
Date: Mon,  9 Nov 2015 10:28:50 +0100
Message-ID: <1447061330-19152-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

drivers/spi/spi-bcm63xx.c: In function =E2=80=98bcm63xx_spi_setup_trans=
fer=E2=80=99:
drivers/spi/spi-bcm63xx.c:207: warning: =E2=80=98clk_cfg=E2=80=99 may b=
e used uninitialized in this function

While this is a false positive, it can easily be avoided by selecting
the default clock configuration first.

Signed-off-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
 drivers/spi/spi-bcm63xx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 06858e04ec59a8f2..cc8e1513d167396d 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -207,6 +207,9 @@ static void bcm63xx_spi_setup_transfer(struct spi_d=
evice *spi,
 	u8 clk_cfg, reg;
 	int i;
=20
+	/* Default to lowest clock configuration */
+	clk_cfg =3D SPI_CLK_0_391MHZ;
+
 	/* Find the closest clock configuration */
 	for (i =3D 0; i < SPI_CLK_MASK; i++) {
 		if (t->speed_hz >=3D bcm63xx_spi_freq_table[i][0]) {
@@ -215,10 +218,6 @@ static void bcm63xx_spi_setup_transfer(struct spi_=
device *spi,
 		}
 	}
=20
-	/* No matching configuration found, default to lowest */
-	if (i =3D=3D SPI_CLK_MASK)
-		clk_cfg =3D SPI_CLK_0_391MHZ;
-
 	/* clear existing clock configuration bits of the register */
 	reg =3D bcm_spi_readb(bs, SPI_CLK_CFG);
 	reg &=3D ~SPI_CLK_MASK;
--=20
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
