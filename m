From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 07/28] Blackfin SPI: punt useless null
	read/write funcs
Date: Sun, 17 Oct 2010 18:59:20 -0400
Message-ID: <1287356381-31495-8-git-send-email-vapier@gentoo.org>
References: <1287356381-31495-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
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

The chip ops should always be initialized, so having null fallback
functions are useless.

Reported-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |   47 ++++----------------------------------------
 1 files changed, 5 insertions(+), 42 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index f4023a7..5e07f49 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -255,43 +255,6 @@ static inline void bfin_spi_dummy_read(struct driver_data *drv_data)
 	(void) read_RDBR(drv_data);
 }
 
-static void bfin_spi_null_writer(struct driver_data *drv_data)
-{
-	u8 n_bytes = drv_data->n_bytes;
-	u16 tx_val = drv_data->cur_chip->idle_tx_val;
-
-	/* clear RXS (we check for RXS inside the loop) */
-	bfin_spi_dummy_read(drv_data);
-
-	while (drv_data->tx < drv_data->tx_end) {
-		write_TDBR(drv_data, tx_val);
-		drv_data->tx += n_bytes;
-		/* wait until transfer finished.
-		   checking SPIF or TXS may not guarantee transfer completion */
-		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
-			cpu_relax();
-		/* discard RX data and clear RXS */
-		bfin_spi_dummy_read(drv_data);
-	}
-}
-
-static void bfin_spi_null_reader(struct driver_data *drv_data)
-{
-	u8 n_bytes = drv_data->n_bytes;
-	u16 tx_val = drv_data->cur_chip->idle_tx_val;
-
-	/* discard old RX data and clear RXS */
-	bfin_spi_dummy_read(drv_data);
-
-	while (drv_data->rx < drv_data->rx_end) {
-		write_TDBR(drv_data, tx_val);
-		drv_data->rx += n_bytes;
-		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
-			cpu_relax();
-		bfin_spi_dummy_read(drv_data);
-	}
-}
-
 static void bfin_spi_u8_writer(struct driver_data *drv_data)
 {
 	/* clear RXS (we check for RXS inside the loop) */
@@ -680,9 +643,9 @@ static void bfin_spi_pump_transfers(unsigned long data)
 		transfer->bits_per_word = chip->bits_per_word;
 		drv_data->n_bytes = chip->n_bytes;
 		width = chip->width;
-		drv_data->write = drv_data->tx ? chip->write : bfin_spi_null_writer;
-		drv_data->read = drv_data->rx ? chip->read : bfin_spi_null_reader;
-		drv_data->duplex = chip->duplex ? chip->duplex : bfin_spi_null_writer;
+		drv_data->write = chip->write;
+		drv_data->read = chip->read;
+		drv_data->duplex = chip->duplex;
 		break;
 	}
 	cr = (read_CTRL(drv_data) & (~BIT_CTL_TIMOD));
@@ -695,8 +658,8 @@ static void bfin_spi_pump_transfers(unsigned long data)
 		drv_data->len = transfer->len;
 	}
 	dev_dbg(&drv_data->pdev->dev,
-		"transfer: drv_data->write is %p, chip->write is %p, null_wr is %p\n",
-		drv_data->write, chip->write, bfin_spi_null_writer);
+		"transfer: drv_data->write is %p, chip->write is %p\n",
+		drv_data->write, chip->write);
 
 	/* speed and width has been set on per message */
 	message->state = RUNNING_STATE;
-- 
1.7.3.1
