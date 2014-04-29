From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 4/7] spi: s3c64xx: remove unnecessary OOM messages
Date: Tue, 29 Apr 2014 17:20:20 +0900
Message-ID: <002801cf6383$dca4b0c0$95ee1240$%han@samsung.com>
References: <002401cf6383$7e9ce1f0$7bd6a5d0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <002401cf6383$7e9ce1f0$7bd6a5d0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-s3c64xx.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 153b4be..75a5696 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -772,7 +772,6 @@ static struct s3c64xx_spi_csinfo *s3c64xx_get_slave_ctrldata(
 
 	cs = kzalloc(sizeof(*cs), GFP_KERNEL);
 	if (!cs) {
-		dev_err(&spi->dev, "could not allocate memory for controller data\n");
 		of_node_put(data_np);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -986,10 +985,8 @@ static struct s3c64xx_spi_info *s3c64xx_spi_parse_dt(struct device *dev)
 	u32 temp;
 
 	sci = devm_kzalloc(dev, sizeof(*sci), GFP_KERNEL);
-	if (!sci) {
-		dev_err(dev, "memory allocation for spi_info failed\n");
+	if (!sci)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	if (of_property_read_u32(dev->of_node, "samsung,spi-src-clk", &temp)) {
 		dev_warn(dev, "spi bus clock parent not specified, using clock at index 0 as parent\n");
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
