From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: sprd: Fix the possible negative value of BIT()" to the spi tree
Date: Wed, 25 Oct 2017 13:03:30 +0100 (BST)
Message-ID: <20171025120330.A722A44005B@finisterre.ee.mobilebroadband>
References: <501d5362189cd3ec99e52082827f5d40a220cc3d.1508930323.git.baolin.wang@linaro.org>
Cc: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <501d5362189cd3ec99e52082827f5d40a220cc3d.1508930323.git.baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: sprd: Fix the possible negative value of BIT()

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

>From 54e2fc28d9cf1be7dd2ebe74b20dc20cc2a3e55d Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Date: Wed, 25 Oct 2017 19:25:09 +0800
Subject: [PATCH] spi: sprd: Fix the possible negative value of BIT()

When enabling the ADI hardware channels, if the channel id is 31,
then we will get one negative value -1 for BIT() macro, which will
write incorrect value to register.

Fixes: 7e2903cb91df ("spi: Add ADI driver for Spreadtrum platform")
Reported-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-sprd-adi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 6a5ff3003044..5993bdbf79e4 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -303,7 +303,7 @@ static void sprd_adi_hw_init(struct sprd_adi *sadi)
 		writel_relaxed(chn_config, sadi->base +
 			       REG_ADI_CHN_ADDR(chn_id));
 
-		if (chn_id < 31) {
+		if (chn_id < 32) {
 			value = readl_relaxed(sadi->base + REG_ADI_CHN_EN);
 			value |= BIT(chn_id);
 			writel_relaxed(value, sadi->base + REG_ADI_CHN_EN);
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
