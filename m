From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] spi: st-ssc4: Fix missing spi_master_put in
 spi_st_probe error paths
Date: Fri, 29 Apr 2016 13:39:38 +0800
Message-ID: <1461908378.20684.2.camel@ingics.com>
References: <1461908321.20684.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>,
	Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461908321.20684.1.camel-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-st-ssc4.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index f17c0ab..d5adf9f 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -345,12 +345,13 @@ static int spi_st_probe(struct platform_device *pdev)
 	spi_st->clk = devm_clk_get(&pdev->dev, "ssc");
 	if (IS_ERR(spi_st->clk)) {
 		dev_err(&pdev->dev, "Unable to request clock\n");
-		return PTR_ERR(spi_st->clk);
+		ret = PTR_ERR(spi_st->clk);
+		goto put_master;
 	}
 
 	ret = spi_st_clk_enable(spi_st);
 	if (ret)
-		return ret;
+		goto put_master;
 
 	init_completion(&spi_st->done);
 
@@ -408,7 +409,8 @@ static int spi_st_probe(struct platform_device *pdev)
 
 clk_disable:
 	spi_st_clk_disable(spi_st);
-
+put_master:
+	spi_master_put(master);
 	return ret;
 }
 
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
