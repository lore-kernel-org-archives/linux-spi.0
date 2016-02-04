From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 2/2] spi: pxa2xx: Fix too early chipselect deassert
Date: Thu,  4 Feb 2016 12:30:57 +0200
Message-ID: <1454581857-12921-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1454581857-12921-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1454581857-12921-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

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
---
For normal development cycle. This is not a fatal issue and I guess real SPI
slaves may not hickup because of it. But you never know.
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
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
