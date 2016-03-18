From: Nobuteru Hayashi <hayashi.nbb-MBed0sS7vigTBYAz+LHnZg@public.gmane.org>
Subject: [PATCH 1/3] spi/fsl-espi: Don't spin forever on SPIE_RXCNT
Date: Fri, 18 Mar 2016 11:35:21 +0000
Message-ID: <59EFBE2126ED0E4AA25DF57320AFF129051FE3AF@BPXM14GP.gisp.nec.co.jp>
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

Infinite loop on SPIE_RXCNT occurred.

while (SPIE_RXCNT(events) < min(4, mspi->len)) {
        cpu_relax();
        events = mpc8xxx_spi_read_reg(&reg_base->event);
}

We met a soft lockup at fsl_espi_cpu_irq() because of this.

Fix it by using spin_event_timeout() so that fsl_espi_cpu_irq()
can break loop with timeouts dmesg.

Signed-off-by: Nobuteru Hayashi <hayashi.nbb-MBed0sS7vigTBYAz+LHnZg@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 7fd6a4c..cfabfb2 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -539,11 +539,18 @@ void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 	if (events & SPIE_NE) {
 		u32 rx_data, tmp;
 		u8 rx_data_8;
+		int ret;
 
 		/* Spin until RX is done */
-		while (SPIE_RXCNT(events) < min(4, mspi->len)) {
-			cpu_relax();
-			events = mpc8xxx_spi_read_reg(&reg_base->event);
+		if (SPIE_RXCNT(events) < min(4, mspi->len)) {
+			ret = spin_event_timeout(
+				!(SPIE_RXCNT(events =
+				mpc8xxx_spi_read_reg(&reg_base->event)) <
+						min(4, mspi->len)),
+						10000, 0); /* 10 msec */
+			if (!ret)
+				dev_err(mspi->dev,
+					 "tired waiting for SPIE_RXCNT\n");
 		}
 
 		if (mspi->len >= 4) {
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
