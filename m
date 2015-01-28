From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 09/15] spi/xilinx: Make spi_tx and spi_rx simmetric
Date: Wed, 28 Jan 2015 13:23:48 +0100
Message-ID: <1422447834-23116-10-git-send-email-ricardo.ribalda@gmail.com>
References: <1422447834-23116-1-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: Mark Brown <broonie@kernel.org>, Michal Simek <michal.simek@xilinx.com>,
 =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1422447834-23116-1-git-send-email-ricardo.ribalda@gmail.com>
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

spi_rx handles the case where the buffer is null. Nevertheless spi_tx
did not handle it, and was handled by the caller function.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/spi/spi-xilinx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index ac94e54..6ce1066 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -116,6 +116,10 @@ static unsigned int xspi_read32_be(void __iomem *addr)
 
 static void xilinx_spi_tx(struct xilinx_spi *xspi)
 {
+	if (!xspi->tx_ptr) {
+		xspi->write_fn(0, xspi->regs + XSPI_TXD_OFFSET);
+		return;
+	}
 	xspi->write_fn(*(u32 *)(xspi->tx_ptr), xspi->regs + XSPI_TXD_OFFSET);
 	xspi->tx_ptr += xspi->bits_per_word / 8;
 }
@@ -230,10 +234,7 @@ static void xilinx_spi_fill_tx_fifo(struct xilinx_spi *xspi, int n_words)
 	xspi->remaining_bytes -= n_words * xspi->bits_per_word / 8;
 
 	while (n_words--)
-		if (xspi->tx_ptr)
-			xilinx_spi_tx(xspi);
-		else
-			xspi->write_fn(0, xspi->regs + XSPI_TXD_OFFSET);
+		xilinx_spi_tx(xspi);
 	return;
 }
 
-- 
2.1.4
