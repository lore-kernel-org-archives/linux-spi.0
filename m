From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: orion: Fix return value check in orion_spi_probe()" to the spi tree
Date: Mon, 13 Jun 2016 16:48:17 +0100
Message-ID: <E1bCU65-000383-Cp@finisterre>
References: <1465828343-17298-1-git-send-email-weiyj_lk@163.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1465828343-17298-1-git-send-email-weiyj_lk-9Onoh4P/yGk@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: orion: Fix return value check in orion_spi_probe()

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

>From 57c624ae1c0aa631f11768992a74998c531a7fee Mon Sep 17 00:00:00 2001
From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
Date: Mon, 13 Jun 2016 14:32:23 +0000
Subject: [PATCH] spi: orion: Fix return value check in orion_spi_probe()

In case of error, the function devm_ioremap() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check should
be replaced with NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-orion.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index d0d9c8682b32..ded37025b445 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -655,8 +655,8 @@ static int orion_spi_probe(struct platform_device *pdev)
 		spi->direct_access[cs].vaddr = devm_ioremap(&pdev->dev,
 							    r->start,
 							    PAGE_SIZE);
-		if (IS_ERR(spi->direct_access[cs].vaddr)) {
-			status = PTR_ERR(spi->direct_access[cs].vaddr);
+		if (!spi->direct_access[cs].vaddr) {
+			status = -ENOMEM;
 			goto out_rel_clk;
 		}
 		spi->direct_access[cs].size = PAGE_SIZE;
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
