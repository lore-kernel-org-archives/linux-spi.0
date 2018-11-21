From: Radu Pirea <radu_nicolae.pirea@upb.ro>
Subject: [PATCH 1/3] spi: at91-usart: add power management support
Date: Wed, 21 Nov 2018 13:27:30 +0200
Message-ID: <20181121112732.15690-2-radu_nicolae.pirea@upb.ro>
References: <20181121112732.15690-1-radu_nicolae.pirea@upb.ro>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Radu Pirea <radu_nicolae.pirea@upb.ro>
To: richard.genoud@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.co,
        broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121112732.15690-1-radu_nicolae.pirea@upb.ro>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch implements power management callback function for USART as
SPI driver.

Signed-off-by: Radu Pirea <radu_nicolae.pirea@upb.ro>
---
 drivers/spi/spi-at91-usart.c | 61 ++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index a924657642fa..0b07c746453d 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of_gpio.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
=20
 #include <linux/spi/spi.h>
=20
@@ -399,6 +400,59 @@ static int at91_usart_spi_probe(struct platform_devi=
ce *pdev)
 	return ret;
 }
=20
+__maybe_unused static int at91_usart_spi_runtime_suspend(struct device *=
dev)
+{
+	struct spi_controller *ctlr =3D dev_get_drvdata(dev);
+	struct at91_usart_spi *aus =3D spi_master_get_devdata(ctlr);
+
+	clk_disable_unprepare(aus->clk);
+	pinctrl_pm_select_sleep_state(dev);
+
+	return 0;
+}
+
+__maybe_unused static int at91_usart_spi_runtime_resume(struct device *d=
ev)
+{
+	struct spi_controller *ctrl =3D dev_get_drvdata(dev);
+	struct at91_usart_spi *aus =3D spi_master_get_devdata(ctrl);
+
+	pinctrl_pm_select_default_state(dev);
+
+	return clk_prepare_enable(aus->clk);
+}
+
+__maybe_unused static int at91_usart_spi_suspend(struct device *dev)
+{
+	struct spi_controller *ctrl =3D dev_get_drvdata(dev);
+	int ret;
+
+	ret =3D spi_controller_suspend(ctrl);
+	if (ret)
+		return ret;
+
+	if (!pm_runtime_suspended(dev))
+		at91_usart_spi_runtime_suspend(dev);
+
+	return 0;
+}
+
+__maybe_unused static int at91_usart_spi_resume(struct device *dev)
+{
+	struct spi_controller *ctrl =3D dev_get_drvdata(dev);
+	struct at91_usart_spi *aus =3D spi_master_get_devdata(ctrl);
+	int ret;
+
+	if (!pm_runtime_suspended(dev)) {
+		ret =3D at91_usart_spi_runtime_resume(dev);
+		if (ret)
+			return ret;
+	}
+
+	at91_usart_spi_init(aus);
+
+	return spi_controller_resume(ctrl);
+}
+
 static int at91_usart_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr =3D platform_get_drvdata(pdev);
@@ -409,6 +463,12 @@ static int at91_usart_spi_remove(struct platform_dev=
ice *pdev)
 	return 0;
 }
=20
+static const struct dev_pm_ops at91_usart_spi_pm_ops =3D {
+	SET_SYSTEM_SLEEP_PM_OPS(at91_usart_spi_suspend, at91_usart_spi_resume)
+	SET_RUNTIME_PM_OPS(at91_usart_spi_runtime_suspend,
+			   at91_usart_spi_runtime_resume, NULL)
+};
+
 static const struct of_device_id at91_usart_spi_dt_ids[] =3D {
 	{ .compatible =3D "microchip,at91sam9g45-usart-spi"},
 	{ /* sentinel */}
@@ -419,6 +479,7 @@ MODULE_DEVICE_TABLE(of, at91_usart_spi_dt_ids);
 static struct platform_driver at91_usart_spi_driver =3D {
 	.driver =3D {
 		.name =3D "at91_usart_spi",
+		.pm =3D &at91_usart_spi_pm_ops,
 	},
 	.probe =3D at91_usart_spi_probe,
 	.remove =3D at91_usart_spi_remove,
--=20
2.19.1
