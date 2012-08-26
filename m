From: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Subject: [PATCH 2/13] drivers/spi/spi-{orion,
	pl022}.c: use clk_prepare_enable and clk_disable_unprepare
Date: Sun, 26 Aug 2012 18:00:54 +0200
Message-ID: <1345996865-32082-3-git-send-email-Julia.Lawall@lip6.fr>
References: <1345996865-32082-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1345996865-32082-1-git-send-email-Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>

Clk_prepare_enable and clk_disable_unprepare combine clk_prepare and
clk_enable, and clk_disable and clk_unprepare.  They make the code more
concise, and ensure that clk_unprepare is called when clk_enable fails.

A simplified version of the semantic patch that introduces calls to these
functions is as follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e;
@@

- clk_prepare(e);
- clk_enable(e);
+ clk_prepare_enable(e);

@@
expression e;
@@

- clk_disable(e);
- clk_unprepare(e);
+ clk_disable_unprepare(e);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>

---
 drivers/spi/spi-orion.c |    3 +--
 drivers/spi/spi-pl022.c |   17 ++++-------------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index b17c09c..b2a7199 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -416,8 +416,7 @@ static int __init orion_spi_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	clk_prepare(spi->clk);
-	clk_enable(spi->clk);
+	clk_prepare_enable(spi->clk);
 	tclk_hz = clk_get_rate(spi->clk);
 	spi->max_speed = DIV_ROUND_UP(tclk_hz, 4);
 	spi->min_speed = DIV_ROUND_UP(tclk_hz, 30);
diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index b0fec03..0d235d4 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2142,16 +2142,10 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 		goto err_no_clk;
 	}
 
-	status = clk_prepare(pl022->clk);
-	if (status) {
-		dev_err(&adev->dev, "could not prepare SSP/SPI bus clock\n");
-		goto  err_clk_prep;
-	}
-
-	status = clk_enable(pl022->clk);
+	status = clk_prepare_enable(pl022->clk);
 	if (status) {
 		dev_err(&adev->dev, "could not enable SSP/SPI bus clock\n");
-		goto err_no_clk_en;
+		goto err_clk_prep;
 	}
 
 	/* Initialize transfer pump */
@@ -2207,9 +2201,7 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 
 	free_irq(adev->irq[0], pl022);
  err_no_irq:
-	clk_disable(pl022->clk);
- err_no_clk_en:
-	clk_unprepare(pl022->clk);
+	clk_disable_unprepare(pl022->clk);
  err_clk_prep:
 	clk_put(pl022->clk);
  err_no_clk:
@@ -2243,8 +2235,7 @@ pl022_remove(struct amba_device *adev)
 		pl022_dma_remove(pl022);
 
 	free_irq(adev->irq[0], pl022);
-	clk_disable(pl022->clk);
-	clk_unprepare(pl022->clk);
+	clk_disable_unprepare(pl022->clk);
 	clk_put(pl022->clk);
 	pm_runtime_disable(&adev->dev);
 	iounmap(pl022->virtbase);


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
