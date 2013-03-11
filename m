From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 03/12] spi/bcm63xx: properly prepare clocks before enabling
	them
Date: Tue, 12 Mar 2013 00:13:38 +0100
Message-ID: <1363043627-23524-4-git-send-email-jogo@openwrt.org>
References: <1363043627-23524-1-git-send-email-jogo@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1363043627-23524-1-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Use proper clk_prepare/unprepare calls in preparation for switching
to the generic clock framework.

Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
 drivers/spi/spi-bcm63xx.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index d7df435..ef9b89f 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -493,7 +493,7 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	}
 
 	/* Initialize hardware */
-	clk_enable(bs->clk);
+	clk_prepare_enable(bs->clk);
 	bcm_spi_writeb(bs, SPI_INTR_CLEAR_ALL, SPI_INT_STATUS);
 
 	/* register and we are done */
@@ -509,7 +509,7 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	return 0;
 
 out_clk_disable:
-	clk_disable(clk);
+	clk_disable_unprepare(clk);
 out_err:
 	platform_set_drvdata(pdev, NULL);
 	spi_master_put(master);
@@ -530,7 +530,7 @@ static int bcm63xx_spi_remove(struct platform_device *pdev)
 	bcm_spi_writeb(bs, 0, SPI_INT_MASK);
 
 	/* HW shutdown */
-	clk_disable(bs->clk);
+	clk_disable_unprepare(bs->clk);
 	clk_put(bs->clk);
 
 	platform_set_drvdata(pdev, 0);
@@ -549,7 +549,7 @@ static int bcm63xx_spi_suspend(struct device *dev)
 
 	spi_master_suspend(master);
 
-	clk_disable(bs->clk);
+	clk_disable_unprepare(bs->clk);
 
 	return 0;
 }
@@ -560,7 +560,7 @@ static int bcm63xx_spi_resume(struct device *dev)
 			platform_get_drvdata(to_platform_device(dev));
 	struct bcm63xx_spi *bs = spi_master_get_devdata(master);
 
-	clk_enable(bs->clk);
+	clk_prepare_enable(bs->clk);
 
 	spi_master_resume(master);
 
-- 
1.7.10.4


------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
