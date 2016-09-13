From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/4] spi: fsl-espi: improve and simplify interrupt handler
Date: Tue, 13 Sep 2016 23:15:57 +0200
Message-ID: <5be7ab71-3401-0e9e-b374-d781afda98f1@gmail.com>
References: <848f06e1-3cb9-bef1-bb41-455fa72822b1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <848f06e1-3cb9-bef1-bb41-455fa72822b1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Simplify the interrupt handler a little. In addition don't call
fsl_espi_cpu_irq() if no event bit is set.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 060624f..032bf3a 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -443,17 +443,11 @@ static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 				&reg_base->event)) & SPIE_NF), 1000, 0);
 		if (!ret) {
 			dev_err(mspi->dev, "tired waiting for SPIE_NF\n");
-
-			/* Clear the SPIE bits */
-			mpc8xxx_spi_write_reg(&reg_base->event, events);
 			complete(&mspi->done);
 			return;
 		}
 	}
 
-	/* Clear the events */
-	mpc8xxx_spi_write_reg(&reg_base->event, events);
-
 	mspi->count -= 1;
 	if (mspi->count) {
 		u32 word = mspi->get_tx(mspi);
@@ -468,19 +462,21 @@ static irqreturn_t fsl_espi_irq(s32 irq, void *context_data)
 {
 	struct mpc8xxx_spi *mspi = context_data;
 	struct fsl_espi_reg *reg_base = mspi->reg_base;
-	irqreturn_t ret = IRQ_NONE;
 	u32 events;
 
 	/* Get interrupt events(tx/rx) */
 	events = mpc8xxx_spi_read_reg(&reg_base->event);
-	if (events)
-		ret = IRQ_HANDLED;
+	if (!events)
+		return IRQ_NONE;
 
 	dev_vdbg(mspi->dev, "%s: events %x\n", __func__, events);
 
 	fsl_espi_cpu_irq(mspi, events);
 
-	return ret;
+	/* Clear the events */
+	mpc8xxx_spi_write_reg(&reg_base->event, events);
+
+	return IRQ_HANDLED;
 }
 
 #ifdef CONFIG_PM
-- 
2.9.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
