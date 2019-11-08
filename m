From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 1/7] spi: zynq-qspi: Anything else than CS0 is not supported
 yet
Date: Fri,  8 Nov 2019 11:59:14 +0100
Message-ID: <20191108105920.19014-2-miquel.raynal@bootlin.com>
References: <20191108105920.19014-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Michal Simek <michal.simek@xilinx.com>,
 Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191108105920.19014-1-miquel.raynal@bootlin.com>
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

Unlike what the driver is currently advertizing, CS0 only can be used,
CS1 is not supported at all. Prevent people to use CS1.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-zynq-qspi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 87c9ec21f093..8098b5087708 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -704,10 +704,15 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 
 	ret = of_property_read_u32(pdev->dev.of_node, "num-cs",
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
+
 	ctlr->mode_bits =  SPI_RX_DUAL | SPI_RX_QUAD |
 			    SPI_TX_DUAL | SPI_TX_QUAD;
 	ctlr->mem_ops = &zynq_qspi_mem_ops;
-- 
2.20.1
