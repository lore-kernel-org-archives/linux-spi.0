From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.31-rc1] eeprom/at25: bugfix "not
	ready" timeout after write
Date: Fri, 3 Jul 2009 18:36:27 -0700
Message-ID: <200907031836.28475.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Sebastian Heutling <heutling-U9zb0o/1OQCELgA04lAiVw@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
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

From: Sebastian Heutling <heutling-U9zb0o/1OQCELgA04lAiVw@public.gmane.org>

Under certain circumstances msleep(1) within the loop, which waits
for the EEPROM to be finished, might take longer than the timeout.
On the next loop the status register might now return to be ready
and therefore the loop finishes. The following check now tests if
a timeout occurred and if so returns an error although the device
reported it was ready.

This fix replaces testing the occurrence of the timeout by testing
the "not ready" bit in the status register.

Signed-off-by: Sebastian Heutling <heutling-U9zb0o/1OQCELgA04lAiVw@public.gmane.org> 
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/misc/eeprom/at25.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -173,6 +173,7 @@ at25_ee_write(struct at25_data *at25, co
 		unsigned	segment;
 		unsigned	offset = (unsigned) off;
 		u8		*cp = bounce + 1;
+		int		sr;
 
 		*cp = AT25_WREN;
 		status = spi_write(at25->spi, cp, 1);
@@ -214,7 +215,6 @@ at25_ee_write(struct at25_data *at25, co
 		timeout = jiffies + msecs_to_jiffies(EE_TIMEOUT);
 		retries = 0;
 		do {
-			int	sr;
 
 			sr = spi_w8r8(at25->spi, AT25_RDSR);
 			if (sr < 0 || (sr & AT25_SR_nRDY)) {
@@ -228,7 +228,7 @@ at25_ee_write(struct at25_data *at25, co
 				break;
 		} while (retries++ < 3 || time_before_eq(jiffies, timeout));
 
-		if (time_after(jiffies, timeout)) {
+		if ((sr < 0) || (sr & AT25_SR_nRDY)) {
 			dev_err(&at25->spi->dev,
 				"write %d bytes offset %d, "
 				"timeout after %u msecs\n",

------------------------------------------------------------------------------
