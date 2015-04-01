From: Chen Gang <xili_gchen_5257@hotmail.com>
Subject: [PATCH] spi: spi-bfin5xx: Initialize cr_width in bfin_spi_pump_transfers()
Date: Thu, 2 Apr 2015 03:03:33 +0800
Message-ID: <BLU436-SMTP1172BE3B8CDF9C6A7CC89CCB9F30@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

cr_width may be not initialized before using by cr, the related warning
(with defconfig under blackfin by gcc5):

    CC      drivers/spi/spi-bfin5xx.o
  drivers/spi/spi-bfin5xx.c: In function 'bfin_spi_pump_transfers':
  drivers/spi/spi-bfin5xx.c:655:5: warning: 'cr_width' may be used uninitialized in this function [-Wmaybe-uninitialized]
    cr |= cr_width;
       ^

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 drivers/spi/spi-bfin5xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bfin5xx.c b/drivers/spi/spi-bfin5xx.c
index 3707993..a3d65b4 100644
--- a/drivers/spi/spi-bfin5xx.c
+++ b/drivers/spi/spi-bfin5xx.c
@@ -559,7 +559,7 @@ static void bfin_spi_pump_transfers(unsigned long data)
 	struct spi_transfer *previous = NULL;
 	struct bfin_spi_slave_data *chip = NULL;
 	unsigned int bits_per_word;
-	u16 cr, cr_width, dma_width, dma_config;
+	u16 cr, cr_width = 0, dma_width, dma_config;
 	u32 tranf_success = 1;
 	u8 full_duplex = 0;
 
@@ -648,7 +648,6 @@ static void bfin_spi_pump_transfers(unsigned long data)
 	} else if (bits_per_word == 8) {
 		drv_data->n_bytes = bits_per_word/8;
 		drv_data->len = transfer->len;
-		cr_width = 0;
 		drv_data->ops = &bfin_bfin_spi_transfer_ops_u8;
 	}
 	cr = bfin_read(&drv_data->regs->ctl) & ~(BIT_CTL_TIMOD | BIT_CTL_WORDSIZE);
-- 
1.9.3
