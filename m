From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 -next] spi: fix spi-sprd-adi build errors when
 SPI_SPRD_ADI=y and HWSPINLOCK=m
Date: Thu, 21 Sep 2017 11:02:31 -0700
Message-ID: <ed5b8ca2-b853-755d-2801-57cc0b626508@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors when CONFIG_HWSPINLOCK=m and SPI_SPRD_ADI=y.
That combination is not allowed.

drivers/spi/spi-sprd-adi.o: In function `sprd_adi_remove':
spi-sprd-adi.c:(.text+0x13): undefined reference to `hwspin_lock_free'
drivers/spi/spi-sprd-adi.o: In function `sprd_adi_probe':
spi-sprd-adi.c:(.text+0xf5): undefined reference to `of_hwspin_lock_get_id'
spi-sprd-adi.c:(.text+0x107): undefined reference to `hwspin_lock_request_specific'
spi-sprd-adi.c:(.text+0x22e): undefined reference to `hwspin_lock_free'
drivers/spi/spi-sprd-adi.o: In function `sprd_adi_transfer_one':
spi-sprd-adi.c:(.text+0x2eb): undefined reference to `__hwspin_lock_timeout'
spi-sprd-adi.c:(.text+0x349): undefined reference to `__hwspin_unlock'
spi-sprd-adi.c:(.text+0x389): undefined reference to `__hwspin_lock_timeout'
spi-sprd-adi.c:(.text+0x3ee): undefined reference to `__hwspin_unlock'

v2: allow build with or without HWSPINLOCK, but restrict to =m
if HWSPINLOCK=m.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Baolin Wang <Baolin.Wang@spreadtrum.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
---
 drivers/spi/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20170921.orig/drivers/spi/Kconfig
+++ linux-next-20170921/drivers/spi/Kconfig
@@ -625,6 +625,7 @@ config SPI_SIRF
 config SPI_SPRD_ADI
 	tristate "Spreadtrum ADI controller"
 	depends on ARCH_SPRD || COMPILE_TEST
+	depends on HWSPINLOCK || HWSPINLOCK=n
 	help
 	  ADI driver based on SPI for Spreadtrum SoCs.
 
