From: Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH 4/5] spi: lpspi: enable runtime pm for lpspi
Date: Wed, 24 Oct 2018 02:50:29 +0000
Message-ID: <20181024024808.14485-4-xiaoning.wang@nxp.com>
References: <20181024024808.14485-1-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>, Han Xu <han.xu@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181024024808.14485-1-xiaoning.wang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Enable the runtime pm for lpspi module

BuildInfo:
	- U-Boot 2018.03-imx_4.14.y

Signed-off-by: Han Xu <han.xu@nxp.com>
Reviewed-by: Frank Li <frank.li@nxp.com>
Signed-off-by: Xiaoning Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 116 ++++++++++++++++++++++++++++--------
 1 file changed, 91 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index a4ad3e881a5e..a8a6699e2741 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -21,9 +21,12 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 #include <linux/types.h>
+#include <linux/pm_runtime.h>
=20
 #define DRIVER_NAME "fsl_lpspi"
=20
+#define FSL_LPSPI_RPM_TIMEOUT 50 /* 50ms */
+
 /* i.MX7ULP LPSPI registers */
 #define IMX7ULP_VERID	0x0
 #define IMX7ULP_PARAM	0x4
@@ -152,13 +155,9 @@ static int lpspi_prepare_xfer_hardware(struct spi_cont=
roller *controller)
 				spi_controller_get_devdata(controller);
 	int ret;
=20
-	ret =3D clk_prepare_enable(fsl_lpspi->clk_ipg);
-	if (ret)
-		return ret;
-
-	ret =3D clk_prepare_enable(fsl_lpspi->clk_per);
-	if (ret) {
-		clk_disable_unprepare(fsl_lpspi->clk_ipg);
+	ret =3D pm_runtime_get_sync(fsl_lpspi->dev);
+	if (ret < 0) {
+		dev_err(fsl_lpspi->dev, "failed to enable clock\n");
 		return ret;
 	}
=20
@@ -170,8 +169,8 @@ static int lpspi_unprepare_xfer_hardware(struct spi_con=
troller *controller)
 	struct fsl_lpspi_data *fsl_lpspi =3D
 				spi_controller_get_devdata(controller);
=20
-	clk_disable_unprepare(fsl_lpspi->clk_ipg);
-	clk_disable_unprepare(fsl_lpspi->clk_per);
+	pm_runtime_mark_last_busy(fsl_lpspi->dev);
+	pm_runtime_put_autosuspend(fsl_lpspi->dev);
=20
 	return 0;
 }
@@ -462,6 +461,45 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id=
)
 	return IRQ_NONE;
 }
=20
+int fsl_lpspi_runtime_resume(struct device *dev)
+{
+	struct fsl_lpspi_data *fsl_lpspi =3D dev_get_drvdata(dev);
+	int ret;
+
+	ret =3D clk_prepare_enable(fsl_lpspi->clk_per);
+	if (ret)
+		return ret;
+
+	ret =3D clk_prepare_enable(fsl_lpspi->clk_ipg);
+	if (ret) {
+		clk_disable_unprepare(fsl_lpspi->clk_per);
+		return ret;
+	}
+
+	return 0;
+}
+
+int fsl_lpspi_runtime_suspend(struct device *dev)
+{
+	struct fsl_lpspi_data *fsl_lpspi =3D dev_get_drvdata(dev);
+
+	clk_disable_unprepare(fsl_lpspi->clk_per);
+	clk_disable_unprepare(fsl_lpspi->clk_ipg);
+
+	return 0;
+}
+
+static int fsl_lpspi_init_rpm(struct fsl_lpspi_data *fsl_lpspi)
+{
+	struct device *dev =3D fsl_lpspi->dev;
+
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, FSL_LPSPI_RPM_TIMEOUT);
+	pm_runtime_use_autosuspend(dev);
+
+	return 0;
+}
+
 static int fsl_lpspi_probe(struct platform_device *pdev)
 {
 	struct fsl_lpspi_data *fsl_lpspi;
@@ -487,6 +525,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev=
)
=20
 	fsl_lpspi =3D spi_controller_get_devdata(controller);
 	fsl_lpspi->dev =3D &pdev->dev;
+	dev_set_drvdata(&pdev->dev, fsl_lpspi);
 	fsl_lpspi->is_slave =3D of_property_read_bool((&pdev->dev)->of_node,
 						    "spi-slave");
=20
@@ -533,28 +572,21 @@ static int fsl_lpspi_probe(struct platform_device *pd=
ev)
 		goto out_controller_put;
 	}
=20
-	ret =3D clk_prepare_enable(fsl_lpspi->clk_ipg);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"can't enable lpspi ipg clock, ret=3D%d\n", ret);
+	/* enable the clock */
+	ret =3D fsl_lpspi_init_rpm(fsl_lpspi);
+	if (ret)
 		goto out_controller_put;
-	}
=20
-	ret =3D clk_prepare_enable(fsl_lpspi->clk_per);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"can't enable lpspi per clock, ret=3D%d\n", ret);
-		clk_disable_unprepare(fsl_lpspi->clk_ipg);
-		goto out_controller_put;
+	ret =3D pm_runtime_get_sync(fsl_lpspi->dev);
+	if (ret < 0) {
+		dev_err(fsl_lpspi->dev, "failed to enable clock\n");
+		return ret;
 	}
=20
 	temp =3D readl(fsl_lpspi->base + IMX7ULP_PARAM);
 	fsl_lpspi->txfifosize =3D 1 << (temp & 0x0f);
 	fsl_lpspi->rxfifosize =3D 1 << ((temp >> 8) & 0x0f);
=20
-	clk_disable_unprepare(fsl_lpspi->clk_per);
-	clk_disable_unprepare(fsl_lpspi->clk_ipg);
-
 	ret =3D devm_spi_register_controller(&pdev->dev, controller);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "spi_register_controller error.\n");
@@ -575,16 +607,50 @@ static int fsl_lpspi_remove(struct platform_device *p=
dev)
 	struct fsl_lpspi_data *fsl_lpspi =3D
 				spi_controller_get_devdata(controller);
=20
-	clk_disable_unprepare(fsl_lpspi->clk_per);
-	clk_disable_unprepare(fsl_lpspi->clk_ipg);
+	pm_runtime_disable(fsl_lpspi->dev);
+
+	spi_master_put(controller);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int fsl_lpspi_suspend(struct device *dev)
+{
+	int ret;
+
+	pinctrl_pm_select_sleep_state(dev);
+	ret =3D pm_runtime_force_suspend(dev);
+	return ret;
+}
+
+static int fsl_lpspi_resume(struct device *dev)
+{
+	int ret;
+
+	ret =3D pm_runtime_force_resume(dev);
+	if (ret) {
+		dev_err(dev, "Error in resume: %d\n", ret);
+		return ret;
+	}
+
+	pinctrl_pm_select_default_state(dev);
=20
 	return 0;
 }
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops fsl_lpspi_pm_ops =3D {
+	SET_RUNTIME_PM_OPS(fsl_lpspi_runtime_suspend,
+				fsl_lpspi_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(fsl_lpspi_suspend, fsl_lpspi_resume)
+};
=20
 static struct platform_driver fsl_lpspi_driver =3D {
 	.driver =3D {
 		.name =3D DRIVER_NAME,
 		.of_match_table =3D fsl_lpspi_dt_ids,
+		.pm =3D &fsl_lpspi_pm_ops,
 	},
 	.probe =3D fsl_lpspi_probe,
 	.remove =3D fsl_lpspi_remove,
--=20
2.17.1
