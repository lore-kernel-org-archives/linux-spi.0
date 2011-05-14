From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] spi: spi_s3c24xx: Use spi_bitbang_stop instead of
 spi_unregister_master in s3c24xx_spi_remove
Date: Sun, 15 May 2011 07:35:16 +0800
Message-ID: <1305416116.24670.3.camel@phoenix>
References: <1305416008.24670.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Ben Dooks <ben@simtec.co.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1305416008.24670.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Calling spi_bitbang_stop() will also destroy bitbang->workqueue,
which is created by calling spi_bitbang_start() in s3c24xx_spi_probe().

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/spi/spi_s3c24xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi_s3c24xx.c b/drivers/spi/spi_s3c24xx.c
index 151a95e..1a5fcab 100644
--- a/drivers/spi/spi_s3c24xx.c
+++ b/drivers/spi/spi_s3c24xx.c
@@ -668,7 +668,7 @@ static int __exit s3c24xx_spi_remove(struct platform_device *dev)
 
 	platform_set_drvdata(dev, NULL);
 
-	spi_unregister_master(hw->master);
+	spi_bitbang_stop(&hw->bitbang);
 
 	clk_disable(hw->clk);
 	clk_put(hw->clk);
-- 
1.7.1
