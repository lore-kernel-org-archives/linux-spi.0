From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 7/7 RFC] spi-imx: strip down chipselect function to only drive the chipselect
Date: Wed, 30 Sep 2009 21:43:34 +0200
Message-ID: <1254339814-21506-7-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20090930194211.GB1881@pengutronix.de>
 <1254339814-21506-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1254339814-21506-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <1254339814-21506-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <1254339814-21506-4-git-send-email-u.kleine-koenig@pengutronix.de>
 <1254339814-21506-5-git-send-email-u.kleine-koenig@pengutronix.de>
 <1254339814-21506-6-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org,
	David Brownell <dbrownell@users.sourceforge.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755280AbZI3ToV@vger.kernel.org>
In-Reply-To: <1254339814-21506-6-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

spi_imx_chipselect() made things that should be (and mostly are) done b=
y
spi_imx_setupxfer.  Only setting the tx and rx functions was missing.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/spi/spi_imx.c |   50 ++++++++++++++++-------------------------=
-------
 1 files changed, 17 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
index 2fec117..89c22ef 100644
--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -354,43 +354,14 @@ static int mx1_rx_available(struct spi_imx_data *=
spi_imx)
 static void spi_imx_chipselect(struct spi_device *spi, int is_active)
 {
 	struct spi_imx_data *spi_imx =3D spi_master_get_devdata(spi->master);
-	unsigned int cs =3D 0;
 	int gpio =3D spi_imx->chipselect[spi->chip_select];
-	struct spi_imx_config config;
-
-	if (spi->mode & SPI_CS_HIGH)
-		cs =3D 1;
+	int active =3D is_active !=3D BITBANG_CS_INACTIVE;
+	int dev_is_lowactive =3D !(spi->mode & SPI_CS_HIGH);
=20
-	if (is_active =3D=3D BITBANG_CS_INACTIVE) {
-		if (gpio >=3D 0)
-			gpio_set_value(gpio, !cs);
+	if (gpio < 0)
 		return;
-	}
-
-	config.bpw =3D spi->bits_per_word;
-	config.speed_hz =3D spi->max_speed_hz;
-	config.mode =3D spi->mode;
-	config.cs =3D spi_imx->chipselect[spi->chip_select];
-
-	spi_imx->config(spi_imx, &config);
-
-	/* Initialize the functions for transfer */
-	if (config.bpw <=3D 8) {
-		spi_imx->rx =3D spi_imx_buf_rx_u8;
-		spi_imx->tx =3D spi_imx_buf_tx_u8;
-	} else if (config.bpw <=3D 16) {
-		spi_imx->rx =3D spi_imx_buf_rx_u16;
-		spi_imx->tx =3D spi_imx_buf_tx_u16;
-	} else if (config.bpw <=3D 32) {
-		spi_imx->rx =3D spi_imx_buf_rx_u32;
-		spi_imx->tx =3D spi_imx_buf_tx_u32;
-	} else
-		BUG();
-
-	if (gpio >=3D 0)
-		gpio_set_value(gpio, cs);
=20
-	return;
+	gpio_set_value(gpio, dev_is_lowactive ^ active);
 }
=20
 static void spi_imx_push(struct spi_imx_data *spi_imx)
@@ -451,6 +422,19 @@ static int spi_imx_setupxfer(struct spi_device *sp=
i,
 	if (!config.speed_hz)
 		config.speed_hz =3D spi->max_speed_hz;
=20
+	/* Initialize the functions for transfer */
+	if (config.bpw <=3D 8) {
+		spi_imx->rx =3D spi_imx_buf_rx_u8;
+		spi_imx->tx =3D spi_imx_buf_tx_u8;
+	} else if (config.bpw <=3D 16) {
+		spi_imx->rx =3D spi_imx_buf_rx_u16;
+		spi_imx->tx =3D spi_imx_buf_tx_u16;
+	} else if (config.bpw <=3D 32) {
+		spi_imx->rx =3D spi_imx_buf_rx_u32;
+		spi_imx->tx =3D spi_imx_buf_tx_u32;
+	} else
+		BUG();
+
 	spi_imx->config(spi_imx, &config);
=20
 	return 0;
--=20
1.6.4.3
