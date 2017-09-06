From: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 8/8] spi: sh-msiof: Add registers reset
Date: Wed, 6 Sep 2017 09:05:07 +0200
Message-ID: <20170906070507.26223-9-dirk.behme@de.bosch.com>
References: <20170906070507.26223-1-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
To: <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170906070507.26223-1-dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

Reset register before starting transfer.

Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/spi-sh-msiof.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index fdad8d852602..e8aebd406477 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -130,6 +130,8 @@ struct sh_msiof_spi_priv {
 #define CTR_TFSE	0x00004000 /* Transmit Frame Sync Signal Output Enable */
 #define CTR_TXE		0x00000200 /* Transmit Enable */
 #define CTR_RXE		0x00000100 /* Receive Enable */
+#define CTR_TXRST	0x00000002 /* Transmit Reset */
+#define CTR_RXRST	0x00000001 /* Receive Reset */
 
 /* FCTR */
 #define FCTR_TFWM_MASK	0xe0000000 /* Transmit FIFO Watermark */
@@ -254,6 +256,25 @@ static irqreturn_t sh_msiof_spi_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static void sh_msiof_spi_reset_regs(struct sh_msiof_spi_priv *p)
+{
+	u32 mask = CTR_TXRST | CTR_RXRST;
+	u32 data;
+	int k;
+
+	data = sh_msiof_read(p, CTR);
+	data |= mask;
+
+	sh_msiof_write(p, CTR, data);
+
+	for (k = 100; k > 0; k--) {
+		if (!(sh_msiof_read(p, CTR) & mask))
+			break;
+
+		udelay(10);
+	}
+}
+
 static struct {
 	unsigned short div;
 	unsigned short brdv;
@@ -924,6 +945,9 @@ static int sh_msiof_transfer_one(struct spi_master *master,
 	bool swab;
 	int ret;
 
+	/* reset registers */
+	sh_msiof_spi_reset_regs(p);
+
 	/* setup clocks (clock already enabled in chipselect()) */
 	if (!spi_controller_is_slave(p->master))
 		sh_msiof_spi_set_clk_regs(p, clk_get_rate(p->clk), t->speed_hz);
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
