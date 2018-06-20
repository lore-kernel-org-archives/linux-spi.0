From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: [PATCH 11/12] spi: spi-fsl-dspi: Advertise 32 bit for XSPI mode
Date: Wed, 20 Jun 2018 09:34:41 +0200
Message-ID: <20180620073442.20913-12-esben.haabendal@gmail.com>
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

Signed-off-by: Esben Haabendal <eha@deif.com>
Cc: Martin Hundebøll <martin@geanix.com>
---
 drivers/spi/spi-fsl-dspi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 67cd2e901255..eed55491b2c9 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1001,7 +1001,6 @@ static int dspi_probe(struct platform_device *pdev)
 
 	master->cleanup = dspi_cleanup;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
 
 	pdata = dev_get_platdata(&pdev->dev);
 	if (pdata) {
@@ -1033,6 +1032,11 @@ static int dspi_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (dspi->devtype_data->xspi_mode)
+		master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
+	else
+		master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base)) {
-- 
2.17.1
