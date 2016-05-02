From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: st-ssc4: Fix missing spi_master_put in spi_st_probe error paths" to the spi tree
Date: Mon, 02 May 2016 12:03:55 +0100
Message-ID: <E1axBdr-0001jd-7y@debutante>
References: <1461908378.20684.2.camel@ingics.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>,
	Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461908378.20684.2.camel-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: st-ssc4: Fix missing spi_master_put in spi_st_probe error paths

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 1051550e9d2d3550e7c17cd563b908638833979d Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Date: Fri, 29 Apr 2016 13:39:38 +0800
Subject: [PATCH] spi: st-ssc4: Fix missing spi_master_put in spi_st_probe
 error paths

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-st-ssc4.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index f17c0abe299f..d5adf9f31602 100644
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
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
