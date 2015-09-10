From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: atmel: remove warning when !CONFIG_PM_SLEEP" to the spi tree
Date: Thu, 10 Sep 2015 11:36:00 +0100
Message-ID: <E1ZZzCy-0008Pj-9w@finisterre>
References: <1441873192-18511-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441873192-18511-1-git-send-email-alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: atmel: remove warning when !CONFIG_PM_SLEEP

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

=46rom d630526d0aa6acc0868dae892b1febda72029a3e Mon Sep 17 00:00:00 200=
1
=46rom: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Date: Thu, 10 Sep 2015 10:19:52 +0200
Subject: [PATCH] spi: atmel: remove warning when !CONFIG_PM_SLEEP
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

When CONFIG_PM is defined but not CONFIG_PM_SLEEP (this happens when
CONFIG_SUSPEND is not defined), there is the following warning:

drivers/spi/spi-atmel.c:1723:12: warning: =E2=80=98atmel_spi_suspend=E2=
=80=99 defined but not used [-Wunused-function]
drivers/spi/spi-atmel.c:1741:12: warning: =E2=80=98atmel_spi_resume=E2=80=
=99 defined but not used [-Wunused-function]

Enclose both atmel_spi_suspend and atmel_spi_resume in #ifdef
CONFIG_PM_SLEEP/#endif to solve that.

Signed-off-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-atmel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index c9eca34..709fb6f 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1721,6 +1721,7 @@ static int atmel_spi_runtime_resume(struct device=
 *dev)
 	return clk_prepare_enable(as->clk);
 }
=20
+#ifdef CONFIG_PM_SLEEP
 static int atmel_spi_suspend(struct device *dev)
 {
 	struct spi_master *master =3D dev_get_drvdata(dev);
@@ -1757,6 +1758,7 @@ static int atmel_spi_resume(struct device *dev)
=20
 	return ret;
 }
+#endif
=20
 static const struct dev_pm_ops atmel_spi_pm_ops =3D {
 	SET_SYSTEM_SLEEP_PM_OPS(atmel_spi_suspend, atmel_spi_resume)
--=20
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
