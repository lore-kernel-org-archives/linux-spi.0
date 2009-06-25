From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [PATCH] SST25L (non JEDEC) SPI Flash driver
Date: Thu, 25 Jun 2009 15:07:17 +1200
Message-ID: <4A42E9E5.60802@bluewatersys.com>
References: <4A42BDF3.10901@bluewatersys.com> <20090624194005.2f9574ce.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Walleij <linus.ml.walleij@gmail.com>,
	linux kernel <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net,
	David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757544AbZFYDFF@vger.kernel.org>
In-Reply-To: <20090624194005.2f9574ce.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Andrew Morton wrote:
> On Thu, 25 Jun 2009 11:59:47 +1200 Ryan Mallon <ryan@bluewatersys.com> wrote:
>
>   
>> Add support for the non JEDEC SST25L SPI Flash devices.
>>
>> Signed-off-by: Andre Renaud <andre@bluewatersys.com>
>> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
>> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
>>     
>
> It looks OK to my inexperienced eye.
>
>   
Cool, thanks for picking this up. The patch below fixes the two issues
you pointed out. It will apply on top of
mtd-sst25l-non-jedec-spi-flash-driver-update.patch

----
Fix two issues in the SSTL25 driver:
- Replace min() plus u32 cast with min_t
- Fix memory leak on failed add_mtd_device

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
----

diff --git a/drivers/mtd/devices/sst25l.c b/drivers/mtd/devices/sst25l.c
index 777fadf..d235067 100644
--- a/drivers/mtd/devices/sst25l.c
+++ b/drivers/mtd/devices/sst25l.c
@@ -298,7 +298,7 @@ static int sst25l_write(struct mtd_info *mtd, loff_t to, size_t len,
 		 * Write the remaining bytes using auto address
 		 * increment mode
 		 */
-		bytes = min(mtd->writesize, (u32)(len - i));
+		bytes = min_t(u32, mtd->writesize, len - i);
 		for (j = 1; j < bytes; j++, copied++) {
 			ret = sst25l_wait_till_ready(flash);
 			if (ret)
@@ -367,7 +367,7 @@ static int __init sst25l_probe(struct spi_device *spi)
 	struct flash_info *flash_info;
 	struct sst25l_flash *flash;
 	struct flash_platform_data *data;
-	int i;
+	int ret, i;
 
 	flash_info = sst25l_match_device(spi);
 	if (!flash_info)
@@ -457,7 +457,14 @@ static int __init sst25l_probe(struct spi_device *spi)
 			 data->nr_parts, data->name);
 	}
 
-	return add_mtd_device(&flash->mtd) == 1 ? -ENODEV : 0;
+	ret = add_mtd_device(&flash->mtd);
+	if (ret == 1) {
+		kfree(flash);
+		dev_set_drvdata(&spi->dev, NULL);
+		return -ENODEV;
+	}
+	
+	return 0;
 }
 
 static int __exit sst25l_remove(struct spi_device *spi)
