From: Nobuteru Hayashi <hayashi.nbb-MBed0sS7vigTBYAz+LHnZg@public.gmane.org>
Subject: [PATCH 2/3] spi/fsl-espi: avoid infinite loops on fsl_espi_cpu_irq()
Date: Fri, 18 Mar 2016 11:35:21 +0000
Message-ID: <59EFBE2126ED0E4AA25DF57320AFF129051FE3B5@BPXM14GP.gisp.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: ja-JP
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Nobuteru Hayashi <hayashi.nbb-MBed0sS7vigTBYAz+LHnZg@public.gmane.org>

It brought nearly infinite loops, and was possible to be
occurred only if the SPI transaction total size are not
alighed with 4. Loops are here at while (tmp--),
tmp is unsigned, and set it with minus value.

The loops are executed as a result of unexpected RX interrupt
occurrence after that. This interrupt may be hardware eratta
and is not fixed.

Fix mspi->len from minus value to 0 and print warning message.

Signed-off-by: Nobuteru Hayashi <hayashi.nbb-MBed0sS7vigTBYAz+LHnZg@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index cfabfb2..d7406f0 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -539,6 +539,7 @@ void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 	if (events & SPIE_NE) {
 		u32 rx_data, tmp;
 		u8 rx_data_8;
+		int rx_nr_bytes = 4;
 		int ret;
 
 		/* Spin until RX is done */
@@ -555,7 +556,14 @@ void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 
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
@@ -566,7 +574,7 @@ void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 			rx_data <<= (4 - mspi->len) * 8;
 		}
 
-		mspi->len -= 4;
+		mspi->len -= rx_nr_bytes;
 
 		if (mspi->rx)
 			mspi->get_rx(rx_data, mspi);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
