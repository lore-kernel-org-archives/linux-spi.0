From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Remove rx_/tx_map_len members from struct driver_data" to the spi tree
Date: Tue, 29 Mar 2016 00:42:23 -0700
Message-ID: <E1akoIB-0007qo-S5@finisterre>
References: <1458746964-9335-2-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458746964-9335-2-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Remove rx_/tx_map_len members from struct driver_data

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

>From 68335ec76e45fb3a1b796b26c3ea49ce1231d8fb Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Thu, 24 Mar 2016 15:35:43 +0200
Subject: [PATCH] spi: pxa2xx: Remove rx_/tx_map_len members from struct
 driver_data

spi-pxa2xx-dma.c DMA engine implementation stopped using PIO for
unaligned trailing bytes in the commit 111e0a9dc71e ("spi/pxa2xx: Prevent
DMA from transferring too many bytes"). This means there is no need to
update tx/rx transfer buffer pointers after DMA completion. These buffer
pointers will be set to new buffers when handling the next transfer.

Because this buffer pointer update was only remaining use for rx_map_len
and tx_map_len members in struct driver_data after removing the legacy PXA
DMA implementation they can be removed now.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Acked-by: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx-dma.c | 5 -----
 drivers/spi/spi-pxa2xx.h     | 2 --
 2 files changed, 7 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index b1883d228103..624cb06bd2e1 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -33,12 +33,10 @@ static int pxa2xx_spi_map_dma_buffer(struct driver_data *drv_data,
 		dmadev = drv_data->tx_chan->device->dev;
 		sgt = &drv_data->tx_sgt;
 		buf = drv_data->tx;
-		drv_data->tx_map_len = len;
 	} else {
 		dmadev = drv_data->rx_chan->device->dev;
 		sgt = &drv_data->rx_sgt;
 		buf = drv_data->rx;
-		drv_data->rx_map_len = len;
 	}
 
 	nents = DIV_ROUND_UP(len, SZ_2K);
@@ -133,9 +131,6 @@ static void pxa2xx_spi_dma_transfer_complete(struct driver_data *drv_data,
 		if (!error) {
 			pxa2xx_spi_unmap_dma_buffers(drv_data);
 
-			drv_data->tx += drv_data->tx_map_len;
-			drv_data->rx += drv_data->rx_map_len;
-
 			msg->actual_length += drv_data->len;
 			msg->state = pxa2xx_spi_next_transfer(drv_data);
 		} else {
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index a1ef88948144..85017f9ca67c 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -69,8 +69,6 @@ struct driver_data {
 	void *rx;
 	void *rx_end;
 	int dma_mapped;
-	size_t rx_map_len;
-	size_t tx_map_len;
 	u8 n_bytes;
 	int (*write)(struct driver_data *drv_data);
 	int (*read)(struct driver_data *drv_data);
-- 
2.8.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
