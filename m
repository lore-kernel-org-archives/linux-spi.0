From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.24-rc1] at25 driver is for EEPROM
	not FLASH
Date: Wed, 24 Oct 2007 15:00:24 -0700
Message-ID: <20071024220024.76129239431@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Add comment to at25 driver that it's for EEPROM chips, not FLASH
chips ... the AT25 series has both types of chip, and sometimes
they're even pin-compatible.  The command sets are different, as
is the treatment of erasure.  (FLASH needs explicit erasure, but
with EEPROM it's implicit.)  Note that all vendors seem to have
this same confusion in their *25* series SPI memory parts.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
One person was about to forward patches teaching this driver how
to talk to a flash chip.  Such wasted efforts should be avoided.

 drivers/spi/at25.c |    7 +++++++
 1 files changed, 7 insertions(+)

--- a/drivers/spi/at25.c	2007-07-17 21:03:42.000000000 -0700
+++ b/drivers/spi/at25.c	2007-10-15 04:04:43.000000000 -0700
@@ -21,6 +21,13 @@
 #include <linux/spi/eeprom.h>
 
 
+/*
+ * NOTE: this is an *EEPROM* driver.  The vagaries of product naming
+ * mean that some AT25 products are EEPROMs, and others are FLASH.
+ * Handle FLASH chips with the drivers/mtd/devices/m25p80.c driver,
+ * not this one!
+ */
+
 struct at25_data {
 	struct spi_device	*spi;
 	struct mutex		lock;

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
