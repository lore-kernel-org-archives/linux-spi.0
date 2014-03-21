From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2] spi: nuc900: Fix setting multiple bits settings in
 register
Date: Fri, 21 Mar 2014 22:40:23 +0800
Message-ID: <1395412823.9974.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The correct way to set multiple bits settings is always clear these
bit fields before set new settings.

Current code does not cause problem because the reset value of these
bit fields are 0, and these settings only set once during probe.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-nuc900.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-nuc900.c b/drivers/spi/spi-nuc900.c
index 675c210..a062a89 100644
--- a/drivers/spi/spi-nuc900.c
+++ b/drivers/spi/spi-nuc900.c
@@ -37,7 +37,9 @@
 /* usi register bit */
 #define ENINT		(0x01 << 17)
 #define ENFLG		(0x01 << 16)
+#define SLEEP		(0x0f << 12)
 #define TXNUM		(0x03 << 8)
+#define TXBITLEN	(0x1f << 3)
 #define TXNEG		(0x01 << 2)
 #define RXNEG		(0x01 << 1)
 #define LSB		(0x01 << 10)
@@ -115,8 +117,7 @@ static void nuc900_spi_chipsel(struct spi_device *spi, int value)
 	}
 }
 
-static void nuc900_spi_setup_txnum(struct nuc900_spi *hw,
-							unsigned int txnum)
+static void nuc900_spi_setup_txnum(struct nuc900_spi *hw, unsigned int txnum)
 {
 	unsigned int val;
 	unsigned long flags;
@@ -124,12 +125,7 @@ static void nuc900_spi_setup_txnum(struct nuc900_spi *hw,
 	spin_lock_irqsave(&hw->lock, flags);
 
 	val = __raw_readl(hw->regs + USI_CNT);
-
-	if (!txnum)
-		val &= ~TXNUM;
-	else
-		val |= txnum << 0x08;
-
+	val = (val & ~TXNUM) | (txnum << 0x08);
 	__raw_writel(val, hw->regs + USI_CNT);
 
 	spin_unlock_irqrestore(&hw->lock, flags);
@@ -145,9 +141,7 @@ static void nuc900_spi_setup_txbitlen(struct nuc900_spi *hw,
 	spin_lock_irqsave(&hw->lock, flags);
 
 	val = __raw_readl(hw->regs + USI_CNT);
-
-	val |= (txbitlen << 0x03);
-
+	val = (val & ~TXBITLEN) | (txbitlen << 0x03);
 	__raw_writel(val, hw->regs + USI_CNT);
 
 	spin_unlock_irqrestore(&hw->lock, flags);
@@ -284,11 +278,7 @@ static void nuc900_set_sleep(struct nuc900_spi *hw, unsigned int sleep)
 	spin_lock_irqsave(&hw->lock, flags);
 
 	val = __raw_readl(hw->regs + USI_CNT);
-
-	if (sleep)
-		val |= (sleep << 12);
-	else
-		val &= ~(0x0f << 12);
+	val = (val & ~SLEEP) | (sleep << 12);
 	__raw_writel(val, hw->regs + USI_CNT);
 
 	spin_unlock_irqrestore(&hw->lock, flags);
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
