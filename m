From: Colin King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: [PATCH] spi: stm32: fix error check on mbr being -ve
Date: Thu, 22 Jun 2017 17:34:49 +0100
Message-ID: <20170622163449.23925-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>

The error check of mbr < 0 is always false because mbr is a u32. Make
mbt an int so that a -ve error return from stm32_spi_prepare_mbr can be
detected.

Detected by CoverityScan, CID#1446586 ("Unsigned compared against 0")

Signed-off-by: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
---
 drivers/spi/spi-stm32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index b75909e7b117..82a6616f46b8 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -857,7 +857,7 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 	}
 
 	if (spi->cur_speed != transfer->speed_hz) {
-		u32 mbr;
+		int mbr;
 
 		/* Update spi->cur_speed with real clock speed */
 		mbr = stm32_spi_prepare_mbr(spi, transfer->speed_hz);
@@ -869,7 +869,7 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 		transfer->speed_hz = spi->cur_speed;
 
 		cfg1_clrb |= SPI_CFG1_MBR;
-		cfg1_setb |= (mbr << SPI_CFG1_MBR_SHIFT) & SPI_CFG1_MBR;
+		cfg1_setb |= ((u32)mbr << SPI_CFG1_MBR_SHIFT) & SPI_CFG1_MBR;
 	}
 
 	if (cfg1_clrb || cfg1_setb)
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
