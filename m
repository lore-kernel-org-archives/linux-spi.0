From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Fix too early chipselect deassert" to the spi tree
Date: Thu, 04 Feb 2016 12:16:24 +0000
Message-ID: <E1aRIpk-0001R1-U8@debutante>
References: <1454581857-12921-2-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Weifeng Voon <weifeng.voon-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1454581857-12921-2-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Fix too early chipselect deassert

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

>From 7a8d44bc89e5cddcd5c0704a11a90484d36ba6ba Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Thu, 4 Feb 2016 12:30:57 +0200
Subject: [PATCH] spi: pxa2xx: Fix too early chipselect deassert

There is a chance that chipselect is deasserted too early while the last
clock cycle is still running. Protocol analyzers will see this as a failed
last byte. This is more likely to occur with slow bitrates, for instance
at 25 kbps.

Reason for this is when using SPI mode 0 that both SPI host controller and
SPI slave will drive the data lines at the falling edge of clock signal
and sample at the rising edge. Receive FIFO gets the last bit now at the
rising edge and code sees transfer to be finished either by the interrupt
in PIO mode or by the DMA completion in DMA mode.

The SSP Time Out register SSTO should take care of delaying the
completion but it does not seems to have effect at least on Intel
Skylake and Broxton even when using long enough values. Depending on
timing code may get into point where chipselect is deasserted while the
last clock cycle is still running at its second half cycle.

Fix this by adding a wait loop in giveback() that waits until SSP becomes
idle before deasserting the chipselect.

Reported-by: Weifeng Voon <weifeng.voon-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 9b9a528a9fbd..ce66cf44bba5 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -496,6 +496,7 @@ static void giveback(struct driver_data *drv_data)
 {
 	struct spi_transfer* last_transfer;
 	struct spi_message *msg;
+	unsigned long timeout;
 
 	msg = drv_data->cur_msg;
 	drv_data->cur_msg = NULL;
@@ -508,6 +509,12 @@ static void giveback(struct driver_data *drv_data)
 	if (last_transfer->delay_usecs)
 		udelay(last_transfer->delay_usecs);
 
+	/* Wait until SSP becomes idle before deasserting the CS */
+	timeout = jiffies + msecs_to_jiffies(10);
+	while (pxa2xx_spi_read(drv_data, SSSR) & SSSR_BSY &&
+	       !time_after(jiffies, timeout))
+		cpu_relax();
+
 	/* Drop chip select UNLESS cs_change is true or we are returning
 	 * a message with an error, or next message is for another chip
 	 */
-- 
2.7.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
