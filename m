From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: ti-qspi: use 128 bit transfer mode where possible" to the spi tree
Date: Thu, 20 Aug 2015 11:34:35 -0700
Message-ID: <E1ZSUfb-00009h-UC@finisterre>
References: <1440066659-5356-1-git-send-email-vigneshr@ti.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1440066659-5356-1-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: ti-qspi: use 128 bit transfer mode where possible

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

>From f682c4ffd25a19594d21987c19a69fa123242eb7 Mon Sep 17 00:00:00 2001
From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Date: Thu, 20 Aug 2015 16:00:59 +0530
Subject: [PATCH] spi: ti-qspi: use 128 bit transfer mode where possible

TI QSPI has four 32 bit data regsiters which can be used to transfer 16
bytes of data at once. The register group QSPI_SPI_DATA_REG_3,
QSPI_SPI_DATA_REG_2, QSPI_SPI_DATA_REG_1 and QSPI_SPI_DATA_REG is
treated as a single 128-bit word for shifting data in and out. The bit
at QSPI_SPI_DATA_REG_3[31] position is the first bit to be shifted out
in case of 128 bit transfer mode. Therefore the first byte to be written
to flash should be at QSPI_SPI_DATA_REG_3[31-25] position.
Instead of writing 1 byte at a time when interacting with spi-nor flash,
make use of all the four registers so that 16 bytes can be transferred
in one go. This reduces number of register writes and Word Complete
interrupts for a given transfer message size, thereby increasing the
write performance.

Without this patch the raw flash write speed is ~100KB/s, with this
patch the write speed increases to ~400 kB/s on DRA74 EVM.

Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-ti-qspi.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 5c06168..aa6d284 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -99,6 +99,8 @@ struct ti_qspi {
 #define QSPI_INVAL			(4 << 16)
 #define QSPI_WC_CMD_INT_EN			(1 << 14)
 #define QSPI_FLEN(n)			((n - 1) << 0)
+#define QSPI_WLEN_MAX_BITS		128
+#define QSPI_WLEN_MAX_BYTES		16
 
 /* STATUS REGISTER */
 #define BUSY				0x01
@@ -217,14 +219,16 @@ static inline u32 qspi_is_busy(struct ti_qspi *qspi)
 
 static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 {
-	int wlen, count;
+	int wlen, count, xfer_len;
 	unsigned int cmd;
 	const u8 *txbuf;
+	u32 data;
 
 	txbuf = t->tx_buf;
 	cmd = qspi->cmd | QSPI_WR_SNGL;
 	count = t->len;
 	wlen = t->bits_per_word >> 3;	/* in bytes */
+	xfer_len = wlen;
 
 	while (count) {
 		if (qspi_is_busy(qspi))
@@ -234,7 +238,29 @@ static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 		case 1:
 			dev_dbg(qspi->dev, "tx cmd %08x dc %08x data %02x\n",
 					cmd, qspi->dc, *txbuf);
-			writeb(*txbuf, qspi->base + QSPI_SPI_DATA_REG);
+			if (count >= QSPI_WLEN_MAX_BYTES) {
+				u32 *txp = (u32 *)txbuf;
+
+				data = cpu_to_be32(*txp++);
+				writel(data, qspi->base +
+				       QSPI_SPI_DATA_REG_3);
+				data = cpu_to_be32(*txp++);
+				writel(data, qspi->base +
+				       QSPI_SPI_DATA_REG_2);
+				data = cpu_to_be32(*txp++);
+				writel(data, qspi->base +
+				       QSPI_SPI_DATA_REG_1);
+				data = cpu_to_be32(*txp++);
+				writel(data, qspi->base +
+				       QSPI_SPI_DATA_REG);
+				xfer_len = QSPI_WLEN_MAX_BYTES;
+				cmd |= QSPI_WLEN(QSPI_WLEN_MAX_BITS);
+			} else {
+				writeb(*txbuf, qspi->base + QSPI_SPI_DATA_REG);
+				cmd = qspi->cmd | QSPI_WR_SNGL;
+				xfer_len = wlen;
+				cmd |= QSPI_WLEN(wlen);
+			}
 			break;
 		case 2:
 			dev_dbg(qspi->dev, "tx cmd %08x dc %08x data %04x\n",
@@ -254,8 +280,8 @@ static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 			dev_err(qspi->dev, "write timed out\n");
 			return -ETIMEDOUT;
 		}
-		txbuf += wlen;
-		count -= wlen;
+		txbuf += xfer_len;
+		count -= xfer_len;
 	}
 
 	return 0;
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
