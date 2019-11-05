From: thor.thayer@linux.intel.com
Subject: [PATCH] spi: dw: Fix Designware SPI loopback
Date: Tue,  5 Nov 2019 14:22:10 -0600
Message-ID: <1572985330-5525-1-git-send-email-thor.thayer@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

The SPI_LOOP is set in spi->mode but not propagated to the register.
A previous patch removed the bit during a cleanup.

Fixes: e1bc204894ea ("spi: dw: fix potential variable assignment error")
Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 drivers/spi/spi-dw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 9a49e073e8b7..076652d3d051 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -308,7 +308,8 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	cr0 = (transfer->bits_per_word - 1)
 		| (chip->type << SPI_FRF_OFFSET)
 		| ((((spi->mode & SPI_CPOL) ? 1 : 0) << SPI_SCOL_OFFSET) |
-			(((spi->mode & SPI_CPHA) ? 1 : 0) << SPI_SCPH_OFFSET))
+			(((spi->mode & SPI_CPHA) ? 1 : 0) << SPI_SCPH_OFFSET) |
+			(((spi->mode & SPI_LOOP) ? 1 : 0) << SPI_SRL_OFFSET))
 		| (chip->tmode << SPI_TMOD_OFFSET);
 
 	/*
-- 
2.7.4
