From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH] spi: atmel: remove warning when !CONFIG_PM_SLEEP
Date: Thu, 10 Sep 2015 10:19:52 +0200
Message-ID: <1441873192-18511-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

When CONFIG_PM is defined but not CONFIG_PM_SLEEP (this happens when
CONFIG_SUSPEND is not defined), there is the following warning:

drivers/spi/spi-atmel.c:1723:12: warning: =E2=80=98atmel_spi_suspend=E2=
=80=99 defined but not used [-Wunused-function]
drivers/spi/spi-atmel.c:1741:12: warning: =E2=80=98atmel_spi_resume=E2=80=
=99 defined but not used [-Wunused-function]

Enclose both atmel_spi_suspend and atmel_spi_resume in #ifdef
CONFIG_PM_SLEEP/#endif to solve that.

Signed-off-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/spi/spi-atmel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index bf9ed380bb1c..63318e2afba1 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1720,6 +1720,7 @@ static int atmel_spi_runtime_resume(struct device=
 *dev)
 	return clk_prepare_enable(as->clk);
 }
=20
+#ifdef CONFIG_PM_SLEEP
 static int atmel_spi_suspend(struct device *dev)
 {
 	struct spi_master *master =3D dev_get_drvdata(dev);
@@ -1756,6 +1757,7 @@ static int atmel_spi_resume(struct device *dev)
=20
 	return ret;
 }
+#endif
=20
 static const struct dev_pm_ops atmel_spi_pm_ops =3D {
 	SET_SYSTEM_SLEEP_PM_OPS(atmel_spi_suspend, atmel_spi_resume)
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
