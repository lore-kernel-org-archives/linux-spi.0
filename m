From: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 3/4] spi/rockchip: master->mode_bits: remove SPI_CS_HIGH bit
Date: Fri, 11 Jul 2014 10:08:51 +0800
Message-ID: <1405044531-6963-1-git-send-email-addy.ke@rock-chips.com>
References: <1405044389-6800-1-git-send-email-addy.ke@rock-chips.com>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	wei.luo-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Addy Ke <addy.ke-JkTZp4/KTbpWk0Htik3J/w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1405044389-6800-1-git-send-email-addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Addy Ke <addy.ke-JkTZp4/KTbpWk0Htik3J/w@public.gmane.org>

Suggested-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Signed-off-by: Addy Ke <addy.ke-JkTZp4/KTbpWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/spi-rockchip.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 09c690c..a8866c9 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -295,11 +295,6 @@ static int rockchip_spi_prepare_message(struct spi_master *master,
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
 	struct spi_device *spi = msg->spi;
 
-	if (spi->mode & SPI_CS_HIGH) {
-		dev_err(rs->dev, "spi_cs_hign: not support\n");
-		return -EINVAL;
-	}
-
 	rs->mode = spi->mode;
 
 	return 0;
@@ -657,7 +652,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 
 	master->auto_runtime_pm = true;
 	master->bus_num = pdev->id;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
 	master->num_chipselect = 2;
 	master->dev.of_node = pdev->dev.of_node;
 	master->bits_per_word_mask = SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
-- 
1.8.3.2


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
