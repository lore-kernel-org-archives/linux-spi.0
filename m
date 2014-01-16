From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] spi/pxa2xx: fix compilation warning when !CONFIG_PM_SLEEP
Date: Thu, 16 Jan 2014 14:50:55 +0200
Message-ID: <1389876655-5484-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

CONFIG_PM will be set if either or both CONFIG_PM_SLEEP and
CONFIG_PM_RUNTIME is set. Compiling the driver with !CONFIG_PM_SLEEP ca=
uses
following compilation warning:

drivers/spi/spi-pxa2xx.c:1270:12: warning: =E2=80=98pxa2xx_spi_suspend=E2=
=80=99 defined but not used [-Wunused-function]

=46ix this by using CONFIG_PM_SLEEP instead.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index cbc68848789d..c702fc536a77 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1268,7 +1268,7 @@ static void pxa2xx_spi_shutdown(struct platform_d=
evice *pdev)
 		dev_err(&pdev->dev, "shutdown failed with %d\n", status);
 }
=20
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int pxa2xx_spi_suspend(struct device *dev)
 {
 	struct driver_data *drv_data =3D dev_get_drvdata(dev);
--=20
1.8.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
