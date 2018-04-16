From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 3/6] spi: spi-s3c64xx: Drop unused enable_datapath()
 function argument
Date: Mon, 16 Apr 2018 17:40:18 +0200
Message-ID: <20180416154021.25626-3-s.nawrocki@samsung.com>
References: <20180416154021.25626-1-s.nawrocki@samsung.com>
 <CGME20180416154122epcas1p1ae714af12f8da08783c47fcd820c40e7@epcas1p1.samsung.com>
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

The spi pointer argument is not used now so remove it. While at it
s3c64xx_ prefix is added to the function name.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index b7333a883442..e90e60bc1ecc 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -348,9 +348,8 @@ static bool s3c64xx_spi_can_dma(struct spi_master *master,
 	return xfer->len > (FIFO_LVL_MASK(sdd) >> 1) + 1;
 }

-static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
-				struct spi_device *spi,
-				struct spi_transfer *xfer, int dma_mode)
+static void s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
+				    struct spi_transfer *xfer, int dma_mode)
 {
 	void __iomem *regs = sdd->regs;
 	u32 modecfg, chcfg;
@@ -665,7 +664,7 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 	sdd->state &= ~RXBUSY;
 	sdd->state &= ~TXBUSY;

-	enable_datapath(sdd, spi, xfer, use_dma);
+	s3c64xx_enable_datapath(sdd, xfer, use_dma);

 	/* Start the signals */
 	s3c64xx_spi_set_cs(spi, true);
--
2.14.2
