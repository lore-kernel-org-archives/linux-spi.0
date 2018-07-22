From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH 12/15] spi: img-spfi: Use device 0 configuration for all devices
Date: Sun, 22 Jul 2018 23:20:07 +0200
Message-ID: <20180722212010.3979-13-afaerber@suse.de>
References: <20180722212010.3979-1-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Ionela Voinescu <ionela.voinescu@imgtec.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: linux-mips@linux-mips.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180722212010.3979-1-afaerber@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Ionela Voinescu <ionela.voinescu@imgtec.com>

Given that we control the chip select line externally,
we can use only one parameter register (device 0 parameter
register) and one set of configuration bits (port configuration
bits for device 0) for all devices (all chip select lines).

Signed-off-by: Ionela Voinescu <ionela.voinescu@imgtec.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/spi/spi-img-spfi.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 0d73d31a6a2b..231b59c1ab60 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -437,18 +437,23 @@ static int img_spfi_prepare(struct spi_master *master, struct spi_message *msg)
 	struct img_spfi *spfi = spi_master_get_devdata(master);
 	u32 val;
 
+	/*
+	 * The chip select line is controlled externally so
+	 * we can use the CS0 configuration for all devices
+	 */
 	val = spfi_readl(spfi, SPFI_PORT_STATE);
+
+	/* 0 for device selection */
 	val &= ~(SPFI_PORT_STATE_DEV_SEL_MASK <<
 		 SPFI_PORT_STATE_DEV_SEL_SHIFT);
-	val |= msg->spi->chip_select << SPFI_PORT_STATE_DEV_SEL_SHIFT;
 	if (msg->spi->mode & SPI_CPHA)
-		val |= SPFI_PORT_STATE_CK_PHASE(msg->spi->chip_select);
+		val |= SPFI_PORT_STATE_CK_PHASE(0);
 	else
-		val &= ~SPFI_PORT_STATE_CK_PHASE(msg->spi->chip_select);
+		val &= ~SPFI_PORT_STATE_CK_PHASE(0);
 	if (msg->spi->mode & SPI_CPOL)
-		val |= SPFI_PORT_STATE_CK_POL(msg->spi->chip_select);
+		val |= SPFI_PORT_STATE_CK_POL(0);
 	else
-		val &= ~SPFI_PORT_STATE_CK_POL(msg->spi->chip_select);
+		val &= ~SPFI_PORT_STATE_CK_POL(0);
 	spfi_writel(spfi, val, SPFI_PORT_STATE);
 
 	return 0;
@@ -548,11 +553,15 @@ static void img_spfi_config(struct spi_master *master, struct spi_device *spi,
 	div = DIV_ROUND_UP(clk_get_rate(spfi->spfi_clk), xfer->speed_hz);
 	div = clamp(512 / (1 << get_count_order(div)), 1, 128);
 
-	val = spfi_readl(spfi, SPFI_DEVICE_PARAMETER(spi->chip_select));
+	/*
+	 * The chip select line is controlled externally so
+	 * we can use the CS0 parameters for all devices
+	 */
+	val = spfi_readl(spfi, SPFI_DEVICE_PARAMETER(0));
 	val &= ~(SPFI_DEVICE_PARAMETER_BITCLK_MASK <<
 		 SPFI_DEVICE_PARAMETER_BITCLK_SHIFT);
 	val |= div << SPFI_DEVICE_PARAMETER_BITCLK_SHIFT;
-	spfi_writel(spfi, val, SPFI_DEVICE_PARAMETER(spi->chip_select));
+	spfi_writel(spfi, val, SPFI_DEVICE_PARAMETER(0));
 
 	if (!list_is_last(&xfer->transfer_list, &master->cur_msg->transfers) &&
 		/*
-- 
2.16.4
