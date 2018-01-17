From: Maxime Chevallier <maxime.chevallier@smile.fr>
Subject: [PATCH 3/4] spi: a3700: Allow to enable or disable FIFO mode
Date: Wed, 17 Jan 2018 17:15:27 +0100
Message-ID: <1516205728-3256-4-git-send-email-maxime.chevallier@smile.fr>
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

The armada 3700 SPI controller allows to make transfers without using
the 32 bytes RFIFO and WFIFO.

This commit enable switching between FIFO and non-FIFO mode, which is
necessary to implement full-duplex transfers.

Signed-off-by: Maxime Chevallier <maxime.chevallier@smile.fr>
---
 drivers/spi/spi-armada-3700.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 8048468..b387309 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -186,12 +186,15 @@ static int a3700_spi_pin_mode_set(struct a3700_spi *a3700_spi,
 	return 0;
 }
 
-static void a3700_spi_fifo_mode_set(struct a3700_spi *a3700_spi)
+static void a3700_spi_fifo_mode_set(struct a3700_spi *a3700_spi, bool enable)
 {
 	u32 val;
 
 	val = spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
-	val |= A3700_SPI_FIFO_MODE;
+	if (enable)
+		val |= A3700_SPI_FIFO_MODE;
+	else
+		val &= ~A3700_SPI_FIFO_MODE;
 	spireg_write(a3700_spi, A3700_SPI_IF_CFG_REG, val);
 }
 
@@ -299,7 +302,7 @@ static int a3700_spi_init(struct a3700_spi *a3700_spi)
 		a3700_spi_deactivate_cs(a3700_spi, i);
 
 	/* Enable FIFO mode */
-	a3700_spi_fifo_mode_set(a3700_spi);
+	a3700_spi_fifo_mode_set(a3700_spi, true);
 
 	/* Set SPI mode */
 	a3700_spi_mode_set(a3700_spi, master->mode_bits);
-- 
2.1.4
