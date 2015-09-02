From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spi-pxa2xx: Check status register to determine if SSSR_TINT is disabled" to the spi tree
Date: Wed, 02 Sep 2015 13:12:16 +0100
Message-ID: <E1ZX6tk-0003bH-8g@debutante>
References: <1441074171-23265-1-git-send-email-jui.nee.tan@intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tan Jui Nee <jui.nee.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441074171-23265-1-git-send-email-jui.nee.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spi-pxa2xx: Check status register to determine if SSSR_TINT is disabled

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

>From 02bc933ebb59208f42c2e6305b2c17fd306f695d Mon Sep 17 00:00:00 2001
From: "Tan, Jui Nee" <jui.nee.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date: Tue, 1 Sep 2015 10:22:51 +0800
Subject: [PATCH] spi: spi-pxa2xx: Check status register to determine if
 SSSR_TINT is disabled

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
Acked-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/spi/spi-pxa2xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 7293d6d875c5..8e4b1a7c37ce 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -643,6 +643,10 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 	if (!(sccr1_reg & SSCR1_TIE))
 		mask &= ~SSSR_TFS;
 
+	/* Ignore RX timeout interrupt if it is disabled */
+	if (!(sccr1_reg & SSCR1_TINTE))
+		mask &= ~SSSR_TINT;
+
 	if (!(status & mask))
 		return IRQ_NONE;
 
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
