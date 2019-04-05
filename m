From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V2 11/20] spi: expand mode support and add LSBYTE_FIRST mode
Date: Thu, 4 Apr 2019 17:14:10 -0700
Message-ID: <1554423259-26056-11-git-send-email-skomatineni@nvidia.com>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Some SPI Master controllers support configuring Least significant byte
first or Most significant byte first order for transfers. Also some SPI
slave devices expect bytes to be in Least significant first order and
some devices expect Most significant first order.

SPI driver declares mode and mode_bits as u16 and all bits are used.

This patch changes mode and mode_bits to be u32 to allow for more mode
configurations.

This patch also creates SPI_LSBYTE_FIRST mode to allow SPI clients to
choose LSByte order or MSByte order through the device tree property
spi-lsbyte-first.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi.c       | 5 ++++-
 include/linux/spi/spi.h | 7 ++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index bd2a424672df..97ce047a776b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1638,6 +1638,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		spi->mode |= SPI_3WIRE;
 	if (of_property_read_bool(nc, "spi-lsb-first"))
 		spi->mode |= SPI_LSB_FIRST;
+	if (of_property_read_bool(nc, "spi-lsbyte-first"))
+		spi->mode |= SPI_LSBYTE_FIRST;
 
 	/*
 	 * For descriptors associated with the device, polarity inversion is
@@ -2979,10 +2981,11 @@ int spi_setup(struct spi_device *spi)
 
 	spi_set_cs(spi, false);
 
-	dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%u bits/w, %u Hz max --> %d\n",
+	dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%s%u bits/w, %u Hz max --> %d\n",
 			(int) (spi->mode & (SPI_CPOL | SPI_CPHA)),
 			(spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
 			(spi->mode & SPI_LSB_FIRST) ? "lsb, " : "",
+			(spi->mode & SPI_LSBYTE_FIRST) ? "lsbyte, " : "",
 			(spi->mode & SPI_3WIRE) ? "3wire, " : "",
 			(spi->mode & SPI_LOOP) ? "loopback, " : "",
 			spi->bits_per_word, spi->max_speed_hz,
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index a0975cf76cf6..d5c86b763f43 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -143,7 +143,7 @@ struct spi_device {
 	u32			max_speed_hz;
 	u8			chip_select;
 	u8			bits_per_word;
-	u16			mode;
+	u32			mode;
 #define	SPI_CPHA	0x01			/* clock phase */
 #define	SPI_CPOL	0x02			/* clock polarity */
 #define	SPI_MODE_0	(0|0)			/* (original MicroWire) */
@@ -164,6 +164,7 @@ struct spi_device {
 #define	SPI_TX_OCTAL	0x2000			/* transmit with 8 wires */
 #define	SPI_RX_OCTAL	0x4000			/* receive with 8 wires */
 #define	SPI_3WIRE_HIZ	0x8000			/* high impedance turnaround */
+#define SPI_LSBYTE_FIRST	0x10000		/* per-word bytes-on-wire */
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
@@ -439,7 +440,7 @@ struct spi_controller {
 	u16			dma_alignment;
 
 	/* spi_device.mode flags understood by this controller driver */
-	u16			mode_bits;
+	u32			mode_bits;
 
 	/* bitmask of supported bits_per_word for transfers */
 	u32			bits_per_word_mask;
@@ -1276,7 +1277,7 @@ struct spi_board_info {
 	/* mode becomes spi_device.mode, and is essential for chips
 	 * where the default of SPI_CS_HIGH = 0 is wrong.
 	 */
-	u16		mode;
+	u32		mode;
 
 	/* ... may need additional spi_device chip config data here.
 	 * avoid stuff protocol drivers can set; but include stuff
-- 
2.7.4
