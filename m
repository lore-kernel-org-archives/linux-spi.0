From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi/bcm63xx: Move default clock configuration to kill compiler warning" to the spi tree
Date: Mon, 16 Nov 2015 17:52:00 +0000
Message-ID: <E1ZyNwe-0006sq-E8@debutante>
References: <1447061330-19152-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1447061330-19152-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi/bcm63xx: Move default clock configuration to kill compiler warni=
ng

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git=20

All being well this means that it will be integrated into the linux-nex=
t
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted. =20

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems an=
d
send followup patches addressing any issues that are reported if needed=
=2E

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

=46rom 4dde99bd32fc3f61f7c2b602a78f1627a118e450 Mon Sep 17 00:00:00 200=
1
=46rom: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Date: Mon, 9 Nov 2015 10:28:50 +0100
Subject: [PATCH] spi/bcm63xx: Move default clock configuration to kill
 compiler warning
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

drivers/spi/spi-bcm63xx.c: In function =E2=80=98bcm63xx_spi_setup_trans=
fer=E2=80=99:
drivers/spi/spi-bcm63xx.c:207: warning: =E2=80=98clk_cfg=E2=80=99 may b=
e used uninitialized in this function

While this is a false positive, it can easily be avoided by selecting
the default clock configuration first.

Signed-off-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-bcm63xx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 06858e04ec59..cc8e1513d167 100644
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
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
