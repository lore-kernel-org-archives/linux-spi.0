From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: core: allow defining time that cs is deasserted" to the
 spi tree
Date: Wed,  8 May 2019 10:34:54 +0100 (BST)
Message-ID: <20190508093455.0BE15440010@finisterre.sirena.org.uk>
References: <20190223084952.14758-2-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190223084952.14758-2-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: core: allow defining time that cs is deasserted

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

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

>From 0ff2de8bb163551ec4230a5a6f3c40c1f6adec4f Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Date: Sat, 23 Feb 2019 08:49:48 +0000
Subject: [PATCH] spi: core: allow defining time that cs is deasserted

For some SPI devices that support speed_hz > 1MHz the default 10 us delay
when cs_change = 1 is typically way to long and may result in poor spi bus
utilization.

This patch makes it possible to control the delay at micro or nano second
resolution on a per spi_transfer basis. It even allows an "as fast as
possible" mode with:
    xfer.cs_change_delay_unit = SPI_DELAY_UNIT_NSECS;
    xfer.cs_change_delay = 0;

The delay code is shared between delay_usecs and cs_change_delay for
consistency and reuse, so in the future this change_delay_unit could also
apply to delay_usec as well.

Note that on slower SOCs/CPU actually reaching ns deasserts on cs is not
realistic as the gpio overhead alone (without any delays added ) may
already leave cs deasserted for more than 1us - at least on a raspberry pi.
But at the very least this way we can keep it as short as possible.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c       | 59 ++++++++++++++++++++++++++++++++++-------
 include/linux/spi/spi.h |  7 +++++
 2 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5e75944ad5d1..7e8ffe3fdc00 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1090,6 +1090,52 @@ static int spi_transfer_wait(struct spi_controller *ctlr,
 	return 0;
 }
 
+static void _spi_transfer_delay_ns(u32 ns)
+{
+	if (!ns)
+		return;
+	if (ns <= 1000) {
+		ndelay(ns);
+	} else {
+		u32 us = DIV_ROUND_UP(ns, 1000);
+
+		if (us <= 10)
+			udelay(us);
+		else
+			usleep_range(us, us + DIV_ROUND_UP(us, 10));
+	}
+}
+
+static void _spi_transfer_cs_change_delay(struct spi_message *msg,
+					  struct spi_transfer *xfer)
+{
+	u32 delay = xfer->cs_change_delay;
+	u32 unit = xfer->cs_change_delay_unit;
+
+	/* return early on "fast" mode - for everything but USECS */
+	if (!delay && unit != SPI_DELAY_UNIT_USECS)
+		return;
+
+	switch (unit) {
+	case SPI_DELAY_UNIT_USECS:
+		/* for compatibility use default of 10us */
+		if (!delay)
+			delay = 10000;
+		else
+			delay *= 1000;
+		break;
+	case SPI_DELAY_UNIT_NSECS: /* nothing to do here */
+		break;
+	default:
+		dev_err_once(&msg->spi->dev,
+			     "Use of unsupported delay unit %i, using default of 10us\n",
+			     xfer->cs_change_delay_unit);
+		delay = 10000;
+	}
+	/* now sleep for the requested amount of time */
+	_spi_transfer_delay_ns(delay);
+}
+
 /*
  * spi_transfer_one_message - Default implementation of transfer_one_message()
  *
@@ -1148,14 +1194,8 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 		if (msg->status != -EINPROGRESS)
 			goto out;
 
-		if (xfer->delay_usecs) {
-			u16 us = xfer->delay_usecs;
-
-			if (us <= 10)
-				udelay(us);
-			else
-				usleep_range(us, us + DIV_ROUND_UP(us, 10));
-		}
+		if (xfer->delay_usecs)
+			_spi_transfer_delay_ns(xfer->delay_usecs * 1000);
 
 		if (xfer->cs_change) {
 			if (list_is_last(&xfer->transfer_list,
@@ -1163,7 +1203,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 				keep_cs = true;
 			} else {
 				spi_set_cs(msg->spi, false);
-				udelay(10);
+				_spi_transfer_cs_change_delay(msg, xfer);
 				spi_set_cs(msg->spi, true);
 			}
 		}
@@ -3757,4 +3797,3 @@ static int __init spi_init(void)
  * include needing to have boardinfo data structures be much more public.
  */
 postcore_initcall(spi_init);
-
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 053abd22ad31..023beb9e9e4b 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -735,6 +735,9 @@ extern void spi_res_release(struct spi_controller *ctlr,
  * @bits_per_word: select a bits_per_word other than the device default
  *      for this transfer. If 0 the default (from @spi_device) is used.
  * @cs_change: affects chipselect after this transfer completes
+ * @cs_change_delay: delay between cs deassert and assert when
+ *      @cs_change is set and @spi_transfer is not the last in @spi_message
+ * @cs_change_delay_unit: unit of cs_change_delay
  * @delay_usecs: microseconds to delay after this transfer before
  *	(optionally) changing the chipselect status, then starting
  *	the next transfer or completing this @spi_message.
@@ -824,6 +827,10 @@ struct spi_transfer {
 	u8		bits_per_word;
 	u8		word_delay_usecs;
 	u16		delay_usecs;
+	u16		cs_change_delay;
+	u8		cs_change_delay_unit;
+#define SPI_DELAY_UNIT_USECS	0
+#define SPI_DELAY_UNIT_NSECS	1
 	u32		speed_hz;
 	u16		word_delay;
 
-- 
2.20.1
