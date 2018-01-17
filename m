From: Maxime Chevallier <maxime.chevallier@smile.fr>
Subject: [PATCH 1/4] spi: a3700: Clear DATA_OUT when performing a read
Date: Wed, 17 Jan 2018 17:15:25 +0100
Message-ID: <1516205728-3256-2-git-send-email-maxime.chevallier@smile.fr>
References: <1516205728-3256-1-git-send-email-maxime.chevallier@smile.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: gregory.clement@free-electrons.com,
 Maxime Chevallier <maxime.chevallier@smile.fr>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
To: broonie@kernel.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1516205728-3256-1-git-send-email-maxime.chevallier@smile.fr>
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

When performing a read using FIFO mode, the spi controller shifts out
the last 2 bytes that were written in a previous transfer on MOSI.

This undocumented behaviour can cause devices to misinterpret the
transfer, so we explicitly clear the WFIFO before each read.

This behaviour was noticed on EspressoBin.

Signed-off-by: Maxime Chevallier <maxime.chevallier@smile.fr>
---
 drivers/spi/spi-armada-3700.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index d653453..c11ea6c 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -615,6 +615,11 @@ static int a3700_spi_transfer_one(struct spi_master *master,
 	a3700_spi_header_set(a3700_spi);
 
 	if (xfer->rx_buf) {
+		/* Clear WFIFO, since it's last 2 bytes are shifted out during
+		 * a read operation
+		 */
+		spireg_write(a3700_spi, A3700_SPI_DATA_OUT_REG, 0);
+
 		/* Set read data length */
 		spireg_write(a3700_spi, A3700_SPI_IF_DIN_CNT_REG,
 			     a3700_spi->buf_len);
-- 
2.1.4
