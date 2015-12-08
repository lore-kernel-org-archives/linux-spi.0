From: Anton Bondarenko <anton.bondarenko.sama@gmail.com>
Subject: [PATCH v6 4/8] spi: imx: defer spi initialization, if DMA engine is
Date: Tue,  8 Dec 2015 07:43:46 +0100
Message-ID: <1449557030-27525-5-git-send-email-anton.bondarenko.sama@gmail.com>
References: <1449557030-27525-1-git-send-email-anton.bondarenko.sama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: jiada_wang@mentor.com, vladimir_zapolskiy@mentor.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
To: broonie@kernel.org,
	b38343@freescale.com,
	s.hauer@pengutronix.de
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449557030-27525-1-git-send-email-anton.bondarenko.sama@gmail.com>
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

Signed-off-by: Anton Bondarenko <anton.bondarenko.sama@gmail.com>
---
 drivers/spi/spi-imx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index c123060..d98c33c 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1222,6 +1222,9 @@ static int spi_imx_probe(struct platform_device *pdev)
 	 */
 	if (is_imx51_ecspi(spi_imx)) {
 		ret = spi_imx_sdma_init(&pdev->dev, spi_imx, master, res);
+		if (ret == -EPROBE_DEFER)
+			goto out_clk_put;
+
 		if (ret < 0)
 			dev_err(&pdev->dev, "dma setup error %d, use pio\n",
 				ret);
-- 
2.6.3
