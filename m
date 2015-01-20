From: mrnuke <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RESEND PATCH 1/3] ARM: sun4i: spi: Allow transfers larger than FIFO size
Date: Tue, 20 Jan 2015 09:44:18 -0600
Message-ID: <3196669.xiSUTB47Oh@nukelap.gtech>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

SPI transfers were limited to one FIFO depth, which is 64 bytes.
This was an artificial limitation, however, as the hardware can handle
much larger bursts. To accommodate this, we enable the interrupt when
the Rx FIFO is 3/4 full, and drain the FIFO within the interrupt
handler. The 3/4 ratio was chosen arbitrarily, with the intention to
reduce the potential number of interrupts.

Since the SUN4I_CTL_TP bit is set, the hardware will pause
transmission whenever the FIFO is full, so there is no risk of losing
data if we can't service the interrupt in time.

For the Tx side, enable and use the Tx FIFO 3/4 empty interrupt to
replenish the FIFO on large SPI bursts. This requires more care in
when the interrupt is left enabled, as this interrupt will continually
trigger when the FIFO is less than 1/4 full, even though we
acknowledge it.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/spi/spi-sun4i.c | 71 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 62 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 85204c9..e0e2a31 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -46,6 +46,8 @@
 #define SUN4I_CTL_TP				BIT(18)
 
 #define SUN4I_INT_CTL_REG		0x0c
+#define SUN4I_INT_CTL_RF_F34			BIT(4)
+#define SUN4I_INT_CTL_TF_E34			BIT(12)
 #define SUN4I_INT_CTL_TC			BIT(16)
 
 #define SUN4I_INT_STA_REG		0x10
@@ -61,11 +63,14 @@
 #define SUN4I_CLK_CTL_CDR1(div)			(((div) & SUN4I_CLK_CTL_CDR1_MASK) << 8)
 #define SUN4I_CLK_CTL_DRS			BIT(12)
 
+#define SUN4I_MAX_XFER_SIZE			0xffffff
+
 #define SUN4I_BURST_CNT_REG		0x20
-#define SUN4I_BURST_CNT(cnt)			((cnt) & 0xffffff)
+#define SUN4I_BURST_CNT(cnt)			((cnt) & SUN4I_MAX_XFER_SIZE)
 
 #define SUN4I_XMIT_CNT_REG		0x24
-#define SUN4I_XMIT_CNT(cnt)			((cnt) & 0xffffff)
+#define SUN4I_XMIT_CNT(cnt)			((cnt) & SUN4I_MAX_XFER_SIZE)
+
 
 #define SUN4I_FIFO_STA_REG		0x28
 #define SUN4I_FIFO_STA_RF_CNT_MASK		0x7f
@@ -96,6 +101,27 @@ static inline void sun4i_spi_write(struct sun4i_spi *sspi, u32 reg, u32 value)
 	writel(value, sspi->base_addr + reg);
 }
 
+static inline u32 sun4i_spi_get_tx_fifo_count(struct sun4i_spi *sspi)
+{
+	u32 reg = sun4i_spi_read(sspi, SUN4I_FIFO_STA_REG);
+	reg >>= SUN4I_FIFO_STA_TF_CNT_BITS;
+	return reg & SUN4I_FIFO_STA_TF_CNT_MASK;
+}
+
+static inline void sun4i_spi_enable_interrupt(struct sun4i_spi *sspi, u32 mask)
+{
+	u32 reg = sun4i_spi_read(sspi, SUN4I_INT_CTL_REG);
+	reg |= mask;
+	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, reg);
+}
+
+static inline void sun4i_spi_disable_interrupt(struct sun4i_spi *sspi, u32 mask)
+{
+	u32 reg = sun4i_spi_read(sspi, SUN4I_INT_CTL_REG);
+	reg &= ~mask;
+	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, reg);
+}
+
 static inline void sun4i_spi_drain_fifo(struct sun4i_spi *sspi, int len)
 {
 	u32 reg, cnt;
@@ -118,10 +144,13 @@ static inline void sun4i_spi_drain_fifo(struct sun4i_spi *sspi, int len)
 
 static inline void sun4i_spi_fill_fifo(struct sun4i_spi *sspi, int len)
 {
+	u32 cnt;
 	u8 byte;
 
-	if (len > sspi->len)
-		len = sspi->len;
+	/* See how much data we can fit */
+	cnt = SUN4I_FIFO_DEPTH - sun4i_spi_get_tx_fifo_count(sspi);
+
+	len = min3(len, (int)cnt, sspi->len);
 
 	while (len--) {
 		byte = sspi->tx_buf ? *sspi->tx_buf++ : 0;
@@ -174,8 +203,8 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	int ret = 0;
 	u32 reg;
 
-	/* We don't support transfer larger than the FIFO */
-	if (tfr->len > SUN4I_FIFO_DEPTH)
+	/* This is the maximum SPI burst size supported by the hardware */
+	if (tfr->len > SUN4I_MAX_XFER_SIZE)
 		return -EINVAL;
 
 	reinit_completion(&sspi->done);
@@ -273,7 +302,10 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
 
 	/* Enable the interrupts */
-	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC);
+	sun4i_spi_enable_interrupt(sspi, SUN4I_INT_CTL_TC | SUN4I_INT_CTL_RF_F34);
+	/* Only enable Tx FIFO interrupt if we really need it */
+	if (tx_len > SUN4I_FIFO_DEPTH)
+		sun4i_spi_enable_interrupt(sspi, SUN4I_INT_CTL_TF_E34);
 
 	/* Start the transfer */
 	reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
@@ -286,8 +318,6 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 		goto out;
 	}
 
-	sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
-
 out:
 	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, 0);
 
@@ -302,10 +332,33 @@ static irqreturn_t sun4i_spi_handler(int irq, void *dev_id)
 	/* Transfer complete */
 	if (status & SUN4I_INT_CTL_TC) {
 		sun4i_spi_write(sspi, SUN4I_INT_STA_REG, SUN4I_INT_CTL_TC);
+		sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
 		complete(&sspi->done);
 		return IRQ_HANDLED;
 	}
 
+	/* Receive FIFO 3/4 full */
+	if (status & SUN4I_INT_CTL_RF_F34) {
+		sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
+		/* Only clear the interrupt _after_ draining the FIFO */
+		sun4i_spi_write(sspi, SUN4I_INT_STA_REG, SUN4I_INT_CTL_RF_F34);
+		return IRQ_HANDLED;
+	}
+
+	/* Transmit FIFO 3/4 empty */
+	if (status & SUN4I_INT_CTL_TF_E34) {
+		sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
+
+		if (!sspi->len)
+			/* nothing left to transmit */
+			sun4i_spi_disable_interrupt(sspi, SUN4I_INT_CTL_TF_E34);
+
+		/* Only clear the interrupt _after_ re-seeding the FIFO */
+		sun4i_spi_write(sspi, SUN4I_INT_STA_REG, SUN4I_INT_CTL_TF_E34);
+
+		return IRQ_HANDLED;
+	}
+
 	return IRQ_NONE;
 }
 
-- 
1.9.3
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
