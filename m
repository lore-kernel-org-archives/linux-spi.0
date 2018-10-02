From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] spi: at91-usart: Remove duplicated checking for spi->bits_per_word
Date: Tue,  2 Oct 2018 18:10:10 +0800
Message-ID: <20181002101010.29723-1-axel.lin@ingics.com>
Cc: Mark Brown <broonie@kernel.org>,
        Radu Pirea <radu.pirea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Lee Jones <lee.jones@linaro.org>, linux-spi@vger.kernel.org,
        Axel Lin <axel.lin@ingics.com>
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This checking is already done in __spi_validate_bits_per_word().

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/spi/spi-at91-usart.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index a924657642fa..519853f14934 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -176,12 +176,6 @@ static int at91_usart_spi_setup(struct spi_device *spi)
 	struct at91_usart_spi *aus = spi_master_get_devdata(spi->controller);
 	u32 *ausd = spi->controller_state;
 	unsigned int mr = at91_usart_spi_readl(aus, MR);
-	u8 bits = spi->bits_per_word;
-
-	if (bits != 8) {
-		dev_dbg(&spi->dev, "Only 8 bits per word are supported\n");
-		return -EINVAL;
-	}
 
 	if (spi->mode & SPI_CPOL)
 		mr |= US_MR_CPOL;
@@ -210,7 +204,7 @@ static int at91_usart_spi_setup(struct spi_device *spi)
 
 	dev_dbg(&spi->dev,
 		"setup: bpw %u mode 0x%x -> mr %d %08x\n",
-		bits, spi->mode, spi->chip_select, mr);
+		spi->bits_per_word, spi->mode, spi->chip_select, mr);
 
 	return 0;
 }
-- 
2.17.1
