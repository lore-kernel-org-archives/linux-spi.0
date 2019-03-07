From: Volker Haspel <volker.haspel@linutronix.de>
Subject: [PATCH] spi: spi-fsl-qspi: call spi_unregister_controller
Date: Thu,  7 Mar 2019 11:30:08 +0100
Message-ID: <20190307103008.19841-1-volker.haspel@linutronix.de>
Cc: linux-spi@vger.kernel.org, Han Xu <han.xu@nxp.com>,
        Mark Brown <broonie@kernel.org>, john.ogness@linutronix.de,
        volker.haspel@linutronix.de
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The driver does not clearly unregister the spi controller.
Therefore calling an unbind and bind again will end up in a
Kernel crash.
Each driver who calls spi_register_controller() in the probe function
has to call spi_unregister_controller() too.

Signed-off-by: Volker Haspel <volker.haspel@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/spi/spi-fsl-qspi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 6a713f78a62e..373c4a82e8e3 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -248,6 +248,7 @@ struct fsl_qspi {
 	struct mutex lock;
 	struct pm_qos_request pm_qos_req;
 	int selected;
+	struct spi_controller *ctlr;
 };
 
 static inline int needs_swap_endian(struct fsl_qspi *q)
@@ -812,6 +813,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 			  SPI_TX_DUAL | SPI_TX_QUAD;
 
 	q = spi_controller_get_devdata(ctlr);
+	q->ctlr = ctlr;
 	q->dev = dev;
 	q->devtype_data = of_device_get_match_data(dev);
 	if (!q->devtype_data) {
@@ -912,6 +914,7 @@ static int fsl_qspi_remove(struct platform_device *pdev)
 	fsl_qspi_clk_disable_unprep(q);
 
 	mutex_destroy(&q->lock);
+	spi_unregister_controller(q->ctlr);
 
 	return 0;
 }
-- 
2.11.0
