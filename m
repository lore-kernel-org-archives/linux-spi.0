From: Maxime Chevallier <maxime.chevallier@smile.fr>
Subject: [PATCH 2/4] spi: a3700: Set frequency limits at startup
Date: Wed, 17 Jan 2018 17:15:26 +0100
Message-ID: <1516205728-3256-3-git-send-email-maxime.chevallier@smile.fr>
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

Armada 3700 SPI controller has an internal clock divider which can
divide the parent clock frequency by up to 30.

This patch sets the limits in the spi_controller fields so that we can
detect when a non-supported frequency is requested by a device for a
transfer.

Signed-off-by: Maxime Chevallier <maxime.chevallier@smile.fr>
---
 drivers/spi/spi-armada-3700.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index c11ea6c..8048468 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -27,6 +27,8 @@
 
 #define DRIVER_NAME			"armada_3700_spi"
 
+#define A3700_SPI_MAX_SPEED_HZ		100000000
+#define A3700_SPI_MAX_PRESCALE		30
 #define A3700_SPI_TIMEOUT		10
 
 /* SPI Register Offest */
@@ -823,6 +825,11 @@ static int a3700_spi_probe(struct platform_device *pdev)
 		goto error;
 	}
 
+	master->max_speed_hz = min_t(unsigned long, A3700_SPI_MAX_SPEED_HZ,
+					clk_get_rate(spi->clk));
+	master->min_speed_hz = DIV_ROUND_UP(clk_get_rate(spi->clk),
+						A3700_SPI_MAX_PRESCALE);
+
 	ret = a3700_spi_init(spi);
 	if (ret)
 		goto error_clk;
-- 
2.1.4
