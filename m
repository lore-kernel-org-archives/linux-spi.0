From: Qiujun Huang <hqjagain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: update the structure documentation
Date: Tue, 10 Mar 2020 01:16:19 +0800
Message-ID: <1583774179-30736-1-git-send-email-hqjagain@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Qiujun Huang <hqjagain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

some members were not described in documentation.

Signed-off-by: Qiujun Huang <hqjagain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 include/linux/spi/spi.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 6d16ba0..2f28692 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -135,6 +135,8 @@ struct spi_delay {
  * @modalias: Name of the driver to use with this device, or an alias
  *	for that name.  This appears in the sysfs "modalias" attribute
  *	for driver coldplugging, and in uevents used for hotplugging
+ * @driver_override: If the name of a driver is written to this attribute, then
+ *	the device will bind to the named driver and only the named driver.
  * @cs_gpio: LEGACY: gpio number of the chipselect line (optional, -ENOENT when
  *	not using a GPIO line) use cs_gpiod in new drivers by opting in on
  *	the spi_master.
@@ -443,6 +445,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *	@spi_transfer->ptp_sts_word_post were transmitted.
  *	If the driver does not set this, the SPI core takes the snapshot as
  *	close to the driver hand-over as possible.
+ * @irq_flags: Interrupt enable state during PTP system timestamping
  *
  * Each SPI controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
-- 
1.8.3.1
