From: <Tudor.Ambarus@microchip.com>
Subject: [PATCH 1/2] spi: atmel-quadspi: void return type for atmel_qspi_init()
Date: Fri, 28 Jun 2019 15:30:32 +0000
Message-ID: <20190628153009.7571-2-tudor.ambarus@microchip.com>
References: <20190628153009.7571-1-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: alexandre.belloni@bootlin.com, Tudor.Ambarus@microchip.com,
 linux-spi@vger.kernel.org, Ludovic.Desroches@microchip.com,
 Claudiu.Beznea@microchip.com, linux-arm-kernel@lists.infradead.org
To: <broonie@kernel.org>, <mdeneen@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190628153009.7571-1-tudor.ambarus@microchip.com>
Content-Language: en-US
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

From: Tudor Ambarus <tudor.ambarus@microchip.com>

commit 2d30ac5ed633 ("mtd: spi-nor: atmel-quadspi: Use spi-mem interface for atmel-quadspi driver")
removed the error path from atmel_qspi_init(), but not changed the
function's return type. Set void return type for atmel_qspi_init().

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/atmel-quadspi.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 9f24d5f0b431..32eb7447c31a 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -405,7 +405,7 @@ static int atmel_qspi_setup(struct spi_device *spi)
 	return 0;
 }
 
-static int atmel_qspi_init(struct atmel_qspi *aq)
+static void atmel_qspi_init(struct atmel_qspi *aq)
 {
 	/* Reset the QSPI controller */
 	writel_relaxed(QSPI_CR_SWRST, aq->regs + QSPI_CR);
@@ -416,8 +416,6 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
 
 	/* Enable the QSPI controller */
 	writel_relaxed(QSPI_CR_QSPIEN, aq->regs + QSPI_CR);
-
-	return 0;
 }
 
 static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
@@ -536,9 +534,7 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	if (err)
 		goto disable_qspick;
 
-	err = atmel_qspi_init(aq);
-	if (err)
-		goto disable_qspick;
+	atmel_qspi_init(aq);
 
 	err = spi_register_controller(ctrl);
 	if (err)
@@ -587,7 +583,8 @@ static int __maybe_unused atmel_qspi_resume(struct device *dev)
 	clk_prepare_enable(aq->pclk);
 	clk_prepare_enable(aq->qspick);
 
-	return atmel_qspi_init(aq);
+	atmel_qspi_init(aq);
+	return 0;
 }
 
 static SIMPLE_DEV_PM_OPS(atmel_qspi_pm_ops, atmel_qspi_suspend,
-- 
2.9.5
