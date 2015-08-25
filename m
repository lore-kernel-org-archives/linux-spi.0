From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi/bcm63xx-hsspi: add support for dual spi read/write" to the spi tree
Date: Tue, 25 Aug 2015 18:50:11 +0100
Message-ID: <E1ZUIMN-0005Q1-3a@debutante>
References: <1440362972-32702-1-git-send-email-jogo@openwrt.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1440362972-32702-1-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi/bcm63xx-hsspi: add support for dual spi read/write

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

>From f4d86223771533c68f1a6692d499f7ef0025f733 Mon Sep 17 00:00:00 2001
From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Date: Sun, 23 Aug 2015 22:49:32 +0200
Subject: [PATCH] spi/bcm63xx-hsspi: add support for dual spi read/write

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
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index f5ca6dc3a157..55789f7cda92 100644
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
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
