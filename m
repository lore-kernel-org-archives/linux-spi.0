From: Manuel Stahl <manuel.stahl-GeUHRtUQU7nSyEMIgutvibNAH6kLmebB@public.gmane.org>
Subject: [PATCH] spi: atmel-spi fix cs_change behaviour
Date: Tue, 16 Mar 2010 16:22:59 +0100
Message-ID: <4B9FA253.5030109@iis.fraunhofer.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040409040203070909060000"
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This is a multi-part message in MIME format.
--------------040409040203070909060000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

There is a problem in the cs_change behaviour in atmel-spi.

In include/linux/spi/spi.h it says:

Chipselect stays active during the entire message
(unless modified by spi_transfer.cs_change != 0).

The last parameter in atmel_spi_msg_done is named stay, so it must be 
called with inverted cs_change value.

--- a/drivers/spi/atmel_spi.c
+++ b/drivers/spi/atmel_spi.c
@@ -501,7 +501,7 @@ atmel_spi_interrupt(int irq, void *dev_id)
  			if (atmel_spi_xfer_is_last(msg, xfer)) {
  				/* report completed message */
  				atmel_spi_msg_done(master, as, msg, 0,
-						xfer->cs_change);
+						!xfer->cs_change);
  			} else {
  				if (xfer->cs_change) {
  					cs_deactivate(as, msg->spi);

--------------040409040203070909060000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--------------040409040203070909060000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--------------040409040203070909060000--
