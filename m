From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Guarantee cacheline alignment of driver-private data"
 to the spi tree
Date: Wed, 11 Sep 2019 15:59:52 +0100 (BST)
Message-ID: <20190911145952.2D94CD00486@fitzroy.sirena.org.uk>
References: <01625b9b26b93417fb09d2c15ad02dfe9cdbbbe5.1568187525.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
 linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <01625b9b26b93417fb09d2c15ad02dfe9cdbbbe5.1568187525.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: Guarantee cacheline alignment of driver-private data

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

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

>From 229e6af102e407feada76d3c270395d7cda2cdfe Mon Sep 17 00:00:00 2001
From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Date: Wed, 11 Sep 2019 12:15:30 +0200
Subject: [PATCH] spi: Guarantee cacheline alignment of driver-private data

__spi_alloc_controller() uses a single allocation to accommodate struct
spi_controller and the driver-private data, but places the latter behind
the former.  This order does not guarantee cacheline alignment of the
driver-private data.  (It does guarantee cacheline alignment of struct
spi_controller but the structure doesn't make any use of that property.)

Round up struct spi_controller to cacheline size.  A forthcoming commit
leverages this to grant DMA access to driver-private data of the BCM2835
SPI master.

An alternative, less economical approach would be to use two allocations.

A third approach consists of reversing the order to conserve memory.
But Mark Brown is concerned that it may result in a performance penalty
on architectures that don't like unaligned accesses.

Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Link: https://lore.kernel.org/r/01625b9b26b93417fb09d2c15ad02dfe9cdbbbe5.1568187525.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b2890923d256..f8b4654a57d3 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2188,8 +2188,10 @@ extern struct class spi_slave_class;	/* dummy */
  * __spi_alloc_controller - allocate an SPI master or slave controller
  * @dev: the controller, possibly using the platform_bus
  * @size: how much zeroed driver-private data to allocate; the pointer to this
- *	memory is in the driver_data field of the returned device,
- *	accessible with spi_controller_get_devdata().
+ *	memory is in the driver_data field of the returned device, accessible
+ *	with spi_controller_get_devdata(); the memory is cacheline aligned;
+ *	drivers granting DMA access to portions of their private data need to
+ *	round up @size using ALIGN(size, dma_get_cache_alignment()).
  * @slave: flag indicating whether to allocate an SPI master (false) or SPI
  *	slave (true) controller
  * Context: can sleep
@@ -2211,11 +2213,12 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 					      unsigned int size, bool slave)
 {
 	struct spi_controller	*ctlr;
+	size_t ctlr_size = ALIGN(sizeof(*ctlr), dma_get_cache_alignment());
 
 	if (!dev)
 		return NULL;
 
-	ctlr = kzalloc(size + sizeof(*ctlr), GFP_KERNEL);
+	ctlr = kzalloc(size + ctlr_size, GFP_KERNEL);
 	if (!ctlr)
 		return NULL;
 
@@ -2229,7 +2232,7 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 		ctlr->dev.class = &spi_master_class;
 	ctlr->dev.parent = dev;
 	pm_suspend_ignore_children(&ctlr->dev, true);
-	spi_controller_set_devdata(ctlr, &ctlr[1]);
+	spi_controller_set_devdata(ctlr, (void *)ctlr + ctlr_size);
 
 	return ctlr;
 }
-- 
2.20.1
