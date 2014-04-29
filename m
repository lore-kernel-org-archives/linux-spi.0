From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/7] spi: pl022: remove unnecessary OOM messages
Date: Tue, 29 Apr 2014 17:19:01 +0900
Message-ID: <002501cf6383$ad1ae400$0750ac00$%han@samsung.com>
References: <002401cf6383$7e9ce1f0$7bd6a5d0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Ulf Hansson' <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	'Linus Walleij' <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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
 drivers/spi/spi-pl022.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 51d9977..66d2ae2 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1111,10 +1111,8 @@ static int pl022_dma_probe(struct pl022 *pl022)
 	}
 
 	pl022->dummypage = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!pl022->dummypage) {
-		dev_dbg(&pl022->adev->dev, "no DMA dummypage!\n");
+	if (!pl022->dummypage)
 		goto err_no_dummypage;
-	}
 
 	dev_info(&pl022->adev->dev, "setup for DMA on RX %s, TX %s\n",
 		 dma_chan_name(pl022->dma_rx_channel),
@@ -1809,11 +1807,8 @@ static int pl022_setup(struct spi_device *spi)
 
 	if (chip == NULL) {
 		chip = kzalloc(sizeof(struct chip_data), GFP_KERNEL);
-		if (!chip) {
-			dev_err(&spi->dev,
-				"cannot allocate controller state\n");
+		if (!chip)
 			return -ENOMEM;
-		}
 		dev_dbg(&spi->dev,
 			"allocated memory for controller's runtime state\n");
 	}
@@ -2050,10 +2045,8 @@ pl022_platform_data_dt_get(struct device *dev)
 	}
 
 	pd = devm_kzalloc(dev, sizeof(struct pl022_ssp_controller), GFP_KERNEL);
-	if (!pd) {
-		dev_err(dev, "cannot allocate platform data memory\n");
+	if (!pd)
 		return NULL;
-	}
 
 	pd->bus_id = -1;
 	pd->enable_dma = 1;
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
