From: Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] NUC900: add spi resource plaform_data
	structure initialization
Date: Mon, 23 Nov 2009 15:48:51 +0800
Message-ID: <4B0A3E63.1080904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Brownell-sourceforge <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	linux-spi <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Russell K
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

Dear Russell,

Add spi resource plaform_data structure initialization.

Signed-off-by: Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
 arch/arm/mach-w90x900/dev.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-w90x900/dev.c b/arch/arm/mach-w90x900/dev.c
index 2a6f98d..51f17b7 100644
--- a/arch/arm/mach-w90x900/dev.c
+++ b/arch/arm/mach-w90x900/dev.c
@@ -32,6 +32,7 @@
 #include <asm/mach-types.h>
 
 #include <mach/regs-serial.h>
+#include <mach/nuc900_spi.h>
 #include <mach/map.h>
 
 #include "cpu.h"
@@ -196,6 +197,18 @@ static struct platform_device nuc900_device_emc = {
 
 /* SPI device */
 
+static struct w90p910_spi_info nuc900_spiflash_data = {
+	.num_cs		= 1,
+	.lsb		= 0,
+	.txneg		= 1,
+	.rxneg		= 0,
+	.divider	= 24,
+	.sleep		= 0,
+	.txnum		= 0,
+	.txbitlen	= 1,
+	.bus_num	= 0,
+};
+
 static struct resource nuc900_spi_resource[] = {
 	[0] = {
 		.start = W90X900_PA_I2C + SPIOFFSET,
@@ -214,6 +227,9 @@ static struct platform_device nuc900_device_spi = {
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(nuc900_spi_resource),
 	.resource	= nuc900_spi_resource,
+	.dev		= {
+				.platform_data = &nuc900_spiflash_data,
+			}
 };
 
 /* spi device, spi flash info */
-- 
1.5.6.3

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
