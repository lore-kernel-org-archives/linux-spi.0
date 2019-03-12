From: Volker Haspel <volker.haspel@linutronix.de>
Subject: [PATCH v2 1/1] spi: spi-fsl-qspi: use devm_spi_register_controller
Date: Tue, 12 Mar 2019 11:12:03 +0100
Message-ID: <20190312101203.14207-2-volker.haspel@linutronix.de>
References: <20190312101203.14207-1-volker.haspel@linutronix.de>
Cc: linux-spi@vger.kernel.org, han.xu@nxp.com,
        volker.haspel@linutronix.de, john.ogness@linutronix.de
To: broonie@kernel.org, linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312101203.14207-1-volker.haspel@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The driver does not clearly unregister the spi controller.
Therefore calling an unbind and bind again will end up in a
Kernel crash.

The function devm_spi_register_controller will automatically
be unregister the SPI device.

Signed-off-by: Volker Haspel <volker.haspel@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/spi/spi-fsl-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 6a713f78a62e..41a49b93ca60 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -882,7 +882,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 
 	ctlr->dev.of_node = np;
 
-	ret = spi_register_controller(ctlr);
+	ret = devm_spi_register_controller(dev, ctlr);
 	if (ret)
 		goto err_destroy_mutex;
 
-- 
2.11.0
