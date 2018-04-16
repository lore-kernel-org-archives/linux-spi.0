From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 2/6] spi: spi-s3c64xx: Remove unused s3c64xx_spi_hwinit()
 function argument
Date: Mon, 16 Apr 2018 17:40:17 +0200
Message-ID: <20180416154021.25626-2-s.nawrocki@samsung.com>
References: <20180416154021.25626-1-s.nawrocki@samsung.com>
 <CGME20180416154109epcas2p1696b9cdc72403fe5abdd0a2117067c8d@epcas2p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc@vger.kernel.org,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, b.zolnierkie@samsung.com,
 krzk@kernel.org, linux-spi@vger.kernel.org, kgene@kernel.org, andi@etezian.org,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
To: broonie@kernel.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20180416154021.25626-1-s.nawrocki@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

The channel argument is not used and anyway it could be retrieved from
the passed driver data structure.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index f7ca7ed33e1e..b7333a883442 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -889,7 +889,7 @@ static irqreturn_t s3c64xx_spi_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd, int channel)
+static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd)
 {
 	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	void __iomem *regs = sdd->regs;
@@ -1143,7 +1143,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	pm_runtime_get_sync(&pdev->dev);
 
 	/* Setup Deufult Mode */
-	s3c64xx_spi_hwinit(sdd, sdd->port_id);
+	s3c64xx_spi_hwinit(sdd);
 
 	spin_lock_init(&sdd->lock);
 	init_completion(&sdd->xfer_completion);
@@ -1258,7 +1258,7 @@ static int s3c64xx_spi_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	s3c64xx_spi_hwinit(sdd, sdd->port_id);
+	s3c64xx_spi_hwinit(sdd);
 
 	return spi_master_resume(master);
 }
-- 
2.14.2
