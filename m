From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi/fsl-espi: avoid infinite loops on fsl_espi_cpu_irq()" to the spi tree
Date: Tue, 29 Mar 2016 00:42:22 -0700
Message-ID: <E1akoIA-0007p0-F5@finisterre>
References: <59EFBE2126ED0E4AA25DF57320AFF129051FE3B5@BPXM14GP.gisp.nec.co.jp>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nobuteru Hayashi <hayashi.nbb-MBed0sS7vigTBYAz+LHnZg@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <59EFBE2126ED0E4AA25DF57320AFF129051FE3B5-ZmjkEB1lVlLt6d3pZDjeaEtBU8KWyXPq@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi/fsl-espi: avoid infinite loops on fsl_espi_cpu_irq()

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

>From 6319a68011b86fa61dc63e94dc4fb716628037f3 Mon Sep 17 00:00:00 2001
From: Nobuteru Hayashi <hayashi.nbb-MBed0sS7vigTBYAz+LHnZg@public.gmane.org>
Date: Fri, 18 Mar 2016 11:35:21 +0000
Subject: [PATCH] spi/fsl-espi: avoid infinite loops on fsl_espi_cpu_irq()

It brought nearly infinite loops, and was possible to be
occurred only if the SPI transaction total size are not
alighed with 4. Loops are here at while (tmp--),
tmp is unsigned, and set it with minus value.

The loops are executed as a result of unexpected RX interrupt
occurrence after that. This interrupt may be hardware eratta
and is not fixed.

Fix mspi->len from minus value to 0 and print warning message.

Signed-off-by: Nobuteru Hayashi <hayashi.nbb-MBed0sS7vigTBYAz+LHnZg@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 64d794b99803..8d85a3c343da 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -544,6 +544,7 @@ void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 	if (events & SPIE_NE) {
 		u32 rx_data, tmp;
 		u8 rx_data_8;
+		int rx_nr_bytes = 4;
 		int ret;
 
 		/* Spin until RX is done */
@@ -560,7 +561,14 @@ void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 
 		if (mspi->len >= 4) {
 			rx_data = mpc8xxx_spi_read_reg(&reg_base->receive);
+		} else if (mspi->len <= 0) {
+			dev_err(mspi->dev,
+				"unexpected RX(SPIE_NE) interrupt occurred,\n"
+				"(local rxlen %d bytes, reg rxlen %d bytes)\n",
+				min(4, mspi->len), SPIE_RXCNT(events));
+			rx_nr_bytes = 0;
 		} else {
+			rx_nr_bytes = mspi->len;
 			tmp = mspi->len;
 			rx_data = 0;
 			while (tmp--) {
@@ -571,7 +579,7 @@ void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 			rx_data <<= (4 - mspi->len) * 8;
 		}
 
-		mspi->len -= 4;
+		mspi->len -= rx_nr_bytes;
 
 		if (mspi->rx)
 			mspi->get_rx(rx_data, mspi);
-- 
2.8.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
