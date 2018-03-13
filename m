From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] spi: bcm-qspi: fIX some error handling paths
Date: Tue, 13 Mar 2018 19:36:58 +0100
Message-ID: <20180313183658.10641-1-christophe.jaillet@wanadoo.fr>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: broonie@kernel.org, f.fainelli@gmail.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

For some reason, commit c0368e4db4a3 ("spi: bcm-qspi: Fix use after free
in bcm_qspi_probe() in error path") has updated some gotos, but not all of
them.

This looks spurious, so fix it.

Fixes: fa236a7ef240 ("spi: bcm-qspi: Add Broadcom MSPI driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
I've added the same Fixes: tag as in commit c0368e4db4a3 even if the patch
would not cleanly apply on top of it.
At least commit 4e3b2d236fe0 ("spi: bcm-qspi: Add BSPI spi-nor flash
controller driver") would also be needed.

Also the label names could be improved. But this goes beyond the scope of
this patch.
---
 drivers/spi/spi-bcm-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index a172ab299e80..1596d35498c5 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1247,7 +1247,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
 		qspi->base[MSPI]  = devm_ioremap_resource(dev, res);
 		if (IS_ERR(qspi->base[MSPI])) {
 			ret = PTR_ERR(qspi->base[MSPI]);
-			goto qspi_probe_err;
+			goto qspi_resource_err;
 		}
 	} else {
 		goto qspi_resource_err;
@@ -1258,7 +1258,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
 		qspi->base[BSPI]  = devm_ioremap_resource(dev, res);
 		if (IS_ERR(qspi->base[BSPI])) {
 			ret = PTR_ERR(qspi->base[BSPI]);
-			goto qspi_probe_err;
+			goto qspi_resource_err;
 		}
 		qspi->bspi_mode = true;
 	} else {
-- 
2.14.1
