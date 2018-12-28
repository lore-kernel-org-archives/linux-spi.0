From: shaftarger <sholchen@gmail.com>
Subject: [PATCH] spi: dw: fix potential variable assignment error
Date: Fri, 28 Dec 2018 16:33:12 +0800
Message-ID: <20181228083312.14928-1-shol@livemail.tw>
Cc: shaftarger <shol@livemail.tw>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

spi::mode is defined by framework for several SPI capabilities,
such as polarity, phase, bit-endian, wire number. Directly use this
variable for setting controller's polarity and phase causes other
bit in register being set. Since SPI framework has its definition,
SPI_CPOL and SPI_CPHA offset may be changed by framwork change.
Instead of just mask off the relevant bits,
fetch required bit in spi::mode and set to register.

Signed-off-by: shaftarger <shol@livemail.tw>
---
 drivers/spi/spi-dw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index b705f2bdb8b9..1c4cb6e8c5a1 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -317,7 +317,8 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	/* Default SPI mode is SCPOL = 0, SCPH = 0 */
 	cr0 = (transfer->bits_per_word - 1)
 		| (chip->type << SPI_FRF_OFFSET)
-		| (spi->mode << SPI_MODE_OFFSET)
+		| ((((spi->mode & SPI_CPOL) ? 1 : 0) << SPI_SCOL_OFFSET) |
+			(((spi->mode & SPI_CPHA) ? 1 : 0) << SPI_SCPH_OFFSET))
 		| (chip->tmode << SPI_TMOD_OFFSET);
 
 	/*
-- 
2.12.2.windows.2
