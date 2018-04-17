From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 2/8] spi: spi-s3c64xx: Remove unused driver data
 structure tgl_spi field
Date: Tue, 17 Apr 2018 16:29:48 +0200
Message-ID: <20180417142954.5507-2-s.nawrocki@samsung.com>
References: <20180417142954.5507-1-s.nawrocki@samsung.com>
 <CGME20180417143028epcas1p459b6358287256a1c060ea95847ce9fbd@epcas1p4.samsung.com>
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

The tgl_spi pointer is now unused so remove it.

Reviewed-by: Andi Shyti <andi@etezian.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 9a990bc3138a..f0e28adbbc32 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -156,7 +156,6 @@ struct s3c64xx_spi_port_config {
  * @ioclk: Pointer to the i/o clock between master and slave
  * @master: Pointer to the SPI Protocol master.
  * @cntrlr_info: Platform specific data for the controller this driver manages.
- * @tgl_spi: Pointer to the last CS left untoggled by the cs_change hint.
  * @lock: Controller specific lock.
  * @state: Set of FLAGS to indicate status.
  * @rx_dmach: Controller's DMA channel for Rx.
@@ -177,7 +176,6 @@ struct s3c64xx_spi_driver_data {
 	struct platform_device          *pdev;
 	struct spi_master               *master;
 	struct s3c64xx_spi_info  *cntrlr_info;
-	struct spi_device               *tgl_spi;
 	spinlock_t                      lock;
 	unsigned long                   sfr_start;
 	struct completion               xfer_completion;
-- 
2.14.2
