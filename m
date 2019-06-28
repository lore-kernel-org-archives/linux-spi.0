From: <Tudor.Ambarus@microchip.com>
Subject: [PATCH 2/2] spi: atmel-quadspi: fix resume call
Date: Fri, 28 Jun 2019 15:30:34 +0000
Message-ID: <20190628153009.7571-3-tudor.ambarus@microchip.com>
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

When waking up from the Suspend-to-RAM state, the following error
was seen:

m25p80 spi2.0: flash operation timed out

The flash remained in an undefined state, returning 0xFFs.
Fix it by setting the Serial Clock Baud Rate, as it was set
before the conversion to SPIMEM.

Tested with sama5d2_xplained and mx25l25673g spi-nor in
Backup + Self-Refresh and Suspend modes.

Fixes: 0e6aae08e9ae ("spi: Add QuadSPI driver for Atmel SAMA5D2")
Reported-by: Mark Deneen <mdeneen@gmail.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/atmel-quadspi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 32eb7447c31a..6a7d7b553d95 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -151,6 +151,7 @@ struct atmel_qspi {
 	const struct atmel_qspi_caps *caps;
 	u32			pending;
 	u32			mr;
+	u32			scr;
 	struct completion	cmd_completion;
 };
 
@@ -382,7 +383,7 @@ static int atmel_qspi_setup(struct spi_device *spi)
 	struct spi_controller *ctrl = spi->master;
 	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
 	unsigned long src_rate;
-	u32 scr, scbr;
+	u32 scbr;
 
 	if (ctrl->busy)
 		return -EBUSY;
@@ -399,8 +400,8 @@ static int atmel_qspi_setup(struct spi_device *spi)
 	if (scbr > 0)
 		scbr--;
 
-	scr = QSPI_SCR_SCBR(scbr);
-	writel_relaxed(scr, aq->regs + QSPI_SCR);
+	aq->scr = QSPI_SCR_SCBR(scbr);
+	writel_relaxed(aq->scr, aq->regs + QSPI_SCR);
 
 	return 0;
 }
@@ -584,6 +585,9 @@ static int __maybe_unused atmel_qspi_resume(struct device *dev)
 	clk_prepare_enable(aq->qspick);
 
 	atmel_qspi_init(aq);
+
+	writel_relaxed(aq->scr, aq->regs + QSPI_SCR);
+
 	return 0;
 }
 
-- 
2.9.5
