From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] spi: bcm-qspi: Fix use after free in bcm_qspi_probe() in error path
Date: Wed, 11 Oct 2017 14:59:22 -0700
Message-ID: <20171011215922.20536-1-f.fainelli@gmail.com>
Cc: kdasu.kdev@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM)
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

There was an inversion in how the error path in bcm_qspi_probe() is done
which would make us trip over a KASAN use-after-free report. Turns out
that qspi->dev_ids does not get allocated until later in the probe
process. Fix this by introducing a new lable: qspi_resource_err which
takes care of cleaning up the SPI master instance.

Fixes: fa236a7ef240 ("spi: bcm-qspi: Add Broadcom MSPI driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/spi/spi-bcm-qspi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 6ef6c44f39f5..a172ab299e80 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1250,7 +1250,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
 			goto qspi_probe_err;
 		}
 	} else {
-		goto qspi_probe_err;
+		goto qspi_resource_err;
 	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "bspi");
@@ -1272,7 +1272,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
 		qspi->base[CHIP_SELECT]  = devm_ioremap_resource(dev, res);
 		if (IS_ERR(qspi->base[CHIP_SELECT])) {
 			ret = PTR_ERR(qspi->base[CHIP_SELECT]);
-			goto qspi_probe_err;
+			goto qspi_resource_err;
 		}
 	}
 
@@ -1280,7 +1280,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
 				GFP_KERNEL);
 	if (!qspi->dev_ids) {
 		ret = -ENOMEM;
-		goto qspi_probe_err;
+		goto qspi_resource_err;
 	}
 
 	for (val = 0; val < num_irqs; val++) {
@@ -1369,8 +1369,9 @@ int bcm_qspi_probe(struct platform_device *pdev,
 	bcm_qspi_hw_uninit(qspi);
 	clk_disable_unprepare(qspi->clk);
 qspi_probe_err:
-	spi_master_put(master);
 	kfree(qspi->dev_ids);
+qspi_resource_err:
+	spi_master_put(master);
 	return ret;
 }
 /* probe function to be called by SoC specific platform driver probe */
-- 
2.9.3
