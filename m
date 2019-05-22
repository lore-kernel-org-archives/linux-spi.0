From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 032/317] spi: atmel-quadspi: fix crash while suspending
Date: Wed, 22 May 2019 15:18:53 -0400
Message-ID: <20190522192338.23715-32-sashal@kernel.org>
References: <20190522192338.23715-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190522192338.23715-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

[ Upstream commit e5c27498a0403b270620b1a8a0a66e3efc222fb6 ]

atmel_qspi objects are kept in spi_controller objects, so, first get
pointer to spi_controller object and then get atmel_qspi object from
spi_controller object.

Fixes: 2d30ac5ed633 ("mtd: spi-nor: atmel-quadspi: Use spi-mem interface for atmel-quadspi driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/atmel-quadspi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index ddc7124108125..ec6e9970d7750 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -506,7 +506,8 @@ static int atmel_qspi_remove(struct platform_device *pdev)
 
 static int __maybe_unused atmel_qspi_suspend(struct device *dev)
 {
-	struct atmel_qspi *aq = dev_get_drvdata(dev);
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
 
 	clk_disable_unprepare(aq->clk);
 
@@ -515,7 +516,8 @@ static int __maybe_unused atmel_qspi_suspend(struct device *dev)
 
 static int __maybe_unused atmel_qspi_resume(struct device *dev)
 {
-	struct atmel_qspi *aq = dev_get_drvdata(dev);
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
 
 	clk_prepare_enable(aq->clk);
 
-- 
2.20.1
