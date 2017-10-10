From: Maxime Chevallier <maxime.chevallier@smile.fr>
Subject: [PATCH 2/2] spi: a3700: Change SPI mode before asserting chip-select
Date: Tue, 10 Oct 2017 10:43:18 +0200
Message-ID: <1507624998-31425-2-git-send-email-maxime.chevallier@smile.fr>
References: <1507624998-31425-1-git-send-email-maxime.chevallier@smile.fr>
Cc: linux-kernel@vger.kernel.org, broonie@kernel.org,
        gregory.clement@free-electrons.com,
        miquel.raynal@free-electrons.com,
        Maxime Chevallier <maxime.chevallier@smile.fr>
To: linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507624998-31425-1-git-send-email-maxime.chevallier@smile.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The spi device mode should be configured in the controller before the
chip-select is asserted, so that a clock polarity configuration change
is not interpreted as a clock tick by the device.

This patch moves the mode setting to the 'prepare_message' function
instead of the 'transfer_one' function.

By doing so, this patch also removes redundant code in
a3700_spi_clock_set.

This was tested on EspressoBin board, with spidev.

Signed-off-by: Maxime Chevallier <maxime.chevallier@smile.fr>
---
 drivers/spi/spi-armada-3700.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 568e1c6..77fe55c 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -213,7 +213,7 @@ static void a3700_spi_mode_set(struct a3700_spi *a3700_spi,
 }
 
 static void a3700_spi_clock_set(struct a3700_spi *a3700_spi,
-				unsigned int speed_hz, u16 mode)
+				unsigned int speed_hz)
 {
 	u32 val;
 	u32 prescale;
@@ -231,17 +231,6 @@ static void a3700_spi_clock_set(struct a3700_spi *a3700_spi,
 		val |= A3700_SPI_CLK_CAPT_EDGE;
 		spireg_write(a3700_spi, A3700_SPI_IF_TIME_REG, val);
 	}
-
-	val = spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
-	val &= ~(A3700_SPI_CLK_POL | A3700_SPI_CLK_PHA);
-
-	if (mode & SPI_CPOL)
-		val |= A3700_SPI_CLK_POL;
-
-	if (mode & SPI_CPHA)
-		val |= A3700_SPI_CLK_PHA;
-
-	spireg_write(a3700_spi, A3700_SPI_IF_CFG_REG, val);
 }
 
 static void a3700_spi_bytelen_set(struct a3700_spi *a3700_spi, unsigned int len)
@@ -423,7 +412,7 @@ static void a3700_spi_transfer_setup(struct spi_device *spi,
 
 	a3700_spi = spi_master_get_devdata(spi->master);
 
-	a3700_spi_clock_set(a3700_spi, xfer->speed_hz, spi->mode);
+	a3700_spi_clock_set(a3700_spi, xfer->speed_hz);
 
 	byte_len = xfer->bits_per_word >> 3;
 
@@ -584,6 +573,8 @@ static int a3700_spi_prepare_message(struct spi_master *master,
 
 	a3700_spi_bytelen_set(a3700_spi, 4);
 
+	a3700_spi_mode_set(a3700_spi, spi->mode);
+
 	return 0;
 }
 
-- 
2.1.4
