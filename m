From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: [PATCH 12/12] spi: spi-fsl-dspi: Enable extended SPI mode
Date: Wed, 20 Jun 2018 09:34:42 +0200
Message-ID: <20180620073442.20913-13-esben.haabendal@gmail.com>
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

Set the XSPI bit for devices configured for XSPI mode (currently LS1021A),
and thereby switch to extended SPI mode, allowing for SPI transfers using
from 4 to 32 bits per word instead of 4 to 16 bits per word.

Signed-off-by: Esben Haabendal <eha@deif.com>
Cc: Martin Hundebøll <martin@geanix.com>
---
 drivers/spi/spi-fsl-dspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index eed55491b2c9..1f85dcdb2203 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -46,6 +46,7 @@
 #define SPI_MCR_PCSIS		(0x3F << 16)
 #define SPI_MCR_CLR_TXF	(1 << 11)
 #define SPI_MCR_CLR_RXF	(1 << 10)
+#define SPI_MCR_XSPI		(1 << 3)
 
 #define SPI_TCR			0x08
 #define SPI_TCR_GET_TCNT(x)	(((x) & 0xffff0000) >> 16)
@@ -968,7 +969,8 @@ static const struct regmap_config dspi_xspi_regmap_config[] = {
 
 static void dspi_init(struct fsl_dspi *dspi)
 {
-	regmap_write(dspi->regmap, SPI_MCR, SPI_MCR_MASTER | SPI_MCR_PCSIS);
+	regmap_write(dspi->regmap, SPI_MCR, SPI_MCR_MASTER | SPI_MCR_PCSIS |
+		     (dspi->devtype_data->xspi_mode ? SPI_MCR_XSPI : 0));
 	regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
 	if (dspi->devtype_data->xspi_mode)
 		regmap_write(dspi->regmap, SPI_CTARE(0),
-- 
2.17.1
