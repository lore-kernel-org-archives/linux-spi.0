From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: respect the maximum segment size of DMA device" to the spi tree
Date: Thu, 10 Mar 2016 10:39:31 +0700
Message-ID: <E1adrRj-0007dJ-Tj@finisterre>
References: <1457515200-111327-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457515200-111327-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: respect the maximum segment size of DMA device

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

>From df88e91bbfd16662f3c8dcba27ad19e9eb4ebcef Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Wed, 9 Mar 2016 11:20:00 +0200
Subject: [PATCH] spi: respect the maximum segment size of DMA device

The device which is actually does DMA may have a limitation of the maximum
segment size. Respect this setting when preparing scatter-gather list.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 47eff8012a77..9e6480a2e869 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -702,6 +702,7 @@ static int spi_map_buf(struct spi_master *master, struct device *dev,
 		       enum dma_data_direction dir)
 {
 	const bool vmalloced_buf = is_vmalloc_addr(buf);
+	unsigned int max_seg_size = dma_get_max_seg_size(dev);
 	int desc_len;
 	int sgs;
 	struct page *vm_page;
@@ -710,10 +711,10 @@ static int spi_map_buf(struct spi_master *master, struct device *dev,
 	int i, ret;
 
 	if (vmalloced_buf) {
-		desc_len = PAGE_SIZE;
+		desc_len = min_t(int, max_seg_size, PAGE_SIZE);
 		sgs = DIV_ROUND_UP(len + offset_in_page(buf), desc_len);
 	} else {
-		desc_len = master->max_dma_len;
+		desc_len = min_t(int, max_seg_size, master->max_dma_len);
 		sgs = DIV_ROUND_UP(len, desc_len);
 	}
 
@@ -739,7 +740,6 @@ static int spi_map_buf(struct spi_master *master, struct device *dev,
 			sg_set_buf(&sgt->sgl[i], sg_buf, min);
 		}
 
-
 		buf += min;
 		len -= min;
 	}
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
