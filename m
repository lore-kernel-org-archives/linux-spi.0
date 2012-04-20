From: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 2/4] spi: bcm63xx: don't use the stopping state
Date: Fri, 20 Apr 2012 15:37:34 +0200
Message-ID: <1334929056-1598-3-git-send-email-florian@openwrt.org>
References: <1334929056-1598-1-git-send-email-florian@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1334929056-1598-1-git-send-email-florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

We do not need to use a flag to indicate if the master driver is stopping
it is sufficient to perform spi master unregistering in the platform
driver's remove function.

Signed-off-by: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
 drivers/spi/spi-bcm63xx.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 63b0028..80e5ed3 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -39,8 +39,6 @@
 #define DRV_VER		"0.1.2"
 
 struct bcm63xx_spi {
-	spinlock_t		lock;
-	int			stopping;
 	struct completion	done;
 
 	void __iomem		*regs;
@@ -161,9 +159,6 @@ static int bcm63xx_spi_setup(struct spi_device *spi)
 
 	bs = spi_master_get_devdata(spi->master);
 
-	if (bs->stopping)
-		return -ESHUTDOWN;
-
 	if (!spi->bits_per_word)
 		spi->bits_per_word = 8;
 
@@ -410,10 +405,8 @@ static int __devinit bcm63xx_spi_probe(struct platform_device *pdev)
 	master->unprepare_transfer_hardware = bcm63xx_spi_unprepare_transfer;
 	master->transfer_one_message = bcm63xx_spi_transfer_one;
 	bs->speed_hz = pdata->speed_hz;
-	bs->stopping = 0;
 	bs->tx_io = (u8 *)(bs->regs + bcm63xx_spireg(SPI_MSG_DATA));
 	bs->rx_io = (const u8 *)(bs->regs + bcm63xx_spireg(SPI_RX_DATA));
-	spin_lock_init(&bs->lock);
 
 	/* Initialize hardware */
 	clk_enable(bs->clk);
@@ -447,18 +440,16 @@ static int __devexit bcm63xx_spi_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct bcm63xx_spi *bs = spi_master_get_devdata(master);
 
+	spi_unregister_master(master);
+
 	/* reset spi block */
 	bcm_spi_writeb(bs, 0, SPI_INT_MASK);
-	spin_lock(&bs->lock);
-	bs->stopping = 1;
 
 	/* HW shutdown */
 	clk_disable(bs->clk);
 	clk_put(bs->clk);
 
-	spin_unlock(&bs->lock);
 	platform_set_drvdata(pdev, 0);
-	spi_unregister_master(master);
 
 	return 0;
 }
-- 
1.7.5.4


------------------------------------------------------------------------------
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2
