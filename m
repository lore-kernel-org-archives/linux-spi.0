From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [PATCH] fixup s3c24xx build after arch moves
Date: Tue, 24 Jul 2007 13:43:27 +0100
Message-ID: <20070724124327.GA3496@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Fix the include files moved around during the
s3c24xx arch moves.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

diff -urpN -X linux-2.6.22-git16-moves1/Documentation/dontdiff linux-2.6.22-git16-moves1/drivers/spi/spi_s3c24xx.c linux-2.6.22-git16-moves1-fixups-split-moves2-fixup/drivers/spi/spi_s3c24xx.c
--- linux-2.6.22-git16-moves1/drivers/spi/spi_s3c24xx.c	2007-07-21 15:13:30.000000000 +0100
+++ linux-2.6.22-git16-moves1-fixups-split-moves2-fixup/drivers/spi/spi_s3c24xx.c	2007-07-22 14:21:50.000000000 +0100
@@ -28,7 +28,7 @@
 #include <asm/hardware.h>
 
 #include <asm/arch/regs-gpio.h>
-#include <asm/arch/regs-spi.h>
+#include <asm/plat-s3c24xx/regs-spi.h>
 #include <asm/arch/spi.h>
 
 struct s3c24xx_spi {

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
