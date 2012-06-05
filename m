From: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] coldfire-qspi: Add support for the Coldfire 5251/5253.
Date: Tue, 5 Jun 2012 09:24:59 -0700
Message-ID: <201206050924.59579.sfking@fdwdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Greg Ungerer <gerg-XXXsiaCtIV5Wk0Htik3J/w@public.gmane.org>,
	uClinux development list <uclinux-dev-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
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
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The Coldfire 5251/5253 have a QSPI controller.  Enable selection of the 
coldfire-qspi driver if the M525x is selected.

Signed-off-by: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index cd2fe35..cb90bc6 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -125,7 +125,7 @@ config SPI_BUTTERFLY
 
 config SPI_COLDFIRE_QSPI
 	tristate "Freescale Coldfire QSPI controller"
-	depends on (M520x || M523x || M5249 || M527x || M528x || M532x)
+	depends on (M520x || M523x || M5249 || M525x || M527x || M528x || M532x)
 	help
 	  This enables support for the Coldfire QSPI controller in master
 	  mode.

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
