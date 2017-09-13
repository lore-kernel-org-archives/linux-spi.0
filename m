From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: armada-3700: Fix failing commands with quad-SPI" to the spi tree
Date: Wed, 13 Sep 2017 17:50:28 +0100 (BST)
Message-ID: <20170913165028.47BF4440024@finisterre.ee.mobilebroadband>
References: <20170913074802.9366-1-miquel.raynal@free-electrons.com>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Nadav Haklai <nadavh@marvell.com>, linux-spi@vger.kernel.org
To: Miquel Raynal <miquel.raynal@free-electrons.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170913074802.9366-1-miquel.raynal@free-electrons.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: armada-3700: Fix failing commands with quad-SPI

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 747e1f60470b975363cbbfcde0c41a3166391be5 Mon Sep 17 00:00:00 2001
From: Miquel Raynal <miquel.raynal@free-electrons.com>
Date: Wed, 13 Sep 2017 18:21:38 +0200
Subject: [PATCH] spi: armada-3700: Fix failing commands with quad-SPI

A3700 SPI controller datasheet states that only the first line (IO0) is
used to receive and send instructions, addresses and dummy bytes,
unless for addresses during an RX operation in a quad SPI configuration
(see p.821 of the Armada-3720-DB datasheet). Otherwise, some commands
such as SPI NOR commands like READ_FROM_CACHE_DUAL_IO(0xeb) and
READ_FROM_CACHE_DUAL_IO(0xbb) will fail because these commands must send
address bytes through the four pins. Data transfer always use the four
bytes with this setup.

Thus, in quad SPI configuration, the A3700_SPI_ADDR_PIN bit must be set
only in this case to inform the controller that it must use the number
of pins indicated in the {A3700_SPI_DATA_PIN1,A3700_SPI_DATA_PIN0} field
during the address cycles of an RX operation.

Suggested-by: Ken Ma <make@marvell.com>
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi-armada-3700.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 6c7d7a460689..a28702b1fa05 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -161,7 +161,7 @@ static void a3700_spi_deactivate_cs(struct a3700_spi *a3700_spi,
 }
 
 static int a3700_spi_pin_mode_set(struct a3700_spi *a3700_spi,
-				  unsigned int pin_mode)
+				  unsigned int pin_mode, bool receiving)
 {
 	u32 val;
 
@@ -177,6 +177,9 @@ static int a3700_spi_pin_mode_set(struct a3700_spi *a3700_spi,
 		break;
 	case SPI_NBITS_QUAD:
 		val |= A3700_SPI_DATA_PIN1;
+		/* RX during address reception uses 4-pin */
+		if (receiving)
+			val |= A3700_SPI_ADDR_PIN;
 		break;
 	default:
 		dev_err(&a3700_spi->master->dev, "wrong pin mode %u", pin_mode);
@@ -653,7 +656,7 @@ static int a3700_spi_transfer_one(struct spi_master *master,
 	else if (xfer->rx_buf)
 		nbits = xfer->rx_nbits;
 
-	a3700_spi_pin_mode_set(a3700_spi, nbits);
+	a3700_spi_pin_mode_set(a3700_spi, nbits, xfer->rx_buf ? true : false);
 
 	if (xfer->rx_buf) {
 		/* Set read data length */
-- 
2.13.2
