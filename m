From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v1 3/3] spi: imx: use PIO mode if size is small
Date: Wed, 10 Oct 2018 10:32:48 +0000
Message-ID: <1539196453-8704-4-git-send-email-yibin.gong@nxp.com>
References: <1539196453-8704-1-git-send-email-yibin.gong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539196453-8704-1-git-send-email-yibin.gong@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Use PIO mode instead if size is smaller than fifo size, since
dma may be less efficient.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/spi/spi-imx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 037abbb..dd1ce12 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -224,6 +224,9 @@ static bool spi_imx_can_dma(struct spi_master *master, =
struct spi_device *spi,
 	if (spi_imx->slave_mode)
 		return false;
=20
+	if (transfer->len < spi_imx->devtype_data->fifo_size)
+		return false;
+
 	spi_imx->dynamic_burst =3D 0;
=20
 	return true;
--=20
2.7.4
