From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: zynq-qspi: Anything else than CS0 is not supported yet"
 to the spi tree
Date: Fri,  8 Nov 2019 17:45:44 +0000 (GMT)
Message-ID: <20191108174544.3BA1A2741460@ypsilon.sirena.org.uk>
References: <20191108140744.1734-2-miquel.raynal@bootlin.com>
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
In-Reply-To: <20191108140744.1734-2-miquel.raynal@bootlin.com>
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

   spi: zynq-qspi: Anything else than CS0 is not supported yet

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

>From 087622d09472f96f1f5d6ced36ca75c92e86af21 Mon Sep 17 00:00:00 2001
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 8 Nov 2019 15:07:38 +0100
Subject: [PATCH] spi: zynq-qspi: Anything else than CS0 is not supported yet

Unlike what the driver is currently advertizing, CS0 only can be used,
CS1 is not supported at all. Prevent people to use CS1.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/r/20191108140744.1734-2-miquel.raynal@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-zynq-qspi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index b1c56e9d7c94..9f53ea08adf7 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -680,10 +680,14 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 
 	ret = of_property_read_u32(np, "num-cs",
 				   &num_cs);
-	if (ret < 0)
+	if (ret < 0) {
 		ctlr->num_chipselect = ZYNQ_QSPI_DEFAULT_NUM_CS;
-	else
+	} else if (num_cs > ZYNQ_QSPI_DEFAULT_NUM_CS) {
+		dev_err(&pdev->dev, "anything but CS0 is not yet supported\n");
+		goto remove_master;
+	} else {
 		ctlr->num_chipselect = num_cs;
+	}
 
 	ctlr->mode_bits =  SPI_RX_DUAL | SPI_RX_QUAD |
 			    SPI_TX_DUAL | SPI_TX_QUAD;
-- 
2.20.1
