From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 01/18] spi/xilinx: Support for spi mode LSB_FIRST
Date: Fri, 23 Jan 2015 17:08:33 +0100
Message-ID: <1422029330-10971-2-git-send-email-ricardo.ribalda@gmail.com>
References: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: Mark Brown <broonie@kernel.org>, Michal Simek <michal.simek@xilinx.com>,
 =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
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

Hardware supports LSB_FIRST mode. Support it also in the driver.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/spi/spi-xilinx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 79bd84f..d4edeee 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -34,7 +34,8 @@
 #define XSPI_CR_MASTER_MODE	0x04
 #define XSPI_CR_CPOL		0x08
 #define XSPI_CR_CPHA		0x10
-#define XSPI_CR_MODE_MASK	(XSPI_CR_CPHA | XSPI_CR_CPOL)
+#define XSPI_CR_MODE_MASK	(XSPI_CR_CPHA | XSPI_CR_CPOL | \
+				 XSPI_CR_LSB_FIRST)
 #define XSPI_CR_TXFIFO_RESET	0x20
 #define XSPI_CR_RXFIFO_RESET	0x40
 #define XSPI_CR_MANUAL_SSELECT	0x80
@@ -194,6 +195,8 @@ static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)
 			cr |= XSPI_CR_CPHA;
 		if (spi->mode & SPI_CPOL)
 			cr |= XSPI_CR_CPOL;
+		if (spi->mode & SPI_LSB_FIRST)
+			cr |= XSPI_CR_LSB_FIRST;
 		xspi->write_fn(cr, xspi->regs + XSPI_CR_OFFSET);
 
 		/* We do not check spi->max_speed_hz here as the SPI clock
@@ -353,7 +356,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	/* the spi->mode bits understood by this driver: */
-	master->mode_bits = SPI_CPOL | SPI_CPHA;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
 
 	xspi = spi_master_get_devdata(master);
 	xspi->bitbang.master = master;
-- 
2.1.4
