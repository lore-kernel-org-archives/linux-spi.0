From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH 2/4] spi: dw-mmio: prepare the clock before enabling
Date: Thu, 26 Dec 2013 09:00:13 +0200
Message-ID: <1553b4e9cc24fb9fe1eb81b3ee77cdd2e1d3bc69.1388040447.git.baruch@tkos.co.il>
References: <cover.1388040447.git.baruch@tkos.co.il>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>,
	Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1388040447.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is required for common clock support.

Cc: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 drivers/spi/spi-dw-mmio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index a85ff37..073c14e 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -70,7 +70,7 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	dwsmmio->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dwsmmio->clk))
 		return PTR_ERR(dwsmmio->clk);
-	ret = clk_enable(dwsmmio->clk);
+	ret = clk_prepare_enable(dwsmmio->clk);
 	if (ret)
 		return ret;
 
@@ -87,7 +87,7 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	return 0;
 
 out:
-	clk_disable(dwsmmio->clk);
+	clk_disable_unprepare(dwsmmio->clk);
 	return ret;
 }
 
@@ -95,7 +95,7 @@ static int dw_spi_mmio_remove(struct platform_device *pdev)
 {
 	struct dw_spi_mmio *dwsmmio = platform_get_drvdata(pdev);
 
-	clk_disable(dwsmmio->clk);
+	clk_disable_unprepare(dwsmmio->clk);
 	dw_spi_remove_host(&dwsmmio->dws);
 
 	return 0;
-- 
1.8.5.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
