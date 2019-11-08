From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: zynq-qspi: Keep the naming consistent across the
 driver" to the spi tree
Date: Fri,  8 Nov 2019 12:08:00 +0000 (GMT)
Message-ID: <20191108120800.88C022740C6C@ypsilon.sirena.org.uk>
References: <20191108105920.19014-3-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>,
 Michal Simek <michal.simek@xilinx.com>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191108105920.19014-3-miquel.raynal@bootlin.com>
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

   spi: zynq-qspi: Keep the naming consistent across the driver

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

>From 9b10fa363baf3a506b089f3df3a5afd5e2f244db Mon Sep 17 00:00:00 2001
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 8 Nov 2019 11:59:15 +0100
Subject: [PATCH] spi: zynq-qspi: Keep the naming consistent across the driver

In this driver (and also in a lot of other drivers in drivers/spi/),
the spi_controller structure is sometimes referred as 'ctlr' and
sometimes as 'ctrl'. Grepping there shows that 'ctlr' seems to be more
common so keep the naming consistent in this driver and s/ctrl/ctlr/.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/r/20191108105920.19014-3-miquel.raynal@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-zynq-qspi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 8786054f4869..b1c56e9d7c94 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -283,8 +283,8 @@ static void zynq_qspi_txfifo_op(struct zynq_qspi *xqspi, unsigned int size)
  */
 static void zynq_qspi_chipselect(struct spi_device *spi, bool assert)
 {
-	struct spi_controller *ctrl = spi->master;
-	struct zynq_qspi *xqspi = spi_controller_get_devdata(ctrl);
+	struct spi_controller *ctlr = spi->master;
+	struct zynq_qspi *xqspi = spi_controller_get_devdata(ctlr);
 	u32 config_reg;
 
 	config_reg = zynq_qspi_read(xqspi, ZYNQ_QSPI_CONFIG_OFFSET);
@@ -364,10 +364,10 @@ static int zynq_qspi_config_op(struct zynq_qspi *xqspi, struct spi_device *spi)
  */
 static int zynq_qspi_setup_op(struct spi_device *spi)
 {
-	struct spi_controller *ctrl = spi->master;
-	struct zynq_qspi *qspi = spi_controller_get_devdata(ctrl);
+	struct spi_controller *ctlr = spi->master;
+	struct zynq_qspi *qspi = spi_controller_get_devdata(ctlr);
 
-	if (ctrl->busy)
+	if (ctlr->busy)
 		return -EBUSY;
 
 	clk_enable(qspi->refclk);
-- 
2.20.1
