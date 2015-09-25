From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: davinci: fix handling platform_get_irq result" to the spi tree
Date: Fri, 25 Sep 2015 11:09:44 -0700
Message-ID: <E1ZfXRI-0002vQ-KC@finisterre>
References: <1443103227-25612-3-git-send-email-a.hajda@samsung.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1443103227-25612-3-git-send-email-a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: davinci: fix handling platform_get_irq result

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

>From 8494cdea2223b66491df1264619e2205b4487913 Mon Sep 17 00:00:00 2001
From: Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Date: Thu, 24 Sep 2015 16:00:10 +0200
Subject: [PATCH] spi: davinci: fix handling platform_get_irq result

The function can return negative value.

The problem has been detected using proposed semantic patch
scripts/coccinelle/tests/assign_signed_to_unsigned.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2046107

Signed-off-by: Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-davinci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 3cf9faa..a85d863 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -992,11 +992,12 @@ static int davinci_spi_probe(struct platform_device *pdev)
 		goto free_master;
 	}
 
-	dspi->irq = platform_get_irq(pdev, 0);
-	if (dspi->irq <= 0) {
+	ret = platform_get_irq(pdev, 0);
+	if (ret == 0)
 		ret = -EINVAL;
+	if (ret < 0)
 		goto free_master;
-	}
+	dspi->irq = ret;
 
 	ret = devm_request_threaded_irq(&pdev->dev, dspi->irq, davinci_spi_irq,
 				dummy_thread_fn, 0, dev_name(&pdev->dev), dspi);
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
