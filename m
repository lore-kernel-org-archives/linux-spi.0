From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Subject: [PATCH 2/2] spi: rspi: Fix typo when clearing SPSR_OVRF
Date: Mon, 23 Dec 2013 19:34:24 +0100
Message-ID: <1387823664-32318-2-git-send-email-geert+renesas@linux-m68k.org>
References: <1387823664-32318-1-git-send-email-geert+renesas@linux-m68k.org>
Cc: linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1387823664-32318-1-git-send-email-geert+renesas@linux-m68k.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The overrun flag should be cleared in the SPI Status Register, not in the
SPI Control Register, based on the SDK sample code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 drivers/spi/spi-rspi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 9e0301014f48..b04835d809f5 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -517,7 +517,7 @@ static void rspi_receive_init(struct rspi_data *rspi)
 		rspi_read16(rspi, RSPI_SPDR);	/* dummy read */
 	if (spsr & SPSR_OVRF)
 		rspi_write8(rspi, rspi_read8(rspi, RSPI_SPSR) & ~SPSR_OVRF,
-			    RSPI_SPCR);
+			    RSPI_SPSR);
 }
 
 static int rspi_receive_pio(struct rspi_data *rspi, struct spi_message *mesg,
-- 
1.7.9.5

