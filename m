From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v2 2/2] spi: davinci: use dev_err() for error reporting
Date: Thu, 10 Dec 2015 21:59:05 +0530
Message-ID: <83b3c0bb63ff958d10c773ab7bf128393cc7ddad.1449764266.git.nsekhar@ti.com>
References: <cover.1449764266.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Grygorii Strashko <grygorii.strashko@ti.com>,
	<linux-kernel@vger.kernel.org>,
	Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
	<linux-spi@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1449764266.git.nsekhar@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Use dev_err() for reporting errors rather than
dev_dbg().

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/spi/spi-davinci.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 57d6960a6252..fddb7a3be322 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -477,33 +477,33 @@ static int davinci_spi_check_error(struct davinci_spi *dspi, int int_status)
 	struct device *sdev = dspi->bitbang.master->dev.parent;
 
 	if (int_status & SPIFLG_TIMEOUT_MASK) {
-		dev_dbg(sdev, "SPI Time-out Error\n");
+		dev_err(sdev, "SPI Time-out Error\n");
 		return -ETIMEDOUT;
 	}
 	if (int_status & SPIFLG_DESYNC_MASK) {
-		dev_dbg(sdev, "SPI Desynchronization Error\n");
+		dev_err(sdev, "SPI Desynchronization Error\n");
 		return -EIO;
 	}
 	if (int_status & SPIFLG_BITERR_MASK) {
-		dev_dbg(sdev, "SPI Bit error\n");
+		dev_err(sdev, "SPI Bit error\n");
 		return -EIO;
 	}
 
 	if (dspi->version == SPI_VERSION_2) {
 		if (int_status & SPIFLG_DLEN_ERR_MASK) {
-			dev_dbg(sdev, "SPI Data Length Error\n");
+			dev_err(sdev, "SPI Data Length Error\n");
 			return -EIO;
 		}
 		if (int_status & SPIFLG_PARERR_MASK) {
-			dev_dbg(sdev, "SPI Parity Error\n");
+			dev_err(sdev, "SPI Parity Error\n");
 			return -EIO;
 		}
 		if (int_status & SPIFLG_OVRRUN_MASK) {
-			dev_dbg(sdev, "SPI Data Overrun error\n");
+			dev_err(sdev, "SPI Data Overrun error\n");
 			return -EIO;
 		}
 		if (int_status & SPIFLG_BUF_INIT_ACTIVE_MASK) {
-			dev_dbg(sdev, "SPI Buffer Init Active\n");
+			dev_err(sdev, "SPI Buffer Init Active\n");
 			return -EBUSY;
 		}
 	}
-- 
2.6.3
