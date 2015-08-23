From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH V2] spi/bcm63xx-hsspi: add support for dual spi read/write
Date: Sun, 23 Aug 2015 22:49:32 +0200
Message-ID: <1440362972-32702-1-git-send-email-jogo@openwrt.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add support for dual read/writes on spi-bcm63xx-hsspi. This has been
tested with a s25fl129p1 dual read capable spi flash, with a nice speed
improvement:

serial read:

root@OpenWrt:/# time dd if=/dev/mtd4 of=/dev/null bs=8192
2032+0 records in
2032+0 records out
real    0m 4.39s
user    0m 0.00s
sys     0m 1.55s

dual read:

root@OpenWrt:/# time dd if=/dev/mtd4 of=/dev/null bs=8192
2032+0 records in
2032+0 records out
real    0m 3.09s
user    0m 0.00s
sys     0m 1.56s

Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
Well that was embarassing ...

V1 -> V2:
 * Move dual check after read check so we can still use 512 byte chunks
   in dual read mode.

 drivers/spi/spi-bcm63xx-hsspi.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index f5ca6dc..55789f7 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -76,6 +76,7 @@
 #define HSSPI_FIFO_REG(x)			(0x200 + (x) * 0x200)
 
 
+#define HSSPI_OP_MULTIBIT			BIT(11)
 #define HSSPI_OP_CODE_SHIFT			13
 #define HSSPI_OP_SLEEP				(0 << HSSPI_OP_CODE_SHIFT)
 #define HSSPI_OP_READ_WRITE			(1 << HSSPI_OP_CODE_SHIFT)
@@ -171,9 +172,12 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 	if (opcode != HSSPI_OP_READ)
 		step_size -= HSSPI_OPCODE_LEN;
 
-	__raw_writel(0 << MODE_CTRL_PREPENDBYTE_CNT_SHIFT |
-		     2 << MODE_CTRL_MULTIDATA_WR_STRT_SHIFT |
-		     2 << MODE_CTRL_MULTIDATA_RD_STRT_SHIFT | 0xff,
+	if ((opcode == HSSPI_OP_READ && t->rx_nbits == SPI_NBITS_DUAL) ||
+	    (opcode == HSSPI_OP_WRITE && t->tx_nbits == SPI_NBITS_DUAL))
+		opcode |= HSSPI_OP_MULTIBIT;
+
+	__raw_writel(1 << MODE_CTRL_MULTIDATA_WR_SIZE_SHIFT |
+		     1 << MODE_CTRL_MULTIDATA_RD_SIZE_SHIFT | 0xff,
 		     bs->regs + HSSPI_PROFILE_MODE_CTRL_REG(chip_select));
 
 	while (pending > 0) {
@@ -374,7 +378,8 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	master->num_chipselect = 8;
 	master->setup = bcm63xx_hsspi_setup;
 	master->transfer_one_message = bcm63xx_hsspi_transfer_one;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH |
+			    SPI_RX_DUAL | SPI_TX_DUAL;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->auto_runtime_pm = true;
 
-- 
2.1.4
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
