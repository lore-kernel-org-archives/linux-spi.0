From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: [PATCH 01/12] spi: spi-fsl-dspi: Drop unreachable else if statement
Date: Wed, 20 Jun 2018 09:34:31 +0200
Message-ID: <20180620073442.20913-2-esben.haabendal@gmail.com>
References: <20180620073442.20913-1-esben.haabendal@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
        Angelo Dureghello <angelo@sysam.it>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Yuan Yao <yao.yuan@nxp.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180620073442.20913-1-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Esben Haabendal <eha@deif.com>

The if statement just above this if/else statement triggers on the same
condition, and then invalidates it.

Signed-off-by: Esben Haabendal <eha@deif.com>
Cc: Martin Hundebøll <martin@geanix.com>
---
 drivers/spi/spi-fsl-dspi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 0630962ce442..3ca9b9608801 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -593,8 +593,7 @@ static int dspi_eoq_write(struct fsl_dspi *dspi)
 			dspi_pushr |= SPI_PUSHR_EOQ;
 			if ((dspi->cs_change) && (!dspi->len))
 				dspi_pushr &= ~SPI_PUSHR_CONT;
-		} else if (tx_word && (dspi->len == 1))
-			dspi_pushr |= SPI_PUSHR_EOQ;
+		}
 
 		regmap_write(dspi->regmap, SPI_PUSHR, dspi_pushr);
 
-- 
2.17.1
