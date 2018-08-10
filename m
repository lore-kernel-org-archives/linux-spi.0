From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] spi: davinci: fix a NULL pointer dereference
Date: Fri, 10 Aug 2018 11:13:52 +0200
Message-ID: <20180810091352.30227-1-brgl@bgdev.pl>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

On non-OF systems spi->controlled_data may be NULL. This causes a NULL
pointer derefence on dm365-evm.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/spi/spi-davinci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 577084bb911b..a02099c90c5c 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -217,7 +217,7 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
 	pdata = &dspi->pdata;
 
 	/* program delay transfers if tx_delay is non zero */
-	if (spicfg->wdelay)
+	if (spicfg && spicfg->wdelay)
 		spidat1 |= SPIDAT1_WDEL;
 
 	/*
-- 
2.18.0
