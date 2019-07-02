From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: atmel-quadspi: void return type for atmel_qspi_init()"
 to the spi tree
Date: Tue,  2 Jul 2019 14:04:54 +0100 (BST)
Message-ID: <20190702130454.BCAC644004B@finisterre.sirena.org.uk>
References: <20190628153009.7571-2-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: alexandre.belloni@bootlin.com, Tudor.Ambarus@microchip.com,
 mdeneen@gmail.com, linux-spi@vger.kernel.org, Ludovic.Desroches@microchip.com,
 Mark Brown <broonie@kernel.org>, Claudiu.Beznea@microchip.com,
 linux-arm-kernel@lists.infradead.org
To: Tudor Ambarus <tudor.ambarus@microchip.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190628153009.7571-2-tudor.ambarus@microchip.com>
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

The patch

   spi: atmel-quadspi: void return type for atmel_qspi_init()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

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

>From 5b74e9a306267be3b371b309faef8626b18e6423 Mon Sep 17 00:00:00 2001
From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Fri, 28 Jun 2019 15:30:32 +0000
Subject: [PATCH] spi: atmel-quadspi: void return type for atmel_qspi_init()

commit 2d30ac5ed633 ("mtd: spi-nor: atmel-quadspi: Use spi-mem interface for atmel-quadspi driver")
removed the error path from atmel_qspi_init(), but not changed the
function's return type. Set void return type for atmel_qspi_init().

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1
