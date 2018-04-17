From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 4/8] spi: spi-s3c64xx: Drop unused enable_datapath()
 function argument
Date: Tue, 17 Apr 2018 16:29:50 +0200
Message-ID: <20180417142954.5507-4-s.nawrocki@samsung.com>
References: <20180417142954.5507-1-s.nawrocki@samsung.com>
 <CGME20180417143039epcas2p39e2c730d107c94e5f9bf104d3a938f90@epcas2p3.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc@vger.kernel.org,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, b.zolnierkie@samsung.com,
 krzk@kernel.org, linux-spi@vger.kernel.org, kgene@kernel.org, andi@etezian.org,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
To: broonie@kernel.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20180417142954.5507-1-s.nawrocki@samsung.com>
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

The spi pointer argument is not used now so remove it.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 4c27426bcb40..5d94915c2738 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -349,8 +349,7 @@ static bool s3c64xx_spi_can_dma(struct spi_master *master,
 }
 
 static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
-				struct spi_device *spi,
-				struct spi_transfer *xfer, int dma_mode)
+			    struct spi_transfer *xfer, int dma_mode)
 {
 	void __iomem *regs = sdd->regs;
 	u32 modecfg, chcfg;
@@ -667,7 +666,7 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 	sdd->state &= ~RXBUSY;
 	sdd->state &= ~TXBUSY;
 
-	enable_datapath(sdd, spi, xfer, use_dma);
+	enable_datapath(sdd, xfer, use_dma);
 
 	/* Start the signals */
 	s3c64xx_spi_set_cs(spi, true);
-- 
2.14.2
