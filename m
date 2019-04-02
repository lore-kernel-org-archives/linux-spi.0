From: Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH] spi: lpspi: add missing complete in abort func at dma mode
Date: Tue, 2 Apr 2019 12:45:53 +0000
Message-ID: <20190402124609.22157-1-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add the missing complete operations for dma_completion to fix the
problem of blocking at the wait_for_completion_interruptible()
function when use spi_slave_abort().

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 0252cae0b35b..33b6a8affd55 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -482,7 +482,13 @@ static int fsl_lpspi_slave_abort(struct spi_controller=
 *controller)
 				spi_controller_get_devdata(controller);
=20
 	fsl_lpspi->slave_aborted =3D true;
-	complete(&fsl_lpspi->xfer_done);
+	if (!fsl_lpspi->usedma)
+		complete(&fsl_lpspi->xfer_done);
+	else {
+		complete(&fsl_lpspi->dma_tx_completion);
+		complete(&fsl_lpspi->dma_rx_completion);
+	}
+
 	return 0;
 }
=20
--=20
2.17.1
