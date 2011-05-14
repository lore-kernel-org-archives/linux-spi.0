From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/2] spi: spi_nuc900: Use spi_bitbang_stop instead of
 spi_unregister_master in nuc900_spi_remove
Date: Sun, 15 May 2011 07:33:28 +0800
Message-ID: <1305416008.24670.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Wan ZongShun <mcuos.com@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Calling spi_bitbang_stop() will also destroy bitbang->workqueue,
which is created by calling spi_bitbang_start() in nuc900_spi_probe().

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/spi/spi_nuc900.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi_nuc900.c b/drivers/spi/spi_nuc900.c
index d5be18b..3cd15f6 100644
--- a/drivers/spi/spi_nuc900.c
+++ b/drivers/spi/spi_nuc900.c
@@ -463,7 +463,7 @@ static int __devexit nuc900_spi_remove(struct platform_device *dev)
 
 	platform_set_drvdata(dev, NULL);
 
-	spi_unregister_master(hw->master);
+	spi_bitbang_stop(&hw->bitbang);
 
 	clk_disable(hw->clk);
 	clk_put(hw->clk);
-- 
1.7.1
