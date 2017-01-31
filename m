From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: When no dma_chan map buffers with spi_master's parent"
 to the spi tree
Date: Tue, 31 Jan 2017 20:02:55 +0000
Message-ID: <E1cYedj-0005mM-9E@debutante>
References: <20170126162154.124287-1-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: , drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
 Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "moderated list:ARM/Mediatek SoC,
 support" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
 dtor-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, "moderated list:ARM/Mediatek SoC,
 support" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20170126162154.124287-1-djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: When no dma_chan map buffers with spi_master's parent

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

>From 88b0aa544af58ce3be125a1845a227264ec9ab89 Mon Sep 17 00:00:00 2001
From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Date: Fri, 27 Jan 2017 00:21:53 +0800
Subject: [PATCH] spi: When no dma_chan map buffers with spi_master's parent

Back before commit 1dccb598df54 ("arm64: simplify dma_get_ops"), for
arm64, devices for which dma_ops were not explicitly set were automatically
configured to use swiotlb_dma_ops, since this was hard-coded as the
global "dma_ops" in arm64_dma_init().

Now that global "dma_ops" has been removed, all devices much have their
dma_ops explicitly set by a call to arch_setup_dma_ops(), otherwise the
device is assigned dummy_dma_ops, and thus calls to map_sg for such a
device will fail (return 0).

Mediatek SPI uses DMA but does not use a dma channel.  Support for this
was added by commit c37f45b5f1cd ("spi: support spi without dma channel
to use can_dma()"), which uses the master_spi dev to DMA map buffers.

The master_spi device is not a platform device, rather it is created
in spi_alloc_device(), and therefore its dma_ops are never set.

Therefore, when the mediatek SPI driver when it does DMA (for large SPI
transactions > 32 bytes), SPI will use spi_map_buf()->dma_map_sg() to
map the buffer for use in DMA.  But dma_map_sg()->dma_map_sg_attrs() returns
0, because ops->map_sg is dummy_dma_ops->__dummy_map_sg, and hence
spi_map_buf() returns -ENOMEM (-12).

Fix this by using the real spi_master's parent device which should be a
real physical device with DMA properties.

Signed-off-by: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Fixes: c37f45b5f1cd ("spi: support spi without dma channel to use can_dma()")
Cc: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 656dd3e3220c..f4d412e48e1c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -805,12 +805,12 @@ static int __spi_map_msg(struct spi_master *master, struct spi_message *msg)
 	if (master->dma_tx)
 		tx_dev = master->dma_tx->device->dev;
 	else
-		tx_dev = &master->dev;
+		tx_dev = master->dev.parent;
 
 	if (master->dma_rx)
 		rx_dev = master->dma_rx->device->dev;
 	else
-		rx_dev = &master->dev;
+		rx_dev = master->dev.parent;
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		if (!master->can_dma(master, msg->spi, xfer))
@@ -852,12 +852,12 @@ static int __spi_unmap_msg(struct spi_master *master, struct spi_message *msg)
 	if (master->dma_tx)
 		tx_dev = master->dma_tx->device->dev;
 	else
-		tx_dev = &master->dev;
+		tx_dev = master->dev.parent;
 
 	if (master->dma_rx)
 		rx_dev = master->dma_rx->device->dev;
 	else
-		rx_dev = &master->dev;
+		rx_dev = master->dev.parent;
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		if (!master->can_dma(master, msg->spi, xfer))
-- 
2.11.0
