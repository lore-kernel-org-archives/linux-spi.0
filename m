From: Tan Jui Nee <jui.nee.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: spi-pxa2xx: Check status register to determine if SSSR_TINT is disabled
Date: Tue,  1 Sep 2015 10:22:51 +0800
Message-ID: <1441074171-23265-1-git-send-email-jui.nee.tan@intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: "Tan, Jui Nee" <jui.nee.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

On Intel Baytrail, there is case when interrupt handler get called, no SPI
message is captured. The RX FIFO is indeed empty when RX timeout pending
interrupt (SSSR_TINT) happens.

Use the BIOS version where both HSUART and SPI are on the same IRQ. Both
drivers are using IRQF_SHARED when calling the request_irq function. When
running two separate and independent SPI and HSUART application that
generate data traffic on both components, user will see messages like
below on the console:

  pxa2xx-spi pxa2xx-spi.0: bad message state in interrupt handler

This commit will fix this by first checking Receiver Time-out Interrupt,
if it is disabled, ignore the request and return without servicing.

Signed-off-by: Tan, Jui Nee <jui.nee.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index fdd79197..a8ef38e 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -654,6 +654,10 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 	if (!(sccr1_reg & SSCR1_TIE))
 		mask &= ~SSSR_TFS;
 
+	/* Ignore RX timeout interrupt if it is disabled */
+	if (!(sccr1_reg & SSCR1_TINTE))
+		mask &= ~SSSR_TINT;
+
 	if (!(status & mask))
 		return IRQ_NONE;
 
-- 
1.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
