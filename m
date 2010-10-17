From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 05/28] Blackfin SPI: fix CS handling
Date: Sun, 17 Oct 2010 18:59:18 -0400
Message-ID: <1287356381-31495-6-git-send-email-vapier@gentoo.org>
References: <1287356381-31495-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org,
        Barry Song <barry.song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1287356381-31495-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Barry Song <barry.song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

The CS helper functions were toggling both the Flag Enable and the Flag
Value bits, but the Flag Value bit is ignored if the corresponding Flag
Enable bit is cleared.  So under high speed transactions, the CS sometimes
would not toggle properly.

Since it makes no sense to toggle the Flag Enable bit dynamically when we
actually want to control the Flag Value, do this when setting up the device
and then only handle toggling of the CS value during runtime.

Signed-off-by: Barry Song <barry.song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |   33 +++++++++++++++++++++++++++------
 1 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 3736c35..6150a8c 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -188,8 +188,7 @@ static void bfin_spi_cs_active(struct driver_data *drv_data, struct chip_data *c
 	if (likely(chip->chip_select_num)) {
 		u16 flag = read_FLAG(drv_data);
 
-		flag |= chip->flag;
-		flag &= ~(chip->flag << 8);
+		flag &= ~chip->flag;
 
 		write_FLAG(drv_data, flag);
 	} else {
@@ -202,8 +201,7 @@ static void bfin_spi_cs_deactive(struct driver_data *drv_data, struct chip_data
 	if (likely(chip->chip_select_num)) {
 		u16 flag = read_FLAG(drv_data);
 
-		flag &= ~chip->flag;
-		flag |= (chip->flag << 8);
+		flag |= chip->flag;
 
 		write_FLAG(drv_data, flag);
 	} else {
@@ -215,6 +213,25 @@ static void bfin_spi_cs_deactive(struct driver_data *drv_data, struct chip_data
 		udelay(chip->cs_chg_udelay);
 }
 
+/* enable or disable the pin muxed by GPIO and SPI CS to work as SPI CS */
+static inline void bfin_spi_cs_enable(struct driver_data *drv_data, struct chip_data *chip)
+{
+	u16 flag = read_FLAG(drv_data);
+
+	flag |= (chip->flag >> 8);
+
+	write_FLAG(drv_data, flag);
+}
+
+static inline void bfin_spi_cs_disable(struct driver_data *drv_data, struct chip_data *chip)
+{
+	u16 flag = read_FLAG(drv_data);
+
+	flag &= ~(chip->flag >> 8);
+
+	write_FLAG(drv_data, flag);
+}
+
 /* stop controller and re-config current chip*/
 static void bfin_spi_restore_state(struct driver_data *drv_data)
 {
@@ -1169,7 +1186,7 @@ static int bfin_spi_setup(struct spi_device *spi)
 	 * SPI_BAUD, not the real baudrate
 	 */
 	chip->baud = hz_to_spi_baud(spi->max_speed_hz);
-	chip->flag = 1 << (spi->chip_select);
+	chip->flag = (1 << (spi->chip_select)) << 8;
 	chip->chip_select_num = spi->chip_select;
 
 	switch (chip->bits_per_word) {
@@ -1268,6 +1285,7 @@ static int bfin_spi_setup(struct spi_device *spi)
 		}
 	}
 
+	bfin_spi_cs_enable(drv_data, chip);
 	bfin_spi_cs_deactive(drv_data, chip);
 
 	return 0;
@@ -1299,14 +1317,17 @@ static int bfin_spi_setup(struct spi_device *spi)
 static void bfin_spi_cleanup(struct spi_device *spi)
 {
 	struct chip_data *chip = spi_get_ctldata(spi);
+	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
 
 	if (!chip)
 		return;
 
 	if ((chip->chip_select_num > 0)
-		&& (chip->chip_select_num <= spi->master->num_chipselect))
+		&& (chip->chip_select_num <= spi->master->num_chipselect)) {
 		peripheral_free(ssel[spi->master->bus_num]
 					[chip->chip_select_num-1]);
+		bfin_spi_cs_disable(drv_data, chip);
+	}
 
 	if (chip->chip_select_num == 0)
 		gpio_free(chip->cs_gpio);
-- 
1.7.3.1
