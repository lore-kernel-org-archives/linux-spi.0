From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] SPI: spi_sh_msiof: fix a wrong free_irq() parameter
Date: Mon, 17 Jan 2011 17:01:07 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1101171700370.16051@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-sh@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Without this fix reloading of the driver is impossible.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/spi/spi_sh_msiof.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi_sh_msiof.c b/drivers/spi/spi_sh_msiof.c
index d93b667..56f60c8 100644
--- a/drivers/spi/spi_sh_msiof.c
+++ b/drivers/spi/spi_sh_msiof.c
@@ -635,7 +635,7 @@ static int sh_msiof_spi_remove(struct platform_device *pdev)
 	ret = spi_bitbang_stop(&p->bitbang);
 	if (!ret) {
 		pm_runtime_disable(&pdev->dev);
-		free_irq(platform_get_irq(pdev, 0), sh_msiof_spi_irq);
+		free_irq(platform_get_irq(pdev, 0), p);
 		iounmap(p->mapbase);
 		clk_put(p->clk);
 		spi_master_put(p->bitbang.master);
-- 
1.7.2.3

