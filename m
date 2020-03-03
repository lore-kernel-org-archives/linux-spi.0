From: David Bauer <mail-YgwEh8z+B+JYon68uE86FQ@public.gmane.org>
Subject: [PATCH] spi: ath79: remove spi-master setup and cleanup assignment
Date: Tue,  3 Mar 2020 22:56:18 +0100
Message-ID: <20200303215618.21255-1-mail@david-bauer.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This removes the assignment of setup and cleanup functions for the ath79
target. Assigning the setup-method will lead to 'setup_transfer' not
being assigned in spi_bitbang_init. Because of this, performing any
TX/RX operation will lead to a kernel oops.

Also drop the redundant cleanup assignment, as it's also assigned in
spi_bitbang_init.

Signed-off-by: David Bauer <mail-YgwEh8z+B+JYon68uE86FQ@public.gmane.org>
---
 drivers/spi/spi-ath79.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index eb9a243e9526..ae6baaba8a07 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -156,8 +156,6 @@ static int ath79_spi_probe(struct platform_device *pdev)
 
 	master->use_gpio_descriptors = true;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
-	master->setup = spi_bitbang_setup;
-	master->cleanup = spi_bitbang_cleanup;
 	if (pdata) {
 		master->bus_num = pdata->bus_num;
 		master->num_chipselect = pdata->num_chipselect;
-- 
2.25.1
