From: Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 3/3] spi: spi-axi: fix potential use-after-free after deregistration
Date: Mon, 30 Oct 2017 11:35:27 +0100
Message-ID: <20171030103527.13535-3-johan@kernel.org>
References: <20171030103527.13535-1-johan@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171030103527.13535-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Take an extra reference to the controller before deregistering it to
prevent use-after-free in the interrupt handler in case an interrupt
fires before the line is disabled.

Fixes: b1353d1c1d45 ("spi: Add Analog Devices AXI SPI Engine controller support")
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
---

v2
 - Add Fixes tag and update commit message to reflect that this is a
   potential issue also for this driver (and not just for drivers using
   shared interrupts) as noted by Lars-Peter.


 drivers/spi/spi-axi-spi-engine.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 6ab4c7700228..68cfc351b47f 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -553,7 +553,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 
 static int spi_engine_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
+	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
 	struct spi_engine *spi_engine = spi_master_get_devdata(master);
 	int irq = platform_get_irq(pdev, 0);
 
@@ -561,6 +561,8 @@ static int spi_engine_remove(struct platform_device *pdev)
 
 	free_irq(irq, master);
 
+	spi_master_put(master);
+
 	writel_relaxed(0xff, spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
 	writel_relaxed(0x00, spi_engine->base + SPI_ENGINE_REG_INT_ENABLE);
 	writel_relaxed(0x01, spi_engine->base + SPI_ENGINE_REG_RESET);
-- 
2.14.3
