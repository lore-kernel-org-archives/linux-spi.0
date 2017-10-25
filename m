From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi: sprd: Fix the possible negative value of BIT()
Date: Wed, 25 Oct 2017 19:25:09 +0800
Message-ID: <501d5362189cd3ec99e52082827f5d40a220cc3d.1508930323.git.baolin.wang@linaro.org>
Cc: dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

When enabling the ADI hardware channels, if the channel id is 31,
then we will get one negative value -1 for BIT() macro, which will
write incorrect value to register.

Fixes: 7e2903cb91df ("spi: Add ADI driver for Spreadtrum platform")
Reported-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-sprd-adi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 6a5ff30..5993bdb 100644
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
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
