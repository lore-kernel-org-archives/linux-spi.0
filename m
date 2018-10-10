From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 10/11] spi: pxa2xx: Add ready signal
Date: Wed, 10 Oct 2018 19:09:35 +0200
Message-ID: <20181010170936.316862-11-lkundrak@v3.sk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Cc: James Cameron <quozl@laptop.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
To: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010170936.316862-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Strobe a GPIO line when the slave TX FIFO is filled. This is how the
Embedded Controller on an OLPC XO-1.75 machine, that happens to be a SPI
master, learns that it can initiate a transaction.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/spi/spi-pxa2xx.c | 12 ++++++++++++
 drivers/spi/spi-pxa2xx.h |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 3848842d68fd..a3b4b12c1077 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1079,6 +1079,9 @@ static int pxa2xx_spi_transfer_one(struct spi_contr=
oller *master,
 	if (spi_controller_is_slave(master)) {
 		while (drv_data->write(drv_data))
 			;
+		gpiod_set_value(drv_data->gpiod_ready, 1);
+		udelay(1);
+		gpiod_set_value(drv_data->gpiod_ready, 0);
 	}
=20
 	/*
@@ -1784,6 +1787,15 @@ static int pxa2xx_spi_probe(struct platform_device=
 *pdev)
 		}
 	}
=20
+	if (platform_info->is_slave) {
+		drv_data->gpiod_ready =3D devm_gpiod_get_optional(dev,
+						"ready", GPIOD_OUT_LOW);
+		if (IS_ERR(drv_data->gpiod_ready)) {
+			status =3D (int)PTR_ERR(drv_data->gpiod_ready);
+			goto out_error_clock_enabled;
+		}
+	}
+
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 513c53aaeab2..4e324da66ef7 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -64,6 +64,9 @@ struct driver_data {
=20
 	/* GPIOs for chip selects */
 	struct gpio_desc **cs_gpiods;
+
+	/* Optional slave FIFO ready signal */
+	struct gpio_desc *gpiod_ready;
 };
=20
 struct chip_data {
--=20
2.19.0
