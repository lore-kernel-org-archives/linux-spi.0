From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: omap2-mcspi: add runtime PM to set_cs()" to the spi tree
Date: Fri, 24 Jul 2015 18:29:19 +0100
Message-ID: <E1ZIgmd-0001Id-LR@debutante>
References: <1437590769-14632-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437590769-14632-1-git-send-email-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: omap2-mcspi: add runtime PM to set_cs()

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

=46rom 5f74db105b1c0980c9863e7a7d1bc0525e0316e8 Mon Sep 17 00:00:00 200=
1
=46rom: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Date: Wed, 22 Jul 2015 20:46:09 +0200
Subject: [PATCH] spi: omap2-mcspi: add runtime PM to set_cs()
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Since commit ddcad7e9068eb omap2_mcspi_set_cs() is called without
runtime power management requested.  This patch fixes the problem by
requesting runtime power management in omap2_mcspi_set_cs().

Reported-By: Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
=46ixes: ddcad7e9068eb (spi: omap2-mcspi: Fix native cs with new set_cs=
)
Tested-By: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Acked-by: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcsp=
i.c
index 58673841286c..3d09e0b69b73 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -245,6 +245,7 @@ static void omap2_mcspi_set_enable(const struct spi=
_device *spi, int enable)
=20
 static void omap2_mcspi_set_cs(struct spi_device *spi, bool enable)
 {
+	struct omap2_mcspi *mcspi =3D spi_master_get_devdata(spi->master);
 	u32 l;
=20
 	/* The controller handles the inverted chip selects
@@ -255,6 +256,12 @@ static void omap2_mcspi_set_cs(struct spi_device *=
spi, bool enable)
 		enable =3D !enable;
=20
 	if (spi->controller_state) {
+		int err =3D pm_runtime_get_sync(mcspi->dev);
+		if (err < 0) {
+			dev_err(mcspi->dev, "failed to get sync: %d\n", err);
+			return;
+		}
+
 		l =3D mcspi_cached_chconf0(spi);
=20
 		if (enable)
@@ -263,6 +270,9 @@ static void omap2_mcspi_set_cs(struct spi_device *s=
pi, bool enable)
 			l |=3D OMAP2_MCSPI_CHCONF_FORCE;
=20
 		mcspi_write_chconf0(spi, l);
+
+		pm_runtime_mark_last_busy(mcspi->dev);
+		pm_runtime_put_autosuspend(mcspi->dev);
 	}
 }
=20
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
