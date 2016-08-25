From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 17/23] spi: fsl-espi: improve the ISR frame
Date: Thu, 25 Aug 2016 06:50:21 +0200
Message-ID: <f4067947-b0e3-cb41-81c8-75051908e121@gmail.com>
References: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Improve the ISR frame:
- move resetting the event bits to the ISR frame
- change type of parameter irq to int
- make sure that the event bits match at least one bit in the
  interrupt mask register

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index ee4e778..8d5bebc 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -451,17 +451,11 @@ static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
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
@@ -472,23 +466,26 @@ static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 	}
 }
 
-static irqreturn_t fsl_espi_irq(s32 irq, void *context_data)
+static irqreturn_t fsl_espi_irq(int irq, void *context_data)
 {
 	struct mpc8xxx_spi *mspi = context_data;
 	struct fsl_espi_reg *reg_base = mspi->reg_base;
-	irqreturn_t ret = IRQ_NONE;
-	u32 events;
+	u32 mask, events;
 
-	/* Get interrupt events(tx/rx) */
+	/* Get interrupt mask and events and check that irq belongs to us */
+	mask = mpc8xxx_spi_read_reg(&reg_base->mask);
 	events = mpc8xxx_spi_read_reg(&reg_base->event);
-	if (events)
-		ret = IRQ_HANDLED;
+	if (!(mask & events))
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
