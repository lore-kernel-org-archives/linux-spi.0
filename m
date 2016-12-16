From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 1/3] spi: armada-3700: Signedness bug in probe
Date: Fri, 16 Dec 2016 12:33:05 +0300
Message-ID: <20161216082443.GA7031@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org
To: Mark Brown <broonie@kernel.org>,
        Romain Perier <romain.perier@free-electrons.com>
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

We need "irq" to be an int because platform_get_irq() returns negative
error codes.

Fixes: 5762ab71eb24 ("spi: Add support for Armada 3700 SPI Controller")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index e89da0af45d2..5c7508dc6f0b 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -108,7 +108,7 @@ struct a3700_spi {
 	struct spi_master *master;
 	void __iomem *base;
 	struct clk *clk;
-	unsigned int irq;
+	int irq;
 	unsigned int flags;
 	bool xmit_data;
 	const u8 *tx_buf;
