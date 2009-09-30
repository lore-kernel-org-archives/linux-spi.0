From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 3/7] spi-imx: Fix initial chipselect settings
Date: Wed, 30 Sep 2009 21:43:30 +0200
Message-ID: <1254339814-21506-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20090930194211.GB1881@pengutronix.de>
 <1254339814-21506-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1254339814-21506-2-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org,
	Sascha Hauer <s.hauer@pengutronix.de>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755282AbZI3Tqy@vger.kernel.org>
In-Reply-To: <1254339814-21506-2-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

=46rom: Sascha Hauer <s.hauer@pengutronix.de>

We can only setup the gpio pins in spi_setup time when we
know the SPI_CS_HIGH setting.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/spi/spi_imx.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
index a8f9bff..b91a5a8 100644
--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -478,12 +478,18 @@ static int spi_imx_transfer(struct spi_device *sp=
i,
=20
 static int spi_imx_setup(struct spi_device *spi)
 {
+	struct spi_imx_data *spi_imx =3D spi_master_get_devdata(spi->master);
+	int gpio =3D spi_imx->chipselect[spi->chip_select];
+
 	if (!spi->bits_per_word)
 		spi->bits_per_word =3D 8;
=20
 	pr_debug("%s: mode %d, %u bpw, %d hz\n", __func__,
 		 spi->mode, spi->bits_per_word, spi->max_speed_hz);
=20
+	if (gpio >=3D 0)
+		gpio_direction_output(gpio, spi->mode & SPI_CS_HIGH ? 0 : 1);
+
 	spi_imx_chipselect(spi, BITBANG_CS_INACTIVE);
=20
 	return 0;
@@ -532,7 +538,6 @@ static int __init spi_imx_probe(struct platform_dev=
ice *pdev)
 			dev_err(&pdev->dev, "can't get cs gpios");
 			goto out_master_put;
 		}
-		gpio_direction_output(spi_imx->chipselect[i], 1);
 	}
=20
 	spi_imx->bitbang.chipselect =3D spi_imx_chipselect;
--=20
1.6.4.3
