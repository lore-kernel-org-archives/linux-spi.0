From: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: [PATCH] mtd: sst25l: fix reads with broken spi-masters
Date: Mon, 10 Jan 2011 15:21:40 -0600
Message-ID: <0D753D10438DA54287A00B027084269764CDF4146A__2942.57422579012$1294696170$gmane$org@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Artem.Bityutskiy-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <Artem.Bityutskiy-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>,
	"dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
To: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-ge
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Some spi masters (ep93xx) have limitations when using the SFRMOUT
signal for the chip select.  The SFRMOUT signal is only asserted
as long as the transmit fifo contains data.  As soon as the last
bit is clocked into the receive fifo it gets deasserted.

The chip select line to the SST25L must remain asserted for the
duration of the Read cycle.  If it gets deasserted the command
gets aborted.

To handle these broken masters, implement an alternate read method 
that uses the fifo_size information, passed from the platform data,
to make sure the command+data message always fits into the spi fifo.
This insures that the messages will always complete correctly.

Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Artem Bityutskiy <Artem.Bityutskiy-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

---

This patch is needed in order to read from the SPI flash on the
EDB93xx series dev boards.  Without it any read from the device will
return 0x00.

diff --git a/drivers/mtd/devices/sst25l.c b/drivers/mtd/devices/sst25l.c
index c163e61..864bd20 100644
--- a/drivers/mtd/devices/sst25l.c
+++ b/drivers/mtd/devices/sst25l.c
@@ -54,6 +54,10 @@ struct sst25l_flash {
 	struct mtd_info		mtd;
 
 	int 			partitioned;
+
+	bool			use_fifo;
+	int			fifo_size;
+	unsigned char		*bounce_buf;
 };
 
 struct flash_info {
@@ -269,6 +273,79 @@ static int sst25l_read(struct mtd_info *mtd, loff_t from, size_t len,
 	return 0;
 }
 
+static int sst25l_read_use_fifo(struct mtd_info *mtd, loff_t from, size_t len,
+				size_t *retlen, unsigned char *buf)
+{
+	struct sst25l_flash *flash = to_sst25l_flash(mtd);
+	struct spi_message message;
+	struct spi_transfer transfer;
+	loff_t addr;
+	size_t count;
+	int xfer_size = flash->fifo_size - 4;
+	int ret, i;
+
+	/* Sanity checking */
+	if (len == 0)
+		return 0;
+
+	if (from + len > flash->mtd.size)
+		return -EINVAL;
+
+	if (retlen)
+		*retlen = 0;
+
+	mutex_lock(&flash->lock);
+
+	/* Wait for previous write/erase to complete */
+	ret = sst25l_wait_till_ready(flash);
+	if (ret) {
+		mutex_unlock(&flash->lock);
+		return ret;
+	}
+
+	for (addr = from, count = 0; addr < from + len; addr += xfer_size) {
+		spi_message_init(&message);
+		memset(&transfer, 0, sizeof(transfer));
+
+		/* Fill the bounce buffer with known data */
+		memset(flash->bounce_buf, 0xff, flash->fifo_size);
+
+		/*
+		 * Send the 4 byte Read command and read back as much
+		 * data as possible (fifo_size - 4) into the bounce buffer.
+		 */
+		flash->bounce_buf[0] = SST25L_CMD_READ;
+		flash->bounce_buf[1] = addr >> 16;
+		flash->bounce_buf[2] = addr >> 8;
+		flash->bounce_buf[3] = addr;
+
+		transfer.tx_buf = flash->bounce_buf;
+		transfer.rx_buf = flash->bounce_buf;
+		transfer.len = flash->fifo_size;
+		spi_message_add_tail(&transfer, &message);
+		ret = spi_sync(flash->spi, &message);
+		if (ret < 0) {
+			mutex_unlock(&flash->lock);
+			return ret;
+		}
+
+		/*
+		 * Copy the read data from the bounce buffer to the
+		 * passed buffer.  Don't overflow the passed buffer.
+		 */
+		for (i = 0; i < xfer_size; i++) {
+			if (count < len)
+				buf[count++] = flash->bounce_buf[4+i];
+		}
+	}
+
+	if (retlen)
+		*retlen += count;
+
+	mutex_unlock(&flash->lock);
+	return 0;
+}
+
 static int sst25l_write(struct mtd_info *mtd, loff_t to, size_t len,
 			size_t *retlen, const unsigned char *buf)
 {
@@ -400,13 +477,25 @@ static int __devinit sst25l_probe(struct spi_device *spi)
 	else
 		flash->mtd.name = dev_name(&spi->dev);
 
+	flash->use_fifo		= data->use_fifo;
+	flash->fifo_size	= data->fifo_size;
+
 	flash->mtd.type		= MTD_NORFLASH;
 	flash->mtd.flags	= MTD_CAP_NORFLASH;
 	flash->mtd.erasesize	= flash_info->erase_size;
 	flash->mtd.writesize	= flash_info->page_size;
 	flash->mtd.size		= flash_info->page_size * flash_info->nr_pages;
 	flash->mtd.erase	= sst25l_erase;
-	flash->mtd.read		= sst25l_read;
+	if (flash->use_fifo) {
+		flash->bounce_buf = kzalloc(flash->fifo_size, GFP_KERNEL);
+		if (!flash->bounce_buf) {
+			ret = -ENOMEM;
+			goto err;
+		}
+		flash->mtd.read = sst25l_read_use_fifo;
+	} else {
+		flash->mtd.read	= sst25l_read;
+	}
 	flash->mtd.write 	= sst25l_write;
 
 	dev_info(&spi->dev, "%s (%lld KiB)\n", flash_info->name,
@@ -461,12 +550,17 @@ static int __devinit sst25l_probe(struct spi_device *spi)
 
 	ret = add_mtd_device(&flash->mtd);
 	if (ret == 1) {
-		kfree(flash);
-		dev_set_drvdata(&spi->dev, NULL);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err;
 	}
 
 	return 0;
+
+err:
+	kfree(flash->bounce_buf);
+	kfree(flash);
+	dev_set_drvdata(&spi->dev, NULL);
+	return ret;
 }
 
 static int __exit sst25l_remove(struct spi_device *spi)
@@ -478,8 +572,10 @@ static int __exit sst25l_remove(struct spi_device *spi)
 		ret = del_mtd_partitions(&flash->mtd);
 	else
 		ret = del_mtd_device(&flash->mtd);
-	if (ret == 0)
+	if (ret == 0) {
+		kfree(flash->bounce_buf);
 		kfree(flash);
+	}
 	return ret;
 }
 
diff --git a/include/linux/spi/flash.h b/include/linux/spi/flash.h
index 3f22932..8524221 100644
--- a/include/linux/spi/flash.h
+++ b/include/linux/spi/flash.h
@@ -10,6 +10,10 @@ struct mtd_partition;
  * @nr_parts: number of mtd_partitions for static partitoning
  * @type: optional flash device type (e.g. m25p80 vs m25p64), for use
  *	with chips that can't be queried for JEDEC or other IDs
+ * @use_fifo: optional flag to read/write data using the SPI master's
+ *	fifo limitations (for broken SPI masters that deassert the
+ *	chip select during multi-part transfers)
+ * @fifo_size: optional fifo size used with broken SPI masters
  *
  * Board init code (in arch/.../mach-xxx/board-yyy.c files) can
  * provide information about SPI flash parts (such as DataFlash) to
@@ -25,6 +29,9 @@ struct flash_platform_data {
 
 	char		*type;
 
+	bool		use_fifo;
+	int		fifo_size;
+
 	/* we'll likely add more ... use JEDEC IDs, etc */
 };
 
------------------------------------------------------------------------------
Gaining the trust of online customers is vital for the success of any company
that requires sensitive data to be transmitted over the Web.   Learn how to 
best implement a security strategy that keeps consumers' information secure 
and instills the confidence they need to proceed with transactions.
http://p.sf.net/sfu/oracle-sfdevnl 
