From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 10/28] Blackfin SPI: convert read/write/duplex funcs to a
	dedicated ops structure
Date: Sun, 17 Oct 2010 18:59:23 -0400
Message-ID: <1287356381-31495-11-git-send-email-vapier@gentoo.org>
References: <1287356381-31495-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1287356381-31495-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Rather than having to look up the same 3 sets of functions at the same
time, just use an ops structure so we only need to set one pointer.

Reported-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |   58 ++++++++++++++++++++++++--------------------
 1 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 40d9f64..b0de61a 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -42,6 +42,14 @@ MODULE_LICENSE("GPL");
 #define DONE_STATE	((void *)2)
 #define ERROR_STATE	((void *)-1)
 
+struct driver_data;
+
+struct transfer_ops {
+	void (*write) (struct driver_data *);
+	void (*read) (struct driver_data *);
+	void (*duplex) (struct driver_data *);
+};
+
 struct driver_data {
 	/* Driver model hookup */
 	struct platform_device *pdev;
@@ -94,9 +102,7 @@ struct driver_data {
 	size_t tx_map_len;
 	u8 n_bytes;
 	int cs_change;
-	void (*write) (struct driver_data *);
-	void (*read) (struct driver_data *);
-	void (*duplex) (struct driver_data *);
+	const struct transfer_ops *ops;
 };
 
 struct chip_data {
@@ -113,9 +119,7 @@ struct chip_data {
 	u32 cs_gpio;
 	u16 idle_tx_val;
 	u8 pio_interrupt;	/* use spi data irq */
-	void (*write) (struct driver_data *);
-	void (*read) (struct driver_data *);
-	void (*duplex) (struct driver_data *);
+	const struct transfer_ops *ops;
 };
 
 #define DEFINE_SPI_REG(reg, off) \
@@ -294,6 +298,12 @@ static void bfin_spi_u8_duplex(struct driver_data *drv_data)
 	}
 }
 
+static const struct transfer_ops bfin_transfer_ops_u8 = {
+	.write  = bfin_spi_u8_writer,
+	.read   = bfin_spi_u8_reader,
+	.duplex = bfin_spi_u8_duplex,
+};
+
 static void bfin_spi_u16_writer(struct driver_data *drv_data)
 {
 	/* clear RXS (we check for RXS inside the loop) */
@@ -342,6 +352,12 @@ static void bfin_spi_u16_duplex(struct driver_data *drv_data)
 	}
 }
 
+static const struct transfer_ops bfin_transfer_ops_u16 = {
+	.write  = bfin_spi_u16_writer,
+	.read   = bfin_spi_u16_reader,
+	.duplex = bfin_spi_u16_duplex,
+};
+
 /* test if ther is more transfer to be done */
 static void *bfin_spi_next_transfer(struct driver_data *drv_data)
 {
@@ -620,17 +636,13 @@ static void bfin_spi_pump_transfers(unsigned long data)
 	case 8:
 		drv_data->n_bytes = 1;
 		width = CFG_SPI_WORDSIZE8;
-		drv_data->read = bfin_spi_u8_reader;
-		drv_data->write = bfin_spi_u8_writer;
-		drv_data->duplex = bfin_spi_u8_duplex;
+		drv_data->ops = &bfin_transfer_ops_u8;
 		break;
 
 	case 16:
 		drv_data->n_bytes = 2;
 		width = CFG_SPI_WORDSIZE16;
-		drv_data->read = bfin_spi_u16_reader;
-		drv_data->write = bfin_spi_u16_writer;
-		drv_data->duplex = bfin_spi_u16_duplex;
+		drv_data->ops = &bfin_transfer_ops_u16;
 		break;
 
 	default:
@@ -638,9 +650,7 @@ static void bfin_spi_pump_transfers(unsigned long data)
 		transfer->bits_per_word = chip->bits_per_word;
 		drv_data->n_bytes = chip->n_bytes;
 		width = chip->width;
-		drv_data->write = chip->write;
-		drv_data->read = chip->read;
-		drv_data->duplex = chip->duplex;
+		drv_data->ops = chip->ops;
 		break;
 	}
 	cr = (read_CTRL(drv_data) & (~BIT_CTL_TIMOD));
@@ -653,8 +663,8 @@ static void bfin_spi_pump_transfers(unsigned long data)
 		drv_data->len = transfer->len;
 	}
 	dev_dbg(&drv_data->pdev->dev,
-		"transfer: drv_data->write is %p, chip->write is %p\n",
-		drv_data->write, chip->write);
+		"transfer: drv_data->ops is %p, chip->ops is %p, u8_ops is %p\n",
+		drv_data->ops, chip->ops, &bfin_transfer_ops_u8);
 
 	message->state = RUNNING_STATE;
 	dma_config = 0;
@@ -819,7 +829,7 @@ static void bfin_spi_pump_transfers(unsigned long data)
 		dev_dbg(&drv_data->pdev->dev,
 			"IO duplex: cr is 0x%x\n", cr);
 
-		drv_data->duplex(drv_data);
+		drv_data->ops->duplex(drv_data);
 
 		if (drv_data->tx != drv_data->tx_end)
 			tranf_success = 0;
@@ -828,7 +838,7 @@ static void bfin_spi_pump_transfers(unsigned long data)
 		dev_dbg(&drv_data->pdev->dev,
 			"IO write: cr is 0x%x\n", cr);
 
-		drv_data->write(drv_data);
+		drv_data->ops->write(drv_data);
 
 		if (drv_data->tx != drv_data->tx_end)
 			tranf_success = 0;
@@ -837,7 +847,7 @@ static void bfin_spi_pump_transfers(unsigned long data)
 		dev_dbg(&drv_data->pdev->dev,
 			"IO read: cr is 0x%x\n", cr);
 
-		drv_data->read(drv_data);
+		drv_data->ops->read(drv_data);
 		if (drv_data->rx != drv_data->rx_end)
 			tranf_success = 0;
 	}
@@ -1032,17 +1042,13 @@ static int bfin_spi_setup(struct spi_device *spi)
 	case 8:
 		chip->n_bytes = 1;
 		chip->width = CFG_SPI_WORDSIZE8;
-		chip->read = bfin_spi_u8_reader;
-		chip->write = bfin_spi_u8_writer;
-		chip->duplex = bfin_spi_u8_duplex;
+		chip->ops = &bfin_transfer_ops_u8;
 		break;
 
 	case 16:
 		chip->n_bytes = 2;
 		chip->width = CFG_SPI_WORDSIZE16;
-		chip->read = bfin_spi_u16_reader;
-		chip->write = bfin_spi_u16_writer;
-		chip->duplex = bfin_spi_u16_duplex;
+		chip->ops = &bfin_transfer_ops_u16;
 		break;
 
 	default:
-- 
1.7.3.1


------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
