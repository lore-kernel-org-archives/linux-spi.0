From: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 15/20] Blackfin SPI Driver: fix bug -
	spi controller driver does not assert/deassert CS correctly
Date: Fri,  6 Feb 2009 15:13:03 +0800
Message-ID: <1233904388-5765-16-git-send-email-cooloney@kernel.org>
References: <1233904388-5765-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Yi Li <yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1233904388-5765-1-git-send-email-cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Yi Li <yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

This bug can be observed when two SPI devices are sharing the spi bus:
One device is set as SPI CS 7, another one is using SPI CS 4.

In spi_bfin5xx.c: cs_active(), cs_deactive() are used to control SPI_FLG
register. From the debug bellow:

cs_active: flag: 0x7f91, chip->flag: 0x7f80, cs: 7
cs_active: flag: 0xef91, chip->flag: 0xef10, cs: 4

When device A (cs_7) activate CS 7, SPI_FLG is set as 0x7f91 (however,
SPI_FLG should be set as 0x7f80, or 0x6f91 if in broadcast mode).

Due to some HW bug (very possibly), if SPI_FLG is set as 0x7f91,
SPISSEL7 is asserted, however SPISSEL4 will be asserted too (I can see
this using the scope). This is unreasonable according to HRM.

Signed-off-by: Yi Li <yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Acked-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index d8c4be1..ed6a4c1 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -189,6 +189,7 @@ static void cs_deactive(struct driver_data *drv_data, struct chip_data *chip)
 {
 	u16 flag = read_FLAG(drv_data);
 
+	flag &= ~chip->flag;
 	flag |= (chip->flag << 8);
 
 	write_FLAG(drv_data, flag);
@@ -1036,7 +1037,6 @@ static int setup(struct spi_device *spi)
 	struct bfin5xx_spi_chip *chip_info = NULL;
 	struct chip_data *chip;
 	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
-	u8 spi_flg;
 
 	/* Abort device setup if requested features are not supported */
 	if (spi->mode & ~(SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST)) {
@@ -1119,8 +1119,7 @@ static int setup(struct spi_device *spi)
 	 * SPI_BAUD, not the real baudrate
 	 */
 	chip->baud = hz_to_spi_baud(spi->max_speed_hz);
-	spi_flg = ~(1 << (spi->chip_select));
-	chip->flag = ((u16) spi_flg << 8) | (1 << (spi->chip_select));
+	chip->flag = 1 << (spi->chip_select);
 	chip->chip_select_num = spi->chip_select;
 
 	switch (chip->bits_per_word) {
-- 
1.5.6.3

------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
