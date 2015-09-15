From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: [RESEND PATCH] spi: mediatek: fix wrong error return value on probe
Date: Tue, 15 Sep 2015 14:46:45 +0200
Message-ID: <1442321205-30869-1-git-send-email-javier@osg.samsung.com>
Cc: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Commit adcbcfea15d62 ("spi: mediatek: fix spi clock usage error")
added a new sel_clk but introduced bugs in the error paths since
the wrong struct clk pointers are passed to PTR_ERR().

Fixes: adcbcfea15d62 ("spi: mediatek: fix spi clock usage error")
Signed-off-by: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>

---
Patch based on git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
branch fix/mediatek but also applies cleanly to branch for-linus.

It's the exact same patch than before so I don't know what went wrong.

 drivers/spi/spi-mt65xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 6fbb5e5132b0..e9839a4e0175 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -585,14 +585,14 @@ static int mtk_spi_probe(struct platform_device *pdev)
 
 	mdata->sel_clk = devm_clk_get(&pdev->dev, "sel-clk");
 	if (IS_ERR(mdata->sel_clk)) {
-		ret = PTR_ERR(mdata->spi_clk);
+		ret = PTR_ERR(mdata->sel_clk);
 		dev_err(&pdev->dev, "failed to get sel-clk: %d\n", ret);
 		goto err_put_master;
 	}
 
 	mdata->spi_clk = devm_clk_get(&pdev->dev, "spi-clk");
 	if (IS_ERR(mdata->spi_clk)) {
-		ret = PTR_ERR(mdata->parent_clk);
+		ret = PTR_ERR(mdata->spi_clk);
 		dev_err(&pdev->dev, "failed to get spi-clk: %d\n", ret);
 		goto err_put_master;
 	}
-- 
2.4.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
