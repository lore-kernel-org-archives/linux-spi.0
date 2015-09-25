From: Anton Bondarenko <anton_bondarenko@mentor.com>
Subject: [PATCH v2 7/8] spi: imx: defer spi initialization,
 if DMA engine is pending
Date: Fri, 25 Sep 2015 19:57:14 +0200
Message-ID: <42b82309e539e8a5523dca5364846c472ab9dcee.1442923630.git.anton_bondarenko@mentor.com>
References: <cover.1442923630.git.anton_bondarenko@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: muzaffar_mahmood@relay1.mentorg.com, jiada_wang@mentor.com,
 b38343@freescale.com, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, vladimir_zapolskiy@mentor.com
To: <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1442923630.git.anton_bondarenko@mentor.com>
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

If SPI device supports DMA mode, but DMA controller is not yet
available due to e.g. a delay in the corresponding kernel module
initialization, retry to initialize SPI driver later on instead of
falling back into PIO only mode.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Signed-off-by: Anton Bondarenko <anton_bondarenko@mentor.com>
---
 drivers/spi/spi-imx.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 44d3cf0..1bf0739a 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1343,9 +1343,15 @@ static int spi_imx_probe(struct platform_device *pdev)
 	 * Only validated on i.mx6 now, can remove the constrain if validated on
 	 * other chips.
 	 */
-	if (is_imx5x_ecspi(spi_imx) &&
-	    spi_imx_sdma_init(&pdev->dev, spi_imx, master))
-		dev_err(&pdev->dev, "dma setup error,use pio instead\n");
+	if (is_imx5x_ecspi(spi_imx)) {
+		ret = spi_imx_sdma_init(&pdev->dev, spi_imx, master);
+		if (ret == -EPROBE_DEFER)
+			goto out_clk_put;
+
+		if (ret < 0)
+			dev_err(&pdev->dev, "dma setup error %d, use pio\n",
+				ret);
+	}
 
 	spi_imx->devtype_data->reset(spi_imx);
 
-- 
2.5.2
