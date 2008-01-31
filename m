From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.24 3/6] spi_bfin: wait for tx to
	complete on some cs_chg paths
Date: Thu, 31 Jan 2008 12:19:11 -0800
Message-ID: <200801311219.11238.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

PBX 2 SPI devices need the nonstandard "cs change per word" mechanism.

This patch is one of three updating this driver to make the last data
bits get sent before advancing the transfer ... in this case, before
the chipselect gets deactivated.

Signed-off-by: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |   40 ++++++++++++----------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

--- g26.orig/drivers/spi/spi_bfin5xx.c	2008-01-31 11:51:59.000000000 -0800
+++ g26/drivers/spi/spi_bfin5xx.c	2008-01-31 11:52:00.000000000 -0800
@@ -294,16 +294,14 @@ static void u8_cs_chg_writer(struct driv
 {
 	struct chip_data *chip = drv_data->cur_chip;
 
-	/* poll for SPI completion before start */
-	while (!(read_STAT(drv_data) & BIT_STAT_SPIF))
-		cpu_relax();
-
 	while (drv_data->tx < drv_data->tx_end) {
 		cs_active(drv_data, chip);
 
 		write_TDBR(drv_data, (*(u8 *) (drv_data->tx)));
 		while (read_STAT(drv_data) & BIT_STAT_TXS)
 			cpu_relax();
+		while (!(read_STAT(drv_data) & BIT_STAT_SPIF))
+			cpu_relax();
 
 		cs_deactive(drv_data, chip);
 
@@ -342,31 +340,20 @@ static void u8_cs_chg_reader(struct driv
 {
 	struct chip_data *chip = drv_data->cur_chip;
 
-	/* poll for SPI completion before start */
-	while (!(read_STAT(drv_data) & BIT_STAT_SPIF))
-		cpu_relax();
-
-	/* clear TDBR buffer before read(else it will be shifted out) */
-	write_TDBR(drv_data, 0xFFFF);
+	while (drv_data->rx < drv_data->rx_end) {
+		cs_active(drv_data, chip);
+		read_RDBR(drv_data);	/* kick off */
 
-	cs_active(drv_data, chip);
-	dummy_read(drv_data);
+		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
+			cpu_relax();
+		while (!(read_STAT(drv_data) & BIT_STAT_SPIF))
+			cpu_relax();
 
-	while (drv_data->rx < drv_data->rx_end - 1) {
+		*(u8 *) (drv_data->rx) = read_SHAW(drv_data);
 		cs_deactive(drv_data, chip);
 
-		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
-			cpu_relax();
-		cs_active(drv_data, chip);
-		*(u8 *) (drv_data->rx) = read_RDBR(drv_data);
 		++drv_data->rx;
 	}
-	cs_deactive(drv_data, chip);
-
-	while (!(read_STAT(drv_data) & BIT_STAT_RXS))
-		cpu_relax();
-	*(u8 *) (drv_data->rx) = read_SHAW(drv_data);
-	++drv_data->rx;
 }
 
 static void u8_duplex(struct driver_data *drv_data)
@@ -392,15 +379,12 @@ static void u8_cs_chg_duplex(struct driv
 {
 	struct chip_data *chip = drv_data->cur_chip;
 
-	/* poll for SPI completion before start */
-	while (!(read_STAT(drv_data) & BIT_STAT_SPIF))
-		cpu_relax();
-
 	while (drv_data->rx < drv_data->rx_end) {
 		cs_active(drv_data, chip);
 
 		write_TDBR(drv_data, (*(u8 *) (drv_data->tx)));
-		while (read_STAT(drv_data) & BIT_STAT_TXS)
+
+		while (!(read_STAT(drv_data) & BIT_STAT_SPIF))
 			cpu_relax();
 		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
 			cpu_relax();

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
