From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.23-rc1] spi kerneldoc update
Date: Tue, 24 Jul 2007 14:14:17 -0700
Message-ID: <200707241414.17209.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This adds kerneldoc to the SPI framework. The "spi_driver"
and "spi_board_info" structs were previously not described.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 include/linux/spi/spi.h |   58 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

--- g26.orig/include/linux/spi/spi.h	2007-07-24 14:02:26.000000000 -0700
+++ g26/include/linux/spi/spi.h	2007-07-24 14:04:23.000000000 -0700
@@ -138,6 +138,32 @@ struct spi_message;
 
 
 
+/**
+ * struct spi_driver - Host side "protocol" driver
+ * @probe: Binds this driver to the spi device.  Drivers can verify
+ *	that the device is actually present, and may need to configure
+ *	characteristics (such as bits_per_word) which weren't needed for
+ *	the initial configuration done during system setup.
+ * @remove: Unbinds this driver from the spi device
+ * @shutdown: Standard shutdown callback used during system state
+ *	transitions such as powerdown/halt and kexec
+ * @suspend: Standard suspend callback used during system state transitions
+ * @resume: Standard resume callback used during system state transitions
+ * @driver: SPI device drivers should initialize the name and owner
+ *	field of this structure.
+ *
+ * This represents the kind of device driver that uses SPI messages to
+ * interact with the hardware at the other end of a SPI link.  It's called
+ * a "protocol" driver because it works through messages rather than talking
+ * directly to SPI hardware (which is what the underlying SPI controller
+ * driver does to pass those messages).  These protocols are defined in the
+ * specification for the device(s) supported by the driver.
+ *
+ * As a rule, those device protocols represent the lowest level interface
+ * supported by a driver, and it will support upper level interfaces too.
+ * Examples of such upper levels include frameworks like MTD, networking,
+ * MMC, RTC, filesystem character device nodes, and hardware monitoring.
+ */
 struct spi_driver {
 	int			(*probe)(struct spi_device *spi);
 	int			(*remove)(struct spi_device *spi);
@@ -667,7 +693,37 @@ static inline ssize_t spi_w8r16(struct s
  * parport adapters, or microcontrollers acting as USB-to-SPI bridges.
  */
 
-/* board-specific information about each SPI device */
+/**
+ * struct spi_board_info - board-specific template for a SPI device
+ * @modalias: Initializes spi_device.modalias; identifies the driver.
+ * @platform_data: Initializes spi_device.platform_data; the particular
+ *	data stored there is driver-specific.
+ * @controller_data: Initializes spi_device.controller_data; some
+ *	controllers need hints about hardware setup, e.g. for DMA.
+ * @irq: Initializes spi_device.irq; depends on how the board is wired.
+ * @max_speed_hz: Initializes spi_device.max_speed_hz; based on limits
+ *	from the chip datasheet and board-specific signal quality issues.
+ * @bus_num: Identifies which spi_master parents the spi_device; unused
+ *	by spi_new_device(), and otherwise depends on board wiring.
+ * @chip_select: Initializes spi_device.chip_select; depends on how
+ *	the board is wired.
+ * @mode: Initializes spi_device.mode; based on the chip datasheet, board
+ *	wiring (some devices support both 3WIRE and standard modes), and
+ *	possibly presence of an inverter in the chipselect path.
+ *
+ * When adding new SPI devices to the device tree, these structures serve
+ * as a partial device template.  They hold information which can't always
+ * be determined by drivers.  Information that probe() can establish (such
+ * as the default transfer wordsize) is not included here.
+ *
+ * These structures are used in two places.  Their primary role is to
+ * be stored in tables of board-specific device descriptors, which are
+ * declared early in board initialization and then used (much later) to
+ * populate a controller's device tree after the that controller's driver
+ * initializes.  A secondary (and atypical) role is as a parameter to
+ * spi_new_device() call, which happens after those controller drivers
+ * are active in some dynamic board configuration models.
+ */
 struct spi_board_info {
 	/* the device name and module name are coupled, like platform_bus;
 	 * "modalias" is normally the driver name.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
